import pandas as pd
from bs4 import BeautifulSoup
import argparse
import pdb
import sys
from pathlib import Path

sys.path.append('.')
from scraper import Scraper

class PlayerScraper(Scraper):

    def __init__(self) -> None:
        super().__init__()

    def main(self):
        soup = self._request_fbref()
        


    