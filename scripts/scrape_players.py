import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path
import os

sys.path.append('.')
from scraper import Scraper

class PlayerScraper(Scraper):

    def __init__(self, args) -> None:
        super().__init__(args)
        self.fbref_base_string = 'https://fbref.com/'
        self.table_names.append('regular_season_permier_league')
        self.raw_data_path = 'data/raw/players/'
        self.proc_data_path = 'data/processed/'

    def main(self, args):
        soup = self._request_fbref(self.args.fbref_url)
        team_urls = self.scrape_teams_and_urls(soup)
        for team in team_urls.keys():
            team_soup = self._request_fbref(self.fbref_base_string+team_urls[team])
            tables = team_soup.find_all('tbody')
            headers = self._get_all_headers(team_soup)
            for i in range(len(headers)):
                print(f"writing {team}, {self.table_names[i]}")
                table = self._scrape_table(tables[i], headers[i])
                team = team.replace(' ', '')
                csv_path = self.raw_data_path+team+'/'+self.table_names[i]+'.csv'
                table.to_csv(csv_path, index=False)

        team_dirs = os.listdir(self.raw_data_path)
        for table in self.table_names:
            output = pd.DataFrame()
            for team in team_dirs:
                df = pd.read_csv(self.raw_data_path+team+'/'+table+'.csv')
                output = pd.concat([output, df])
            output.to_csv(self.proc_data_path+table+'.csv', index=False)  


        
if __name__ == '__main__':
    args = PlayerScraper.init_command_line_args().parse_args()
    scraper = PlayerScraper(args)
    scraper.main(args.fbref_url)


    