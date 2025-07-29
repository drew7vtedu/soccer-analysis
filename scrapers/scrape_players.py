from operator import sub
import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path
import os
import time

sys.path.append('.')
from scrapers.scraper import Scraper

class PlayerScraper(Scraper):

    def __init__(self, args) -> None:
        super().__init__(args)
        self.raw_data_path += 'players/'
        self.fbref_base_string = 'https://fbref.com/'
        self.table_names = ['player_' + x if x != 'scores_and_fixtures' else x for x in self.table_names]

    def get_shootout_goals(self, val: str) -> int:
        """
        Return penalty shootout goals from a score in the form 3 (2) where 2 is shootout goals
        """
        if val is None or '(' not in val:
            return None
        return int(val[val.find("(")+1:val.find(")")])

    def remove_parenthesis_convert_int(self, val: str) -> int:
        """
        Remove parenthesis from value and convert to int, i.e. '3 (2)' becomes 3
        """
        if val is None or '(' not in val:
            return val
        return int(val[:val.find("(")])

    def clean_table(self, table: pd.DataFrame, table_name: str) -> pd.DataFrame:
        """
        Applies some cleaning to the given table using the given table name 
        to identify which rules to apply
        """
        result = table.copy()

        if 'player' in result.columns:
            result['first_name'] = result['player'].apply(lambda x: x.split(' ')[0])
            result['last_name'] = result['player'].apply(lambda x: x[x.find(" ")+1:])
            result.drop(columns='player', inplace=True)

        if 'nation' in result.columns and 'age' in result.columns:
            result.dropna(axis=0, subset=['nation', 'age'], inplace=True)

        if 'matches' in result.columns:
            result.drop(columns='matches', inplace=True)

        if 'playing_time_min' in result.columns:
            result['playing_time_min'] = result['playing_time_min'].apply(lambda x: self.string_num_to_int(x))
            # result['playing_time_min'].fillna(value=0, inplace=True)
            result.dropna(subset=['playing_time_min'], inplace=True)

        if 'mp' in result.columns:
            result.rename(mapper={'mp': 'playing_time_mp'}, axis=1, inplace=True)

        if 'scores_and_fixtures' in table_name:
            # remove games not played yet
            result = result.dropna(subset=['result', 'gf', 'ga', 'poss', 'formation'], how='all')
            result.drop(columns='match_report', inplace=True)
            result['time'] = pd.to_datetime(result['time'])
            result['attendance'] = result['attendance'].apply(lambda x: self.string_num_to_int(x))
            result['shootout_gf'] = result['gf'].apply(lambda x: self.get_shootout_goals(x))
            result['shootout_ga'] = result['ga'].apply(lambda x: self.get_shootout_goals(x))
            result['gf'] = result['gf'].apply(lambda x: self.remove_parenthesis_convert_int(x))
            result['ga'] = result['ga'].apply(lambda x: self.remove_parenthesis_convert_int(x))

        return result

    def scrape_teams_helper(self, season: str, team: str, table, headers: str, table_name: str, update_db):
        """
        Parse the given table html and headers and push the resulting table to the database if argument provided
        """
        print(f"{season}, {team}, {table_name}")
        table = self._scrape_table_(table, headers)
        table['season'] = season
        table['team'] = team
        table = self.clean_table(table, table_name)
        Path(self.raw_data_path+team.replace(' ', '')+'/').mkdir(exist_ok=True, parents=True)
        table.to_csv(self.raw_data_path+team.replace(' ', '')+'/'+table_name+'.csv', index=False)
        if update_db:
            self.push_to_sql(table, table_name)

    def scrape_teams(self, url: str, season: str, update_db: bool):
        soup = self._request_fbref_(url)
        team_urls = self.scrape_teams_and_urls(soup)
        for team in team_urls.keys():
            team_soup = self._request_fbref_(self.fbref_base_string+team_urls[team])
            tables = team_soup.find_all('tbody')
            headers = self._get_all_headers_(team_soup)
            for i in range(len(self.table_names)):
                self.scrape_teams_helper(season, team, tables[i], headers[i], self.table_names[i], update_db)
            time.sleep(self.wait_time)

    def main(self):
        if self.args.use_cached_data:
            self.load_cached_data(self.args.update_db)
        else:
            for season in self.config['seasons'].keys():
                self.scrape_teams(self.config['seasons'][season], season, self.args.update_db)
        
if __name__ == '__main__':
    args = PlayerScraper.init_command_line_args().parse_args()
    scraper = PlayerScraper(args)
    scraper.main()


    