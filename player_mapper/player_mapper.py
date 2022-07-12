from math import remainder
from operator import pos
import pandas as pd
import numpy as np
from sqlalchemy import create_engine
import os
import argparse
import pdb
import sys
import unicodedata

sys.path.append('.')
import util_funcs as util

class PlayerMapper:

    def __init__(self, args) -> None:
        self.args = args
        self.fbref_data_query = """
        SELECT DISTINCT first_name, last_name, season
        FROM player_standard_stats
        WHERE playing_time_min > 0
        """
        self.config = util.load_config(self.args.config_path)
        self.sql_conn_str = f"postgresql+psycopg2://{self.config['sql_user']}:{self.config['sql_password']}@localhost:{self.config['sql_port']}/premier_league_data"
        engine = create_engine(self.sql_conn_str)
        with engine.connect() as conn:
            self.fbref_data = pd.read_sql(self.fbref_data_query, conn)
        self.fpl_data = self.load_cached_data(self.args.fpl_data_path)

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
        for season in csvs:
            season_str = season[20:-4]
            df = pd.read_csv(load_path+'/'+season)
            df['season'] = season_str.replace('_', '/')
            fpl_df = pd.concat([fpl_df, df])

        return fpl_df

    def strip_accents(self, s):
        """
        Anglicize characters to match fbref formatting
        """
        return ''.join(c for c in unicodedata.normalize('NFD', s)
                        if unicodedata.category(c) != 'Mn')

    def add_nicknames(self, s):
        """
        Apply a mapping of nicknames to facilitate finding a match
        i.e. Joe -> Joseph
        """
        nickname_mapping = {
            'Joseph': 'Joe',
            'Thomas': 'Tom',
            'Daniel': 'Danny',
            'Matthew': 'Matty',
            'Tommy': 'Thomas',
            'Freddie': 'Fredrick'
        }
        # if string is in nickname, return mapping. else, return the original value
        return nickname_mapping.get(s, s)  

    def check_hardcodes(self, row: pd.Series) -> tuple:
        """
        Check if first name and last name are in hardcoded mapped names
        Return a tuple containing the mapped (first_name, last_name)
        """
        if row.first_name == 'Kiko' and row.last_name == 'Femenía':
            return ('Francisco', 'Femenía Far')

        if row.first_name == 'Jorginho' and row.last_name == 'Jorginho':
            return ('Jorge Luiz', 'Frello Filho')

        if row.first_name == 'Jóhann' and row.last_name == 'Berg Guðmundsson':
            return ('Johann Berg', 'Gudmundsson')

        if row.first_name == 'Ki' and row.last_name == 'Sung-yueng':
            return ('Sung-yueng', 'Ki')

        if row.first_name == 'Rúben' and row.last_name == 'Vinagre':
            return ('Rúben Gonçalo', 'Silva Nascimento Vinagre')

        if row.first_name == 'Trézéguet' and row.last_name == 'Trézéguet':
            return ('Mahmoud Ahmed', 'Ibrahim Hassan')

        if row.first_name == 'José' and row.last_name == 'Fonte':
            return ('Jose', 'Fonte')

        if row.first_name == 'Kayne' and row.last_name == 'Ramsey':
            return ('Kayne', 'Ramsay')

        if row.first_name == 'Rúben' and row.last_name == 'Dias':
            return ('Rúben Santos', 'Gato Alves Dias')

        if row.first_name == 'Fred' and row.last_name == 'Fred':
            return ('Frederico', 'Rodrigues de Paula Santos')

        if row.first_name == 'Eric' and row.last_name == 'Maxim Choupo-Moting':
            return ('Eric Maxim', 'Choupo-Moting')

        if row.first_name == 'Mathias' and row.last_name == 'Jørgensen':
            return ('Mathias', 'Jorgensen')

        if row.first_name == 'Son' and row.last_name == 'Heung-min':
            return ('Heung-Min', 'Son')

        if row.first_name == 'Leo' and row.last_name == 'Fuhr Hjelde':
            return ('Leo Fuhr', 'Hjelde')

        if row.first_name == 'João' and row.last_name == 'Pedro':
            return ('João Pedro', 'Junqueira de Jesus')

        if row.first_name == 'Aleksandar' and row.last_name == 'Dragović':
            return ('Aleksandar', 'Dragovic')

        if row.first_name == 'Allan' and row.last_name == 'Allan':
            return ('Allan', 'Marques Loureiro')

        if row.first_name == 'Łukasz' and row.last_name == 'Fabiański':
            return ('Lukasz', 'Fabianski')

        if row.first_name == 'Roberto' and row.last_name == 'Roberto':
            return ('Roberto', 'Jimenez Gago')

        if row.first_name == 'Danilo' and row.last_name == 'Danilo':
            return ('Danilo Luiz', 'da Silva')

        if row.first_name == 'Fernandinho' and row.last_name == 'Fernandinho':
            return ('Fernando', 'Luiz Rosa')
        
        if row.first_name == 'William' and row.last_name == 'Thomas Fish':
            return ('William', 'Fish')

        if row.first_name == 'Jon' and row.last_name == 'Gorenc Stanković':
            return ('Jon Gorenc', 'Stankovic')

        if row.first_name == 'Pedro' and row.last_name == 'Pedro':
            return ('Pedro', 'Rodríguez Ledesma')
        
        if row.first_name == 'Rodri' and row.last_name == 'Rodri':
            return ('Rodrigo', 'Hernandez')

        if row.first_name == 'Kenedy' and row.last_name == 'Kenedy':
            return ('Robert Kenedy', 'Nunes do Nascimento')

        if row.first_name == 'Joelinton' and row.last_name == 'Joelinton':
            return ('Joelinton Cássio', 'Apolinário de Lira')

        if row.first_name == 'Chiquinho' and row.last_name == 'Chiquinho':
            return ('Francisco Jorge', 'Tomás Oliveira')

        if row.first_name == 'Fabinho' and row.last_name == 'Fabinho':
            return ('Fabio Henrique', 'Tavares')

        if row.first_name == 'Douglas' and row.last_name == 'Luiz':
            return ('Douglas Luiz', 'Soares de Paulo')

        if row.first_name == 'Adrián' and row.last_name == 'Adrián':
            return ('Adrián', 'San Miguel del Castillo')

        if row.first_name == 'Rodrigo' and row.last_name == 'Rodrigo':
            return ('Rodrigo', 'Moreno')

        if row.first_name == 'Bryan' and row.last_name == 'Bryan':
            return ('Bryan', 'Gil Salvatierra')
        
        if row.first_name == 'Ian' and row.last_name == 'Carlo Poveda':
            return ('Ian Carlo', 'Poveda-Ocampo')

        if row.first_name == 'Martinelli' and row.last_name == 'Martinelli':
            return ('Gabriel Teodoro', 'Martinelli Silva')

        if row.first_name == 'James' and row.last_name == 'Mcatee':
            return ('James', 'McAtee')

        if row.first_name == 'Joselu' and row.last_name == 'Joselu':
            return ('Jose Luis', 'Mato Sanmartín')

        if row.first_name == 'Przemysław' and row.last_name == 'Płacheta':
            return ('Przemyslaw', 'Placheta')

        if row.first_name == 'Kiko' and row.last_name == 'Casilla':
            return ('Francisco', 'Casilla Cortés')

        if row.first_name == 'Carlos' and row.last_name == 'Vinícius':
            return ('Carlos Vinicius', 'Alves Morais')

        if row.first_name == 'Rúnar' and row.last_name == 'Alex Rúnarsson':
            return ('Rúnar Alex', 'Rúnarsson')

        if row.first_name == 'Bernardo' and row.last_name == 'Bernardo':
            return ('Bernardo', 'Fernandes da Silva Junior')

        if row.first_name == 'Bernard' and row.last_name == 'Bernard':
            return ('Bernard', 'Anício Caldeira Duarte')

        if row.first_name == 'Bruno' and row.last_name == 'Bruno':
            return ('Bruno', 'Saltor Grau')

        if row.first_name == 'Cristiano' and row.last_name == 'Ronaldo':
            return ('Cristiano Ronaldo', 'dos Santos Aveiro')

        if row.first_name == 'Felipe' and row.last_name == 'Anderson':
            return ('Felipe Anderson', 'Pereira Gomes')

        if row.first_name == 'Vitinha' and row.last_name == 'Vitinha':
            return ('Vitor', 'Ferreira')

        if row.first_name == 'João' and row.last_name == 'Mário':
            return ('João Mário', 'Naval Costa Eduardo')
        
        if row.first_name == 'Junior' and row.last_name == 'Firpo':
            return ('Héctor Junior', 'Firpo Adames')
        
        if row.first_name == 'Rúben' and row.last_name == 'Neves':
            return ('Rúben Diogo', 'da Silva Neves')

        if row.first_name == 'Hélder' and row.last_name == 'Costa':
            return ('Hélder', 'Costa')
        
        if row.first_name == 'João' and row.last_name == 'Moutinho':
            return ('João Filipe Iria', 'Santos Moutinho')

        if row.first_name == 'Thiago' and row.last_name == 'Silva':
            return ('Thiago', 'Emiliano da Silva')

        if row.first_name == 'Freddie' and row.last_name == 'Ladapo':
            return ('Olayinka Fredrick Oladotun', 'Ladapo')

        if row.first_name == 'Mame' and row.last_name == 'Biram Diouf':
            return ('Mame Biram', 'Diouf')

        if row.first_name == 'Cucho' and row.last_name == 'Cucho':
            return ('Juan Camilo', 'Hernández Suárez')

        if row.first_name == 'Lyanco' and row.last_name == 'Lyanco':
            return ('Lyanco Evangelista', 'Silveira Neves Vojnovic')

        if row.first_name == 'Lyanco' and row.last_name == 'Lyanco':
            return ('Lyanco Evangelista', 'Silveira Neves Vojnovic')

        if row.first_name == 'Angeliño' and row.last_name == 'Angeliño':
            return ('José Ángel', 'Esmorís Tasende')

        if row.first_name == 'Hwang' and row.last_name == 'Hee-chan':
            return ('Hee-Chan', 'Hwang')

        if row.first_name == 'Jesuran' and row.last_name == 'Rak Sakyi':
            return ('Jesurun', 'Rak-Sakyi')
        
        return (None, None)


    def remove_not_in_fpl(self, df: pd.DataFrame):
        """
        Remove players which cannot be mapped because they do not exist in fpl data
        """
        return df.loc[~((df.first_name == 'Karl') & (df.last_name == 'Jakob Hein') & (df.season == '21/22'))].copy()

    def map_players(self, fbref_df: pd.DataFrame, fpl_df: pd.DataFrame) -> pd.DataFrame:
        """
        Match players between 2 dataframes
        """
        df = fbref_df.merge(fpl_df, how='outer', left_on=['season', 'first_name', 'last_name'], right_on=['season', 'first_name', 'second_name'])
        remainder = df.loc[df.second_name.isna()].copy()
        remainder.drop(columns=[x for x in fpl_df.columns if x != 'first_name' and x != 'season'], inplace=True)
        matches = pd.DataFrame(columns=['fbref_first_name', 'fbref_last_name', 'fpl_first_name', 'fpl_second_name', 'season'])
        drop_indexes = []
        for index, row in remainder.iterrows():
            hardcode_matches = self.check_hardcodes(row)
            if hardcode_matches[0] is not None:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                  hardcode_matches[0], hardcode_matches[1],
                  row.season]
                drop_indexes.append(index)
                continue

            possible_matches = fpl_df.loc[((fpl_df.first_name == row.first_name)|(fpl_df.second_name == row.last_name))
            &(fpl_df.season == row.season)].copy()
            if len(possible_matches) == 0:
                possible_matches = fpl_df[fpl_df.season == row.season].copy()

            elif len(possible_matches) == 1:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                  possible_matches.first_name.values[0], possible_matches.second_name.values[0],
                  row.season]
                drop_indexes.append(index)
                continue

            possible_matches['first_name_match'] = possible_matches.first_name.apply(lambda x: x == row.first_name)
            possible_matches['last_name_match'] = possible_matches.second_name.apply(lambda x: x == row.last_name)
            possible_matches['first_name_in'] = possible_matches.first_name.apply(lambda x: row.first_name in x)
            possible_matches['last_name_in'] = possible_matches.second_name.apply(lambda x: row.last_name in x)

            match = possible_matches.loc[((possible_matches.first_name_match)&(possible_matches.last_name_in))
                |((possible_matches.first_name_in)&(possible_matches.last_name_match))]
            if len(match) == 1:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                match.first_name.values[0], match.second_name.values[0], row.season]
                drop_indexes.append(index)
                continue

            possible_matches['stripped_first_name'] = possible_matches.first_name.apply(lambda x: self.strip_accents(x))
            possible_matches['stripped_last_name'] = possible_matches.second_name.apply(lambda x: self.strip_accents(x))

            possible_matches['first_name_match'] = possible_matches.stripped_first_name.apply(lambda x: x == self.strip_accents(row.first_name))
            possible_matches['last_name_match'] = possible_matches.stripped_last_name.apply(lambda x: x == self.strip_accents(row.last_name))
            possible_matches['first_name_in'] = possible_matches.stripped_first_name.apply(lambda x: self.strip_accents(row.first_name) in x)
            possible_matches['last_name_in'] = possible_matches.stripped_last_name.apply(lambda x: self.strip_accents(row.last_name) in x)

            match = possible_matches.loc[((possible_matches.first_name_match)&(possible_matches.last_name_in))
                  |((possible_matches.first_name_in)&(possible_matches.last_name_match))]
            if len(match) == 1:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                match.first_name.values[0], match.second_name.values[0], row.season]
                drop_indexes.append(index)
                continue

            possible_matches['nickname_first_name'] = possible_matches.first_name.apply(lambda x: self.add_nicknames(x))

            possible_matches['first_name_match'] = possible_matches.nickname_first_name.apply(lambda x: x == row.first_name)
            possible_matches['first_name_in'] = possible_matches.nickname_first_name.apply(lambda x: row.first_name in x)
            match = possible_matches.loc[((possible_matches.first_name_match)&(possible_matches.last_name_in))
                  |((possible_matches.first_name_in)&(possible_matches.last_name_match))]
            if len(match) == 1:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                match.first_name.values[0], match.second_name.values[0], row.season]
                drop_indexes.append(index)
                continue

        remainder = remainder.loc[~remainder.index.isin(drop_indexes)]
        possible_matches = fpl_df[fpl_df.season == row.season].copy()
        for index, row in remainder.iterrows():
            possible_matches['first_name_in'] = possible_matches.first_name.apply(lambda x: row.first_name in x)
            possible_matches['last_name_in'] = possible_matches.second_name.apply(lambda x: row.last_name in x)
            match = possible_matches.loc[(possible_matches.first_name_in)&(possible_matches.last_name_in)]
            if len(match) == 1:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                match.first_name.values[0], match.second_name.values[0], row.season]
                drop_indexes.append(index)
                continue

        remainder = remainder.loc[~remainder.index.isin(drop_indexes)]
        possible_matches = fpl_df[fpl_df.season == row.season].copy()
        for index, row in remainder.iterrows():
            possible_matches['stripped_first_name'] = possible_matches.first_name.apply(lambda x: self.strip_accents(x))
            possible_matches['stripped_last_name'] = possible_matches.second_name.apply(lambda x: self.strip_accents(x))

            possible_matches['first_name_in'] = possible_matches.stripped_first_name.apply(lambda x: row.first_name in x)
            possible_matches['last_name_in'] = possible_matches.stripped_last_name.apply(lambda x: row.last_name in x)

            match = possible_matches.loc[(possible_matches.first_name_in)&(possible_matches.last_name_in)]
            if len(match) == 1:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                match.first_name.values[0], match.second_name.values[0], row.season]
                drop_indexes.append(index)
                continue

        remainder = remainder.loc[~remainder.index.isin(drop_indexes)]
        possible_matches = fpl_df[fpl_df.season == row.season].copy()
        for index, row in remainder.iterrows():
            possible_matches['stripped_first_name'] = possible_matches.first_name.apply(lambda x: self.strip_accents(x))
            possible_matches['stripped_last_name'] = possible_matches.second_name.apply(lambda x: self.strip_accents(x))

            possible_matches['first_name_in'] = possible_matches.stripped_first_name.apply(lambda x: self.strip_accents(row.first_name) in x)
            possible_matches['last_name_in'] = possible_matches.stripped_last_name.apply(lambda x: self.strip_accents(row.last_name) in x)

            match = possible_matches.loc[(possible_matches.first_name_in)&(possible_matches.last_name_in)]
            if len(match) == 1:
                matches.loc[len(matches)] = [row.first_name, row.last_name, 
                match.first_name.values[0], match.second_name.values[0], row.season]
                drop_indexes.append(index)
                continue

        remainder = remainder.loc[~remainder.index.isin(drop_indexes)]
        if len(remainder) != 0:
            print('Warning: Unmatched players remain')
            print(remainder)
        
        return matches
                    
    
    def main(self):
        df = self.map_players(self.fbref_data, self.fpl_data)
        engine = create_engine(self.sql_conn_str)
        with engine.connect() as conn:
            df[['fbref_first_name', 'fbref_last_name', 
                'fpl_first_name', 'fpl_second_name', 'season']].to_sql('fpl_fbref_mapping', conn, index=False, if_exists='append')

if __name__ == '__main__':
    args = PlayerMapper.init_command_line_args().parse_args()
    scraper = PlayerMapper(args)
    scraper.main()
