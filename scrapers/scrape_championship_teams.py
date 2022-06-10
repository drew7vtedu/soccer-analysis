import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path
import os
import time

sys.path.append('.')
from scrapers.scrape_teams import TeamScraper

class ChampionshipTeamScraper(TeamScraper):

    def __init__(self, args):
        super().__init__(args)
        self.table_names = ['championship_league_table']
        self.raw_data_path = self.raw_data_path + 'championship/'
        self.proc_data_path = self.proc_data_path + 'championship/'

    def main(self):
        """
        Scrape all league pages in the config and push them to sql
        """
        for season in self.config['championship_seasons'].keys():
            self.scrape_league(self.config['championship_seasons'][season], season, self.args.update_db)
            time.sleep(60)
        


if __name__ == '__main__':
    args = ChampionshipTeamScraper.init_command_line_args().parse_args()
    scraper = ChampionshipTeamScraper(args)
    scraper.main()