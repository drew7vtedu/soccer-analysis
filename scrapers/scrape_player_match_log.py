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

class PlayerMatchLogScraper(Scraper):

    def __init__(self, args) -> None:
        super().__init__(args)
        self.raw_data_path += 'matches/'
        self.fbref_base_string = 'https://fbref.com/'
        self.table_names = ["player_match_log"]

    def format_match_link(self, player_link: str, season: str) -> str:
        """
        Format a link to a player page to access the player's match log
        """
        # https://fbref.com/en/players/e342ad68/matchlogs/2024-2025/Mohamed-Salah-Match-Logs
        # https://fbref.com/en/players/e342ad68/Mohamed-Salah
        split_link = player_link.split('/')
        base_link = '/'.join(split_link[:-1])
        player_name = split_link[-1]
        return f"{base_link}/matchlogs/{season}/{player_name}-Match-Logs"
    
    def clean_table(self, table: pd.DataFrame) -> pd.DataFrame:
        """
        Applies some cleaning to the given table 
        """
        result = table.copy()

        if 'player' in result.columns:
            result['first_name'] = result['player'].apply(lambda x: x.split(' ')[0])
            result['last_name'] = result['player'].apply(lambda x: x[x.find(" ")+1:])
            result.drop(columns='player', inplace=True)

        if 'match_report' in result.columns:
            result.drop(columns='match_report', inplace=True)

        if 'date' in result.columns:
            result.dropna(subset=['date'], inplace=True)
            result["match_date"] = pd.to_datetime(result["date"])
            result.drop(columns='date', inplace=True)

        if "day" in result.columns:
            result.rename(mapper={"day": "day_of_week"}, axis=1, inplace=True)

        if "start" in result.columns:
            result.rename(mapper={"start": "did_player_start"}, axis=1, inplace=True)

        if "take_minus_ons_att" in result.columns:
            result.rename(mapper={"take_minus_ons_att": "take_ons_att"}, axis=1, inplace=True)

        if "take_minus_ons_succ" in result.columns:
            result.rename(mapper={"take_minus_ons_succ": "take_ons_succ"}, axis=1, inplace=True)
        
        if "result" in result.columns:
            result.rename(mapper={"result": "match_result"}, axis=1, inplace=True)
        
        if "min" in result.columns:
            result.rename(mapper={"min": "played_minutes"}, axis=1, inplace=True)

        return result

    def scrape_players_helper(self, season: str, team: str, player_name: str, link: str, update_db: bool) -> None:
        """
        Parse the given table html and headers and push the resulting table to the database if argument provided
        """
        print(f"{season}, {team}, {player_name}")
        match_log_soup = self._request_fbref_(self.fbref_base_string+link)
        try:
            match_log_table_soup = match_log_soup.find_all('tbody')[0]
        except IndexError as e:
            print(f"Could not create table from soup {match_log_soup}")
            print(f"waiting {round(self.retry_time / 60, 1)} minutes before retrying")
            time.sleep(self.retry_time)
            match_log_soup = self._request_fbref_(self.fbref_base_string+link)
            match_log_table_soup = match_log_soup.find_all('tbody')[0]
        match_log_table_headers = self._get_all_headers_(match_log_soup)[0]
        
        table = self._scrape_table_(match_log_table_soup, match_log_table_headers)
        table["season"] = season
        table["team"] = team
        table["player"] = player_name
        table = self.clean_table(table)
        save_dir = self.raw_data_path+team.replace(' ', '')+'/'+season+'/'
        Path(save_dir).mkdir(exist_ok=True, parents=True)
        table.to_csv(save_dir+player_name.replace(' ', '')+'.csv', index=False)
        if update_db:
            self.push_to_sql(table, "player_match_log")

    def scrape_players_and_urls(self, soup):
        """
        a method to scrape player names and urls to find
        match data for each player
        takes:
            bs4 soup containing a team page from fbref

        returns:
            a dictionary with player names as keys and
            corresponding urls as values
        """
        tables = soup.find_all('tbody')

        rows = tables[0].find_all('tr')

        result = dict()
        for row in rows:
            cell = row.find('th',{"data-stat":"player"})
            name = cell.text.strip().encode().decode("utf-8")
            url = cell.find('a')['href']
            result[name] = url
        return result 

    def scrape_match_logs(self, url: str, season: str, update_db: bool):
        """
        scrape all match logs for all players
        """
        soup = self._request_fbref_(url)
        team_urls = self.scrape_teams_and_urls(soup)
        season_split = season.split('/')
        season_formatted = f"20{season_split[0]}-20{season_split[1]}"
        for team in team_urls.keys():
            team_soup = self._request_fbref_(self.fbref_base_string+team_urls[team])
            standard_stats_table_soup = team_soup.find_all('tbody')[0]
            standard_stats_table_headers = self._get_all_headers_(team_soup)[0]
            standard_stats_table = self._scrape_table_(standard_stats_table_soup, standard_stats_table_headers)
            if "mp" in standard_stats_table.columns:
                filter_col = "mp"
            elif "playing_time_mp" in standard_stats_table.columns:
                filter_col = "playing_time_mp"
            else:
                raise ValueError(f"No column in {standard_stats_table.columns} was identified to filter by")
            filtered_table = standard_stats_table.loc[standard_stats_table[filter_col].astype(int) > 0]
            player_urls = self.scrape_players_and_urls(team_soup)
            player_urls = {k: v for k, v in player_urls.items() if k in filtered_table["player"].values}
            for player_name, player_link in player_urls.items():
                match_log_link = self.format_match_link(player_link, season_formatted)
                self.scrape_players_helper(season_formatted, team, player_name, match_log_link, update_db)
                time.sleep(self.wait_time)

    def main(self):
        if self.args.use_cached_data:
            self.load_cached_data(self.args.update_db)
        else:
            for season in self.config['seasons'].keys():
                self.scrape_match_logs(self.config['seasons'][season], season, self.args.update_db)


if __name__ == '__main__':
    args = PlayerMatchLogScraper.init_command_line_args().parse_args()
    scraper = PlayerMatchLogScraper(args)
    scraper.main()
