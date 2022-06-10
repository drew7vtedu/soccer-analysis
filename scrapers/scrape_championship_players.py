import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path
import os
import time

sys.path.append('.')
from scrapers.scrape_players import PlayerScraper

class ChampionshipPlayerScraper(PlayerScraper):

    def __init__(self, args) -> None:
        super().__init__(args)
        # self.table_names = ['championship_' + x for x in self.table_names]
        self.table_names = ['championship_player_standard_stats']
        self.raw_data_path = self.raw_data_path + 'championship/'
        self.proc_data_path = self.proc_data_path + 'championship/'

    def scrape_teams(self, url: str, season: str, update_db: bool):
        soup = self._request_fbref_(url)
        team_urls = self.scrape_teams_and_urls(soup)

        tables = soup.find_all('tbody')
        headers = self._get_all_headers_(soup)
        league_table = self._scrape_table_(tables[0], headers[0])
        league_table = league_table.loc[~league_table.notes.isna()]
        promoted_teams = league_table.loc[(league_table.notes.str.contains('Promoted'))]

        desired_teams = [x.replace("\'", '') for x in promoted_teams.squad.unique()]
        for team in desired_teams:
            team_soup = self._request_fbref_(self.fbref_base_string+team_urls[team])
            tables = team_soup.find_all('tbody')
            headers = self._get_all_headers_(team_soup)
            for i in range(len(self.table_names)):
                print(f"{season}, {team}, {self.table_names[i]}")
                table = self._scrape_table_(tables[i], headers[i])
                table['season'] = season
                table['team'] = team
                table = self.clean_table(table, self.table_names[i])
                Path(self.raw_data_path+team.replace(' ', '')+'/').mkdir(exist_ok=True, parents=True)
                table.to_csv(self.raw_data_path+team.replace(' ', '')+'/'+self.table_names[i]+'.csv', index=False)
                if update_db:
                    self.push_to_sql(table, self.table_names[i])
            time.sleep(60)

    def main(self):
        if self.args.use_cached_data:
            self.load_cached_data(self.args.update_db)
        else:
            for season in self.config['championship_seasons'].keys():
                self.scrape_teams(self.config['championship_seasons'][season], season, self.args.update_db)

if __name__ == '__main__':
    args = ChampionshipPlayerScraper.init_command_line_args().parse_args()
    scraper = ChampionshipPlayerScraper(args)
    scraper.main()