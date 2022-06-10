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
        self.fbref_base_string = 'https://fbref.com/'
        self.table_names = ['player_' + x for x in self.table_names]
        self.raw_data_path = self.raw_data_path + 'championship/'
        self.proc_data_path = self.proc_data_path + 'championship/'

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
            result['playing_time_min'].fillna(value=0, inplace=True)

        if 'playing_time_full_90s' in result.columns:
            result['playing_time_full_90s'].fillna(value=0.0, inplace=True)

        if 'performance_gls' in result.columns:
            result['performance_gls'].fillna(value=0, inplace=True)

        if 'standard_sh' in result.columns:
            result['standard_sh'].fillna(value=0, inplace=True)

        if 'standard_fk' in result.columns:
            result['standard_fk'].fillna(value=0, inplace=True)

        if 'total_att' in result.columns:
            result['total_att'].fillna(value=0, inplace=True)

        if 'total_totdist' in result.columns:
            result['total_totdist'].fillna(value=0, inplace=True)

        if 'total_prgdist' in result.columns:
            result['total_prgdist'].fillna(value=0, inplace=True)

        if 'short_att' in result.columns:
            result['short_att'].fillna(value=0, inplace=True)

        if 'medium_att' in result.columns:
            result['medium_att'].fillna(value=0, inplace=True)

        if 'long_att' in result.columns:
            result['long_att'].fillna(value=0, inplace=True)

        if 'performance_ast' in result.columns:
            result['performance_ast'].fillna(value=0, inplace=True)

        if 'performance_g_minus_pk' in result.columns:
            result['performance_g_minus_pk'].fillna(value=0, inplace=True)

        if 'performance_pk' in result.columns:
            result['performance_pk'].fillna(value=0, inplace=True)

        if 'performance_pkatt' in result.columns:
            result['performance_pkatt'].fillna(value=0, inplace=True)

        if 'performance_crdy' in result.columns:
            result['performance_crdy'].fillna(value=0, inplace=True)

        if 'performance_crdr' in result.columns:
            result['performance_crdr'].fillna(value=0, inplace=True)

        if 'expected_xg' in result.columns:
            result['expected_xg'].fillna(value=0.0, inplace=True)

        if 'expected_npxg' in result.columns:
            result['expected_npxg'].fillna(value=0.0, inplace=True)

        if 'expected_xa' in result.columns:
            result['expected_xa'].fillna(value=0.0, inplace=True)

        if 'xa' in result.columns:
            result['xa'].fillna(value=0.0, inplace=True)

        if 'kp' in result.columns:
            result['kp'].fillna(value=0, inplace=True)

        if 'final_third' in result.columns:
            result['final_third'].fillna(value=0, inplace=True)

        if 'ppa' in result.columns:
            result['ppa'].fillna(value=0, inplace=True)

        if 'crspa' in result.columns:
            result['crspa'].fillna(value=0, inplace=True)

        if 'prog' in result.columns:
            result['prog'].fillna(value=0, inplace=True)

        if 'att' in result.columns:
            result['att'].fillna(value=0, inplace=True)

        if 'pass_types_live' in result.columns:
            result['pass_types_live'].fillna(value=0, inplace=True)

        if 'pass_types_dead' in result.columns:
            result['pass_types_dead'].fillna(value=0, inplace=True)

        if 'pass_types_fk' in result.columns:
            result['pass_types_fk'].fillna(value=0, inplace=True)

        if 'pass_types_tb' in result.columns:
            result['pass_types_tb'].fillna(value=0, inplace=True)

        if 'pass_types_press' in result.columns:
            result['pass_types_press'].fillna(value=0, inplace=True)

        if 'pass_types_sw' in result.columns:
            result['pass_types_sw'].fillna(value=0, inplace=True)

        if 'pass_types_crs' in result.columns:
            result['pass_types_crs'].fillna(value=0, inplace=True)

        if 'pass_types_ck' in result.columns:
            result['pass_types_ck'].fillna(value=0, inplace=True)

        if 'corner_kicks_in' in result.columns:
            result['corner_kicks_in'].fillna(value=0, inplace=True)

        if 'corner_kicks_out' in result.columns:
            result['corner_kicks_out'].fillna(value=0, inplace=True)

        if 'corner_kicks_str' in result.columns:
            result['corner_kicks_str'].fillna(value=0, inplace=True)

        if 'height_ground' in result.columns:
            result['height_ground'].fillna(value=0, inplace=True)

        if 'height_low' in result.columns:
            result['height_low'].fillna(value=0, inplace=True)

        if 'height_high' in result.columns:
            result['height_high'].fillna(value=0, inplace=True)

        if 'body_parts_left' in result.columns:
            result['body_parts_left'].fillna(value=0, inplace=True)

        if 'body_parts_right' in result.columns:
            result['body_parts_right'].fillna(value=0, inplace=True)

        if 'body_parts_head' in result.columns:
            result['body_parts_head'].fillna(value=0, inplace=True)

        if 'body_parts_ti' in result.columns:
            result['body_parts_ti'].fillna(value=0, inplace=True)

        if 'body_parts_other' in result.columns:
            result['body_parts_other'].fillna(value=0, inplace=True)

        if 'sca_sca' in result.columns:
            result['sca_sca'].fillna(value=0, inplace=True)

        if 'sca_types_passlive' in result.columns:
            result['sca_types_passlive'].fillna(value=0, inplace=True)

        if 'sca_types_passdead' in result.columns:
            result['sca_types_passdead'].fillna(value=0, inplace=True)

        if 'sca_types_drib' in result.columns:
            result['sca_types_drib'].fillna(value=0, inplace=True)

        if 'sca_types_sh' in result.columns:
            result['sca_types_sh'].fillna(value=0, inplace=True)

        if 'sca_types_fld' in result.columns:
            result['sca_types_fld'].fillna(value=0, inplace=True)

        if 'sca_types_def' in result.columns:
            result['sca_types_def'].fillna(value=0, inplace=True)

        if 'gca_gca' in result.columns:
            result['gca_gca'].fillna(value=0, inplace=True)

        if 'gca_types_passlive' in result.columns:
            result['gca_types_passlive'].fillna(value=0, inplace=True)

        if 'gca_types_passdead' in result.columns:
            result['gca_types_passdead'].fillna(value=0, inplace=True)

        if 'gca_types_drib' in result.columns:
            result['gca_types_drib'].fillna(value=0, inplace=True)

        if 'gca_types_sh' in result.columns:
            result['gca_types_sh'].fillna(value=0, inplace=True)

        if 'gca_types_fld' in result.columns:
            result['gca_types_fld'].fillna(value=0, inplace=True)

        if 'gca_types_def' in result.columns:
            result['gca_types_def'].fillna(value=0, inplace=True)

        if 'tackles_tkl' in result.columns:
            result['tackles_tkl'].fillna(value=0, inplace=True)

        if 'tackles_tklw' in result.columns:
            result['tackles_tklw'].fillna(value=0, inplace=True)

        if 'tackles_def_3rd' in result.columns:
            result['tackles_def_3rd'].fillna(value=0, inplace=True)

        if 'tackles_mid_3rd' in result.columns:
            result['tackles_mid_3rd'].fillna(value=0, inplace=True)

        if 'tackles_att_3rd' in result.columns:
            result['tackles_att_3rd'].fillna(value=0, inplace=True)

        if 'vs_dribbles_tkl' in result.columns:
            result['vs_dribbles_tkl'].fillna(value=0, inplace=True)

        if 'vs_dribbles_att' in result.columns:
            result['vs_dribbles_att'].fillna(value=0, inplace=True)

        if 'vs_dribbles_past' in result.columns:
            result['vs_dribbles_past'].fillna(value=0, inplace=True)

        if 'pressures_press' in result.columns:
            result['pressures_press'].fillna(value=0, inplace=True)

        if 'pressures_succ' in result.columns:
            result['pressures_succ'].fillna(value=0, inplace=True)

        if 'pressures_def_3rd' in result.columns:
            result['pressures_def_3rd'].fillna(value=0, inplace=True)

        if 'pressures_mid_3rd' in result.columns:
            result['pressures_mid_3rd'].fillna(value=0, inplace=True)

        if 'pressures_att_3rd' in result.columns:
            result['pressures_att_3rd'].fillna(value=0, inplace=True)

        if 'blocks_blocks' in result.columns:
            result['blocks_blocks'].fillna(value=0, inplace=True)

        if 'blocks_sh' in result.columns:
            result['blocks_sh'].fillna(value=0, inplace=True)

        if 'blocks_shsv' in result.columns:
            result['blocks_shsv'].fillna(value=0, inplace=True)

        if 'blocks_pass' in result.columns:
            result['blocks_pass'].fillna(value=0, inplace=True)

        if 'interceptions' in result.columns:
            result['interceptions'].fillna(value=0, inplace=True)

        if 'tkl_plus_int' in result.columns:
            result['tkl_plus_int'].fillna(value=0, inplace=True)

        if 'clr' in result.columns:
            result['clr'].fillna(value=0, inplace=True)

        if 'err' in result.columns:
            result['err'].fillna(value=0, inplace=True)

        if 'touches_touches' in result.columns:
            result['touches_touches'].fillna(value=0, inplace=True)
        
        if 'touches_def_pen' in result.columns:
            result['touches_def_pen'].fillna(value=0, inplace=True)

        if 'touches_def_3rd' in result.columns:
            result['touches_def_3rd'].fillna(value=0, inplace=True)

        if 'touches_mid_3rd' in result.columns:
            result['touches_mid_3rd'].fillna(value=0, inplace=True)

        if 'touches_att_3rd' in result.columns:
            result['touches_att_3rd'].fillna(value=0, inplace=True)

        if 'touches_att_pen' in result.columns:
            result['touches_att_pen'].fillna(value=0, inplace=True)

        if 'touches_live' in result.columns:
            result['touches_live'].fillna(value=0, inplace=True)

        if 'dribbles_succ' in result.columns:
            result['dribbles_succ'].fillna(value=0, inplace=True)

        if 'dribbles_num_pl' in result.columns:
            result['dribbles_num_pl'].fillna(value=0, inplace=True)

        if 'dribbles_megs' in result.columns:
            result['dribbles_megs'].fillna(value=0, inplace=True)

        if 'carries_carries' in result.columns:
            result['carries_carries'].fillna(value=0, inplace=True)

        if 'carries_totdist' in result.columns:
            result['carries_totdist'].fillna(value=0, inplace=True)

        if 'carries_prgdist' in result.columns:
            result['carries_prgdist'].fillna(value=0, inplace=True)

        if 'carries_prog' in result.columns:
            result['carries_prog'].fillna(value=0, inplace=True)

        if 'carries_final_third' in result.columns:
            result['carries_final_third'].fillna(value=0, inplace=True)

        if 'carries_cpa' in result.columns:
            result['carries_cpa'].fillna(value=0, inplace=True)

        if 'carries_mis' in result.columns:
            result['carries_mis'].fillna(value=0, inplace=True)

        if 'carries_dis' in result.columns:
            result['carries_dis'].fillna(value=0, inplace=True)

        if 'recieving_targ' in result.columns:
            result['recieving_targ'].fillna(value=0, inplace=True)

        if 'recieving_rec' in result.columns:
            result['recieving_rec'].fillna(value=0, inplace=True)

        if 'recieving_prog' in result.columns:
            result['recieving_prog'].fillna(value=0, inplace=True)

        if 'performance_off' in result.columns:
            result['performance_off'].fillna(value=0, inplace=True)

        if 'performance_fld' in result.columns:
            result['performance_fld'].fillna(value=0, inplace=True)

        if 'performance_int' in result.columns:
            result['performance_int'].fillna(value=0, inplace=True)

        if 'performance_crs' in result.columns:
            result['performance_crs'].fillna(value=0, inplace=True)

        if 'performance_tklw' in result.columns:
            result['performance_tklw'].fillna(value=0, inplace=True)

        if 'performance_pkwon' in result.columns:
            result['performance_pkwon'].fillna(value=0, inplace=True)

        if 'performance_pkcon' in result.columns:
            result['performance_pkcon'].fillna(value=0, inplace=True)

        if 'performance_og' in result.columns:
            result['performance_og'].fillna(value=0, inplace=True)

        if 'performance_recov' in result.columns:
            result['performance_recov'].fillna(value=0, inplace=True)

        if 'aerial_duels_won' in result.columns:
            result['aerial_duels_won'].fillna(value=0, inplace=True)

        if 'aerial_duels_lost' in result.columns:
            result['aerial_duels_lost'].fillna(value=0, inplace=True)

        if 'expected_npxg_plus_xa' in result.columns:
            result['expected_npxg_plus_xa'].fillna(value=0.0, inplace=True)

        if table_name == 'scores_and_fixtures':
            result.drop(columns='match_report', inplace=True)
            result['time'] = pd.to_datetime(result['time'])
            result['attendance'] = result['attendance'].apply(lambda x: self.string_num_to_int(x))
            result['shootout_gf'] = result['gf'].apply(lambda x: self.get_shootout_goals(x))
            result['shootout_ga'] = result['ga'].apply(lambda x: self.get_shootout_goals(x))
            result['gf'] = result['gf'].apply(lambda x: self.remove_parenthesis_convert_int(x))
            result['ga'] = result['ga'].apply(lambda x: self.remove_parenthesis_convert_int(x))

        return result

    def scrape_teams(self, url: str, season: str, update_db: bool):
        soup = self._request_fbref_(url)
        team_urls = self.scrape_teams_and_urls(soup)
        for team in team_urls.keys():
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
            for season in self.config['seasons'].keys():
                self.scrape_teams(self.config['seasons'][season], season, self.args.update_db)
        
if __name__ == '__main__':
    args = PlayerScraper.init_command_line_args().parse_args()
    scraper = PlayerScraper(args)
    scraper.main()


    