import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path

sys.path.append('.')
from scraper import Scraper

class PlayerScraper(Scraper):

    def __init__(self, args) -> None:
        super().__init__(args)
        self.fbref_base_string = 'https://fbref.com/'
        self.table_names.append('regular_season_permier_league')
        self.data_path = 'data/raw/players/'

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
                csv_path = self.data_path+team+'/'+self.table_names[i]+'.csv'
                table.to_csv(csv_path, index=False)

        
if __name__ == '__main__':
    args = PlayerScraper.init_command_line_args().parse_args()
    scraper = PlayerScraper(args)
    scraper.main(args.fbref_url)


    