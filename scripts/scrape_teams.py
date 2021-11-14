import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path

sys.path.append('.')
from scraper import Scraper

class TeamScraper(Scraper):

    def __init__(self, args):
        super().__init__(args)
        self.table_names.insert(0, 'league_table')
    
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
        soup = self._request_fbref(url)
        
        tables = soup.find_all('tbody')

        headers = self._get_all_headers(soup)
        headers[1].insert(1, 'comp')
        headers[-1].insert(0, 'Rk')


        for i in range(len(tables)):
            if i % 2 == 0:
                t = self._scrape_table(tables[i], headers[i])
                if i // 2 < len(self.table_names):
                    t.to_csv(f"data/raw/teams/{self.table_names[i // 2]}.csv", index=False)
                else:
                    break
        


if __name__ == '__main__':
    args = TeamScraper.init_command_line_args().parse_args()
    scraper = TeamScraper(args)
    scraper.main(args.fbref_url)