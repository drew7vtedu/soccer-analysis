import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path
import time

from scrapers.scraper import Scraper

class TeamScraper(Scraper):

    def __init__(self, args):
        super().__init__(args)
        self.table_names.remove('scores_and_fixtures')
        opponent_table_names = ['opponent_stats_' + x for x in self.table_names]
        table_names = []
        for tup in zip(self.table_names, opponent_table_names):
            table_names.append(tup[0])
            table_names.append(tup[1])
        self.table_names = table_names
        self.table_names = ['squad_' + x for x in self.table_names]
        
        self.table_names.insert(0, 'league_table')
        self.table_names.insert(1, 'home_away_league_table',)
        self.raw_data_path = self.raw_data_path + 'teams/'
        self.proc_data_path = self.proc_data_path + 'teams/'
    
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

    def scrape_league(self, url: str, season: str, update_db: bool):
        """
        Scrape an entire league page worth of team data
        Add the provided season string to all dataframes
        """
        soup = self._request_fbref_(url)
        
        tables = soup.find_all('tbody')

        headers = self._get_all_headers_(soup)

        for i in range(len(self.table_names)): # tables not accounted for which come after will be left out
            t = self._scrape_table_(tables[i], headers[i])
            t['season'] = season
            t = self.clean_table(t, self.table_names[i])
            Path(self.raw_data_path).mkdir(exist_ok=True, parents=True)
            t.to_csv(self.raw_data_path+self.table_names[i]+'.csv', index=False)
            if update_db:
                print(f"{season}, {self.table_names[i]}")
                self.push_to_sql(t, self.table_names[i])

    def clean_table(self, table: pd.DataFrame, table_name: str) -> pd.DataFrame:
        """
        Applies some cleaning to the given table using the given table name 
        to identify which rules to apply
        """
        result = table.copy()
        if 'attendance' in result.columns:
            result['attendance'] = result['attendance'].apply(lambda x: self.string_num_to_int(x))

        return result

    def main(self):
        """
        Scrape all league pages in the config and push them to sql
        """
        for season in self.config['seasons'].keys():
            self.scrape_league(self.config['seasons'][season], season, self.args.update_db)
            time.sleep(60)
        


if __name__ == '__main__':
    args = TeamScraper.init_command_line_args().parse_args()
    scraper = TeamScraper(args)
    scraper.main()