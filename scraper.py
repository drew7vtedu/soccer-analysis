import pandas as pd
from bs4 import BeautifulSoup
import requests
import re
import argparse
import os
import pdb
from pathlib import Path
import sys

sys.path.append('.')

class Scraper:

    def __init__(self, args: object, **kwargs) -> None:
        self.args = args
        self._init_kwargs(kwargs)
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

    @staticmethod
    def init_command_line_args():
        """
        Create command line arguments for base class and return parser
        """
        parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)

        parser.add_argument('--fbref_url', type=str, required=False, default="https://fbref.com/en/comps/9/Premier-League-Stats", help='fbref url to request data from')

        return parser

    def _init_kwargs(self, kwargs):
        """
        Overwrite this method in a subclass to add additional command line arguments
        """
        pass


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
            name = row.find('td',{"data-stat":"squad"}).text.strip().encode().decode("utf-8")
            url = row.find('td',{"data-stat":"squad"}).find('a')['href']
            result[name] = url
        return result 

    def _request_fbref(self, url):
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

    def _get_all_headers(self, soup):
        """
        a method to get all table headers from a league page
        with several tables
        takes:
            soup containing page html

        returns:
            a list containing all table column headers
        """
        all_headers = []
        for p in soup.find_all('thead'):
            if p.class_!='over_header':
                all_headers.append(p)
        h_list = []

        for i in all_headers:
            row = i.find_all('th')
            r = []
            for cell in row:
                r.append(cell.text.strip().encode().decode("utf-8"))
            h_list.append(r)
        return h_list

    def _scrape_table(self, table_soup, headers):
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
                current_row.append(cell.text.strip().encode().decode("utf-8"))
            result.append(current_row)
        try:
            return pd.DataFrame(result, columns=headers)
        except:
            headers.insert(0,'Rk')
            while len(headers) > len(result[0]):
                headers = headers[1:]           
            return pd.DataFrame(result, columns=headers)


        
    def _clean_soup(self, content):
        """
        what does this do I wrote this so long ago
        """
        for tags in content.find_all("tr", class_="over_header"):
            tags.attrs = {}
        return content

    