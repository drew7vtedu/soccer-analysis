SELECT *
FROM player_match_log
WHERE comp = 'Premier League'
    AND played_minutes IS NOT NULL
	AND played_minutes <> 'Match Report'
    AND squad IN (
		SELECT DISTINCT squad 
		FROM league_table);