DROP DATABASE IF EXISTS fplanalysis;
CREATE DATABASE IF NOT EXISTS fplanalysis;
USE fplanalysis;

CREATE TABLE players_standard_stats (
    id INTEGER PRIMARY KEY,
    player TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT,
    primary_pos TEXT,
    age TEXT,
    mp INT,
    starts INT,
    min INT,
    90s TEXT,
    gls INT,
    ast INT,
    pk INT,
    pkatt INT,
    crdy INT,
    crdr INT,
    xg FLOAT,
    npxg FLOAT,
    xa FLOAT,
    xpoints FLOAT,
    team TEXT
);

CREATE TABLE teams (
    team_id INTEGER PRIMARY KEY,
    name TEXT,
    goals_for INT,
    goals_against INT,
    xg FLOAT,
    xga FLOAT
);

CREATE TABLE fixtures (
    id INTEGER PRIMARY KEY AUTO_INCREMENT,
    home_team_id INT,
    home_goals INT,
    home_xg FLOAT,
    away_team_id INT,
    away_goals INT,
    away_xg FLOAT,
    gameweek INT,
    postponed BOOLEAN
);
