SELECT *, 'premier league' AS league
FROM league_table
UNION
SELECT *, 'championship' AS league
FROM championship_league_table;