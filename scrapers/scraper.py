from bdb import set_trace
from cgitb import reset
import pandas as pd
from bs4 import BeautifulSoup
import requests
import re
import argparse
import os
import pdb
from pathlib import Path
import sys
import yaml
from sqlalchemy import create_engine

class Scraper:

    def __init__(self, args: object, **kwargs) -> None:
        self.args = args
        self.table_names = [
        'standard_stats',
        'scores_and_fixtures',
        'goalkeeping',
        'advanced_goalkeeping',
        'shooting',
        'passing',
        'pass_types',
        'goal_and_shot_creation',
        'defensive_actions',
        'possession',
        'playing_time',
        'miscellaneous_stats'
        ]
        self.config = self.load_config(self.args.config_path)
        self.sql_conn_str = f"postgresql+psycopg2://{self.config['sql_user']}:{self.config['sql_password']}@localhost:{self.config['sql_port']}/premier_league_data"
        self.raw_data_path = 'data/raw/'
        self.proc_data_path = 'data/processed/'

    def load_config(self, config_path) -> dict:
        """
        loads a file at the given path as a dictionary
        """
        with open(config_path, 'r') as file:
            return yaml.safe_load(file)

    @staticmethod
    def init_command_line_args():
        """
        Create command line arguments for base class and return parser
        """
        parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)

        parser.add_argument('--config_path', type=str, required=False, default='_config_.yaml', help='Path to the config file to load.')
        parser.add_argument('--update_db', action='store_true', required=False, default=False, help='Include this argument to push results to the database.')
        parser.add_argument('--use_cached_data', action='store_true', required=False, default=False, help='Include this argument to push cached data rather than scrape new data.')
        parser.add_argument('--filter_teams', action='store_true', required=False, default=False, help='Include this argument to limit the teams scraped to the list in config["teams"].')

        return parser

    def push_to_sql(self, df: pd.DataFrame, table_name: str):
        """
        Push a dataframe to the given table name in PostGres
        """
        engine = create_engine(self.sql_conn_str)
        with engine.connect() as conn:
            df.to_sql(table_name, conn, index=False, if_exists='append')

    def scrape_teams_and_urls(self, soup):
        """
        a method to scrape team names and urls to find
        player data for each team
        takes:
            bs4 soup containing a league page from fbref

        returns:
            a dictionary with team names as keys and
            corresponding urls as values
        """
        tables = soup.find_all('tbody')

        rows = tables[0].find_all('tr')

        result = dict()
        for row in rows:
            name = row.find('td',{"data-stat":"squad"}).text.strip().encode().decode("utf-8").replace("\'", '') # Fixes issue with teams like Nott'ham Forest
            url = row.find('td',{"data-stat":"squad"}).find('a')['href']
            result[name] = url
        return result 

    def _request_fbref_(self, url):
        """
        get soup from fbref.com

        returns:
            a dictionary with team names as keys and
            corresponding urls as values
        """
        r = requests.get(url)
        comm = re.compile("<!--|-->")
        soup = BeautifulSoup(comm.sub("",r.text),'lxml')

        return soup

    def load_cached_data(self, push_to_db):
        """
        Load data which has been saved in csvs.
        """
        dir = os.listdir(self.args.raw_data_path)
        for team in dir:
            teams = os.listdir(self.args.raw_data_path + team)
            csvs = [x for x in teams if '.csv' in x]
            for file in csvs:
                df = pd.read_csv(self.raw_data_path+team+file)
                if push_to_db:
                    self.push_to_sql(df, file[:-4])

    def _clean_header_(self, header: str) -> str:
        """
        remove problematic patterns from headers
        """
        result = header
        result = result.replace('90s', 'full_90s')
        result = result.replace('(', '')
        result = result.replace(')', '')
        result = result.replace('1/3', 'final_third')
        result = result.replace(':', '')
        result = result.replace('xg+/-', '_plus_minus')
        result = result.replace('xg+/-90', '_plus_minus_per_90')
        result = result.replace('+/-', '_plus_minus')
        result = result.replace('+', '_plus_')
        result = result.replace('-', '_minus_')
        result = result.replace('/', '_per_')
        result = result.replace('%', '_pct')
        result = result.replace('#', 'num_')
        if result == 'int':
            return 'interceptions'

        result = result.replace('__', '_')

        return result

    def _get_all_headers_(self, soup):
        """
        a method to get all table headers from a league page
        with several tables
        takes:
            soup containing page html

        returns:
            a list containing all table column headers
        """
        all_headers = []
        for tabl_header in soup.find_all('thead'):
            header_rows = tabl_header.find_all('tr')
            if len(header_rows) == 2:
                over_headers = []
                # get over headers
                for cell in header_rows[0].find_all('th'):
                    try:
                        colspan = int(cell.get('colspan'))
                        text = cell.text.strip().encode().decode("utf-8")
                        for i in range(colspan):
                            over_headers.append(text.replace(' ', '_').lower())
                    except:
                        # this occurs when there is a single <th></th>
                        over_headers.append('')
                # add over headers to lower headers as prefix
                lower_header = header_rows[1].find_all('th')
                assert len(over_headers) == len(lower_header), f'header row lengths do not match. upper: {len(over_headers)}, lewer: {len(lower_header)}'
                row = []
                for i in range(len(lower_header)):
                    text = lower_header[i].text.strip().encode().decode("utf-8").replace(' ', '_').lower()
                    if over_headers[i] != '':
                        text = over_headers[i] + '_' + text
                    row.append(self._clean_header_(text))
                all_headers.append(row)
            elif len(header_rows) == 1:
                all_headers.append([self._clean_header_(x.text.strip().encode().decode("utf-8").replace(' ', '_').lower()) for x in header_rows[0].find_all('th')])
            elif len(header_rows > 2):
                print('more than 2 rows')
        
        return all_headers

    def _scrape_table_(self, table_soup, headers):
        """
        a method to scrape a table from fbref
        takes:
            soup containing a table
            a list containing header names for each column

        returns:
            a dataframe containing all the data from the given table
        """
        result = []

        rows = table_soup.find_all('tr')
        for row in rows:
            current_row = []
            for cell in row:
                cell_text = cell.text.strip().encode().decode("utf-8")
                if cell_text == '':
                    cell_text = None
                current_row.append(cell_text)
            result.append(current_row)
        try:
            return pd.DataFrame(result, columns=headers)
        except:
            headers.insert(0,'Rk')
            while len(headers) > len(result[0]):
                headers = headers[1:]           
            return pd.DataFrame(result, columns=headers)

    def string_num_to_int(self, val: str) -> int:
        """
        Convert string numbers in the form '30,100' to ints i.e. 30100
        """
        if val is None:
            return val
        return int(val.replace(',', ''))
        
    def _clean_soup_(self, content):
        """
        what does this do I wrote this so long ago
        """
        for tags in content.find_all("tr", class_="over_header"):
            tags.attrs = {}
        return content

    