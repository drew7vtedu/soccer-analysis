import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import os
import argparse
import pdb
import sys

sys.path.append('.')
import util_funcs as util

class PlayerMapper:

    def __init__(self, args) -> None:
        self.args = args
        self.fbref_data_query = """
        SELECT DISTINCT first_name, last_name, season
        FROM player_standard_stats
        """
        self.config = util.load_config(self.args.config_path)
        self.sql_conn_str = f"postgresql+psycopg2://{self.config['sql_user']}:{self.config['sql_password']}@localhost:{self.config['sql_port']}/premier_league_data"
        engine = create_engine(self.sql_conn_str)
        with engine.connect() as conn:
            self.fbref_data = pd.read_sql(self.fbref_data_query, conn)
        self.fpl_data = self.load_cached_data(self.args.fpl_data_path)
        self.df = self.fbref_data.merge(self.fpl_data, how='outer', left_on=['season', 'first_name', 'last_name'], right_on=['season', 'first_name', 'second_name'])
        pdb.set_trace()

    @staticmethod
    def init_command_line_args():
        """
        Create command line arguments for base class and return parser
        """
        parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)

        parser.add_argument('--config_path', type=str, required=False, default='_config_.yaml', help='Path to the config file to load.')
        parser.add_argument('--fpl_data_path', type=str, required=False, default='data/clean/players/fpl', help='Path to the directory of fpl player data.')
        parser.add_argument('--update_db', action='store_true', required=False, default=False, help='Include this argument to push results to the database.')

        return parser

    def load_cached_data(self, load_path):
        """
        Load data which has been saved in csvs.
        """
        fpl_df = pd.DataFrame()
        dir = os.listdir(load_path)
        csvs = [x for x in dir if '.csv' in x]
        pdb.set_trace()
        for season in csvs:
            season_str = season[20:-4]
            df = pd.read_csv(load_path+'/'+season)
            df['season'] = season_str.replace('_', '/')
            fpl_df = pd.concat([fpl_df, df])

        return fpl_df



if __name__ == '__main__':
    args = PlayerMapper.init_command_line_args().parse_args()
    scraper = PlayerMapper(args)
    scraper.main()



        
        

