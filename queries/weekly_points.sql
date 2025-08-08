SELECT
	season,
	team,
	first_name,
	last_name,
	pos,
	match_result
	played_minutes,
	performance_gls,
	performance_ast,
	performance_pkatt,
	performance_pk,
	performance_crdy,
	performance_crdr,
	performance_tkl,
	performance_int,
	performance_blocks,
	performance_saves,
	performance_pksv
FROM
	player_match_log matches
WHERE
	comp = 'Premier League';