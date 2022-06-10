import pandas as pd
import pdb
import os
import numpy as np
import pyodbc


class PlayerInserter:

    def __init__(self) -> None:
        self.mydb = mysql.connector.connect(
            host="localhost",
            user=os.getenv("SQL_USER"),
            password=os.getenv("SQL_PASSWORD"),
            database="soccer-analysis"
            )
        self.mycursor = self.mydb.cursor()
        self.mycursor.execute("USE soccer-analysis;")
        self.data_path = 'data/processed/'
        self.df = pd.read_csv(self.data_path+'standard_stats.csv')
        self.df['primary_pos'] = self.df.Pos.apply(lambda x: x.split(',')[0]) # get the first position
        xp = pd.Series(dtype='float64')
        for i in range(len(self.df)):
            xp.loc[i] = self.calc_x_points(self.df.iloc[i]['primary_pos'], self.df.iloc[i]['xG'], self.df.iloc[i]['xA'])

        self.df = pd.concat([self.df, xp], axis=1)
        self.df.rename(mapper={0: 'xPoints'}, inplace=True, axis=1)
        

    def calc_x_points(self, pos, xg, xa):
        pos_multiplier = 4
        if pos == 'MF':
            pos_multiplier = 5
        if pos == 'DF' or pos == 'GK':
            pos_multiplier = 6
        
        if np.isnan(xg) or np.isnan(xa):
            return 0

        return (3*xa) + (xg * pos_multiplier)

    def write_to_sql(self, player, cursor, db):
        sql = "INSERT INTO players (id, player, nation, pos, primary_pos, age, mp, starts, min, 90s, gls, ast, pk, pkatt, crdy, crdr, xg, npxg, xa, xpoints, team) VALUES (%s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s, %s)"
        values = (player['id'], player['player'], player['nation'], player['pos'], player['primary_pos'], player['age'], player['mp'], player['starts'], player['min'], player['90s'], player['gls'], player['ast'], player['pk'], player['pkatt'], player['crdy'], player['crdr'], player['xg'], player['npxg'], player['xa'], player['xpoints'], player['team'])
        cursor.execute(sql, values)
        db.commit()

    def main(self):
        for i in range(len(self.df)):
            player_dict = self.df.iloc[i].to_dict()
            self.write_to_sql(player_dict, self.mycursor, self.mydb)


if __name__== '__main__':
    PlayerInserter().main()
