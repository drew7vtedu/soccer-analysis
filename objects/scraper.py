import pandas as pd
import numpy as np
from bs4 import BeautifulSoup
import requests
import re

class scraper:

    def __init__():
        pass

    def _request_fbref(self, url):
        """
        get soup from fbref.com

        returns:
            a dictionary with team names as keys and
            corresponding urls as values
        """
        r = requests.get(url)
        comm = re.compile("<!--|-->")
        soup = BeautifulSoup(comm.sub("",r.text),'lxml')

        return soup

    def scrape_teams_and_urls(self, soup):
        """
        a method to scrape team names and urls to find
        player data for each team
        takes:
            bs4 soup containing a league page from fbref

        returns:
            a dictionary with team names as keys and
            corresponding urls as values
        """
        tables = soup.find_all('tbody')

        rows = tables[0].find_all('tr')

        result = dict()
        for row in rows:
            name = row.find('td',{"data-stat":"squad"}).text.strip().encode().decode("utf-8")
            url = row.find('td',{"data-stat":"squad"}).find('a')['href']
            result[name] = url
        return result


    def _scrape_table(self, table_soup, headers):
        """
        a method to scrape a table from fbref
        takes:
            soup containing a table
            a list containing header names for each column

        returns:
            a dataframe containing all the data from the given table
        """
        result = []

        rows = table_soup.find_all('tr')
        for row in rows:
            current_row = []
            for cell in row:
                current_row.append(cell.text.strip().encode().decode("utf-8"))
            result.append(current_row)
        return pd.DataFrame(result, columns=headers)


    def _get_league_headers(self, soup):
        """
        a method to get all table headers from a league page
        with several tables
        takes:
            soup containing page html

        returns:
            a list containing all table column headers
        """
        all_headers = soup.find_all('thead')
        h_list = []

        for i in all_headers:
            row = i.find_all('th')
            r = []
            for cell in row:
                r.append(cell.text.strip().encode().decode("utf-8"))
            h_list.append(r)
        return h_list


    def _clean_soup(self, content):
        """
        what does this do I wrote this so long ago
        """
        for tags in content.find_all("tr", class_="over_header"):
            tags.attrs = {}
        return content


    def drop_top_headers(self, header_list):
        """
        Drop the top level of a multi-header table
        """
        bruh = []
        for h in header_list:
            last_blank = 0
            for i in range(len(h)):

                if h[i] == '':
                    last_blank = i
            h = h[last_blank+1::]
            bruh.append(h)
        return bruh
    
    def save_data(self, df, fname):
        """
        Save a DataFrame to the given filename
        """
        with open(f'../data/raw/{fname}.csv', 'w') as outfile:
            df.to_csv(outfile)