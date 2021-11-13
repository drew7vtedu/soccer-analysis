import pandas as pd
import os
import argparse
import pdb


data_path = 'data/raw/teams/'
files = os.listdir(data_path)

result = pd.read_csv(data_path+'league_table.csv')
for f in files:
    if f != 'league_table.csv' and f.startswith('.') == False:
        temp = pd.read_csv(data_path+f)
        cols_to_use = list(temp.columns.difference(result.columns))
        cols_to_use.insert(0, 'Squad')
        try:
            temp.reset_index()
            # pdb.set_trace()
            result = result.merge(temp[cols_to_use], on='Squad', how='inner')
        except:
            print()
            print()
            print(f)
            print()
            print()
result.to_csv('data/processed/combined_teams.csv')