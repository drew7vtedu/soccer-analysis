import pandas as pd
import numpy as np
from bs4 import BeautifulSoup
import requests
import re
import argparse
import os
import pdb
from pathlib import Path

class Scraper:

    def __init__(self):
        self.table_names = [
        'league_table',
        'standard_stats',
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


    def _get_league_headers(self, soup):
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


    def _clean_soup(self, content):
        """
        what does this do I wrote this so long ago
        """
        for tags in content.find_all("tr", class_="over_header"):
            tags.attrs = {}
        return content


    def drop_top_headers(self, header_list):
        """
        Drop the top level of a multi-header table
        """
        bruh = []
        for h in header_list:
            last_blank = 0
            for i in range(len(h)):

                if h[i] == '':
                    last_blank = i
            h = h[last_blank+1::]
            bruh.append(h)
        return bruh
    
    def save_data(self, df, fname):
        """
        Save a DataFrame to the given filename
        """
        path = f'data/raw/{fname}.csv'
        mode = 'w'

        myfile = Path(path)
        myfile.touch(exist_ok=True)

        with open(myfile, mode) as outfile:
            df.to_csv(outfile, mode, index=False)

    def main(self):
        soup = self._request_fbref("https://fbref.com/en/comps/9/Premier-League-Stats")
        team_urls = self.scrape_teams_and_urls(soup)
        
        tables = soup.find_all('tbody')

        headers = self._get_league_headers(soup)
        headers = self.drop_top_headers(headers)
        headers[1].insert(1, 'comp')
        headers[-1].insert(0, 'Rk')


        for i in range(len(tables)):
            if i % 2 == 0:
                t = self._scrape_table(tables[i], headers[i])
                # self.save_data(t, f"teams/{self.table_names[i // 2]}")
                if i // 2 < len(self.table_names):
                    t.to_csv(f"data/raw/teams/{self.table_names[i // 2]}.csv", index=False)
                else:
                    break
        


if __name__ == '__main__':
    scraper = Scraper()
    scraper.main()