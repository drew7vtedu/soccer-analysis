import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path

from scraper import Scraper

class TeamScraper(Scraper):

    def __init__(self, args):
        super().__init__(args)
        opponent_table_names = ['opponent_stats_' + x for x in self.table_names]
        table_names = []
        for tup in zip(self.table_names, opponent_table_names):
            table_names.append(tup[0])
            table_names.append(tup[1])
        self.table_names = table_names
        self.table_names = ['squad_' + x for x in self.table_names]
        
        self.table_names.insert(0, 'league_table')
        self.table_names.insert(1, 'home_away_league_table',)
        pdb.set_trace()
    
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

    def main(self, url):
        soup = self._request_fbref_(url)
        pdb.set_trace()
        
        tables = soup.find_all('tbody')

        headers = self._get_all_headers_(soup)
        # headers[1].insert(1, 'comp')
        # headers[-1].insert(0, 'Rk')

        for i in range(len(tables)):
            t = self._scrape_table_(tables[i], headers[i])
            t.to_csv(f"{self.args.raw_data_path}/{self.table_names[i]}.csv", index=False)
        


if __name__ == '__main__':
    args = TeamScraper.init_command_line_args().parse_args()
    scraper = TeamScraper(args)
    scraper.main(args.fbref_url)