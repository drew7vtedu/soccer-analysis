import pandas as pd
import numpy as np
import pdb
import sys
from sqlalchemy import create_engine


sys.path.append('.')
import util_funcs as util

class StatisticalXpoints:

    def __init__(self) -> None:
        self.config = util.load_config('_config_.yaml')
        self.sql_conn_str = util.get_sql_conn_str(self.config)
        self.queries = util.load_config('queries/queries.yaml')
        self.df = self.load_data()

    def load_data(self) -> pd.DataFrame:
        """
        Load data for predictions
        """
        engine = create_engine(self.sql_conn_str)
        with engine.connect() as conn:
            df = pd.read_sql(self.queries['get_xpoints_data'], conn)
        int_cols = ['clean_sheets', 'og', 'crdr', 'crdy']
        float_cols = [x for x in df.columns if x not in ['first_name', 'last_name', 'season', 'pos', 'fpl_first_name', 'fpl_second_name'] and x not in int_cols]
        df[int_cols] = df[int_cols].astype('int')
        df[float_cols] = df[float_cols].astype('float')

        fpl_df = util.load_cached_data('data/clean/players/fpl')
        #NOTE use element type to determine position not pos
        df = pd.merge(df, fpl_df[['first_name', 'second_name', 'season', 'total_points', 'element_type']], how='inner', 
                        left_on=['fpl_first_name', 'fpl_second_name', 'season'],
                        right_on=['first_name', 'second_name', 'season'], suffixes=['_fbref', '_fpl'])
        

        return df

    def calc_xpoints(self, row: pd.Series) -> int:
        """
        Calculate xPoints for the provided row
        This will be applied to a Dataframe
        """
        primary_pos = row.pos.split(',')[0]
        position_goal_modifiers = {
            'FW': 4,
            'MF': 5,
            'DF': 6,
            'GK': 0 # We can assume goalkeepers will not reliably score
        }
        position_clean_sheet_modifiers = {
            'DF': 4,
            'GK': 4
        }
        total_xpoints = ((row.xg*position_goal_modifiers[primary_pos]) + 
          (3 * row.xa) + (row.clean_sheets * position_clean_sheet_modifiers.get(primary_pos, 0)) + 
          (row.min_pct / 100 * 38 * 2) - (row.crdy * 1) - (row.crdr * 3) - (row.og * 2))
        return total_xpoints

    def calc_xpoints_no_reds_no_ogs(self, row: pd.Series) -> int:
        """
        Calculate xPoints for the provided row
        This will be applied to a Dataframe
        """
        primary_pos = row.pos.split(',')[0]
        position_goal_modifiers = {
            'FW': 4,
            'MF': 5,
            'DF': 6,
            'GK': 0 # We can assume goalkeepers will not reliably score
        }
        position_clean_sheet_modifiers = {
            'DF': 4,
            'GK': 4
        }
        total_xpoints = ((row.xg*position_goal_modifiers[primary_pos]) + 
          (3 * row.xa) + (row.clean_sheets * position_clean_sheet_modifiers.get(primary_pos, 0)) + 
          (row.min_pct / 100 * 38 * 2) - (row.crdy * 1))
        
        return total_xpoints

    def calc_xpoints_2_seasons(self, df: pd.DataFrame) -> int:
        """
        Calculate xPoints for the provided row
        This will be applied to a Dataframe
        """
        primary_pos = df.pos.values[0].split(',')[0]
        position_goal_modifiers = {
            'FW': 4,
            'MF': 5,
            'DF': 6,
            'GK': 0 # We can assume goalkeepers will not reliably score
        }
        position_clean_sheet_modifiers = {
            'DF': 4,
            'GK': 4
        }
        total_xpoints = ((df.xg.mean()*position_goal_modifiers[primary_pos]) + 
          (3 * df.xa.mean()) + (df.clean_sheets.mean() * position_clean_sheet_modifiers.get(primary_pos, 0)) + 
          (df.min_pct.mean() / 100 * 38 * 2) - (df.crdy.mean() * 1) - (df.crdr.mean() * 3) - (df.og.mean() * 2))
        
        return total_xpoints        


    def predict(self, df: pd.DataFrame):
        """
        Return expected points based on previous data
        """
        pass

    def main(self, current_season: str='22/23'):
        df = self.df.copy()
        seasons = list(df.season.unique())
        err_df_cols = ['player', 'season', 'total_points', 'xpoints', 'xpoints_simple', 'xpoints_err', 'xpoints_simple_err']
        error_df = pd.DataFrame(columns=err_df_cols)

        df['player'] = df['first_name_fpl'] + ' ' + df['second_name']
        for player in df.player.unique():
            player_df = df.loc[df.player == player].copy()
            if len(player_df) == 1:
                continue
            missing_seasons = [x for x in seasons if x not in player_df.season.unique()]
            # missing_seasons.append(current_season)
            for season in missing_seasons:
                player_df.loc[len(player_df)] = np.full(player_df.shape[1], season)
            player_df.sort_values(by='season', inplace=True)
            player_df['xpoints'] = df.apply(lambda x: self.calc_xpoints(x), axis=1)
            player_df['xpoints_simple'] = df.apply(lambda x: self.calc_xpoints_no_reds_no_ogs(x), axis=1)
            # player_df['xpoints'] = player_df['xpoints'].shift(1)
            # player_df['xpoints_simple'] = player_df['xpoints_simple'].shift(1)
            # df['xpoints_2_seasons'] = df.apply(lambda x: self.calc_xpoints_2_seasons(x), axis=1)

            player_df = player_df.loc[(player_df.player == player)|(player_df.season == current_season)]

            player_df['xpoints_err'] = abs(player_df['xpoints'] - player_df['total_points'])
            player_df['xpoints_simple_err'] = abs(player_df['xpoints'] - player_df['total_points'])
            error_df  = pd.concat([error_df, player_df[err_df_cols]])

        pdb.set_trace()
        pd.merge(left=df.loc[df.season.isin(['21/22', '22/23'])], right=error_df[['player', 'season', 'xpoints', 'xpoints_err']], on=['player', 'season']).to_csv('xpoints_spreadsheet.csv')


        df['xpoints'] = df.apply(lambda x: self.calc_xpoints(x), axis=1)
        df['xpoints_simple'] = df.apply(lambda x: self.calc_xpoints_no_reds_no_ogs(x), axis=1)
        # df['xpoints_2_seasons'] = df.apply(lambda x: self.calc_xpoints_2_seasons(x), axis=1)

        df['xpoints_err'] = abs(df['xpoints'] - df['total_points'])
        df['xpoints_simple_err'] = abs(df['xpoints'] - df['total_points'])

        # for player in df.player.unique():

        # df['xpoints_2_seasons_err'] = abs(df['xpoints'] - df['points'])
        #NOTE must iterate over individual players and shift xpoints
        #NOTE make this work for 2 season method
        #NOTE incl bonus?
        #NOTE check for outliers, at least 1 possible data error spotted (Elneny did not get 200+ points)
        pdb.set_trace()

if __name__ == '__main__':
    StatisticalXpoints().main()