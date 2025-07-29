from sqlalchemy import create_engine
import pandas as pd
from sklearn.linear_models import LinearRegression
import sys
import argparse
import os

sys.path.append('.')
import util_funcs as util

@staticmethod
def init_command_line_args():
    """
    Create command line arguments for base class and return parser
    """
    parser = argparse.ArgumentParser(formatter_class=argparse.ArgumentDefaultsHelpFormatter)

    parser.add_argument('--config_path', type=str, required=False, default='_config_.yaml', help='Path to the config file to load.')
    parser.add_argument('--fpl_data_path', type=str, required=False, default='data/clean/players/fpl', help='Path to the directory of fpl player data.')
    parser.add_argument('--query_path', type=str, required=False, default='queries/queries.yaml', help='Path to the directory of fpl player data.')

    return parser

class ChampionshipPlayerImputer:

    def __init__(self, config) -> None:
        self.config = util.load_config(self.args.config_path)
        self.sql_conn_str = f"postgresql+psycopg2://{self.config['sql_user']}:{self.config['sql_password']}@localhost:{self.config['sql_port']}/premier_league_data"
        self.data_query = util.load_config(self.args.query_path)['championship_player_xg_query']
        self.model = LinearRegression()

    def load_fpl_data(self, load_path):
        """
        Load fpl data which has been saved in csvs.
        """
        fpl_df = pd.DataFrame()
        dir = os.listdir(load_path)
        csvs = [x for x in dir if '.csv' in x]
        for season in csvs:
            season_str = season[20:-4]
            df = pd.read_csv(load_path+'/'+season)
            df['season'] = season_str.replace('_', '/')
            fpl_df = pd.concat([fpl_df, df])

        return fpl_df

    def load_data(self) -> pd.DataFrame:
        """
        Load data for training
        """
        engine = create_engine(self.sql_conn_str)
        with engine.connect() as conn:
            df = self.fbref_data = pd.read_sql(self.data_query, conn)

        fpl_df = self.load_fpl_data(self.args.fpl_data_path)
        df = df.merge(fpl_df, how='inner',
            left_on=['fpl_first_name', 'fpl_second_name', 'season'],
            right_on=['first_name', 'second_name', 'season']
            )

        return df

    def fit(self, X, y):
        """
        Fit model object
        """
        self.model.fit(X, y)

    def train(self, df):
        """
        Calls fit with relevant X and y data
        """
        pass

    def predict(self, X):
        """
        Predict using the inner model
        """
        return self.model.predict(X)

class ChampionshipXgImputer(ChampionshipPlayerImputer):

    def __init__(self, config) -> None:
        super.__init__(config)

    def train(self, df):
        X = df.performance_gls
        y = df.expected_xg
        self.fit(X, y)


class ChampionshipXaImputer(ChampionshipPlayerImputer):

    def __init__(self, config) -> None:
        self.config = config

    def train(self, df):
        X = df.performance_ast
        y = df.expected_xa
        self.fit(X, y)