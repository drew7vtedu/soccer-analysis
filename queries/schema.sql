--DROP DATABASE IF EXISTS premier_league_data;
--CREATE DATABASE premier_league_data;
--USE premier_league_data;

CREATE TABLE league_table (
    season TEXT NOT NULL,
    rk INTEGER,
    squad TEXT NOT NULL,
    matches_played INTEGER NOT NULL,
    wins INTEGER NOT NULL,
    draws INTEGER NOT NULL,
    losses INTEGER NOT NULL,
    goals_for INTEGER NOT NULL,
    goals_against INTEGER NOT NULL,
    goal_difference TEXT NOT NULL,
    points INTEGER NOT NULL,
    xg FLOAT NOT NULL,
    xga FLOAT NOT NULL,
    xgd FLOAT NOT NULL,
    xgd_per_90 FLOAT NOT NULL,
    last5 TEXT NOT NULL,
    attendance TEXT NOT NULL,
    top_team_scorer TEXT,
    goalkeeper TEXT,
    notes TEXT,
    PRIMARY KEY(season, squad)
);

CREATE TABLE home_away_league_table (
    season TEXT NOT NULL,
    rk INTEGER,
    squad TEXT NOT NULL,
    home_matches_played INTEGER NOT NULL,
    home_wins INTEGER NOT NULL,
    home_draws INTEGER NOT NULL,
    home_losses INTEGER NOT NULL,
    home_goals_for INTEGER NOT NULL,
    home_goals_against INTEGER NOT NULL,
    home_goal_difference TEXT NOT NULL,
    home_points INTEGER NOT NULL,
    home_xg FLOAT NOT NULL,
    home_xga FLOAT NOT NULL,
    home_xgd FLOAT NOT NULL,
    home_xgd_per_90 FLOAT NOT NULL,
    away_matches_played INTEGER NOT NULL,
    away_wins INTEGER NOT NULL,
    away_draws INTEGER NOT NULL,
    away_losses INTEGER NOT NULL,
    away_goals_for INTEGER NOT NULL,
    away_goals_against INTEGER NOT NULL,
    away_goal_difference TEXT NOT NULL,
    away_points INTEGER NOT NULL,
    away_xg FLOAT NOT NULL,
    away_xga FLOAT NOT NULL,
    away_xgd FLOAT NOT NULL,
    away_xgd_per_90 FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_standard_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INT NOT NULL,
    avg_player_age FLOAT NOT NULL, --weighted by minutes
    possession FLOAT NOT NULL,
    playing_time_matches_played INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_minutes TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_goals INTEGER NOT NULL,
    performance_assists INTEGER NOT NULL,
    performance_non_penalty_goals INTEGER NOT NULL,
    performance_penalties_scored INTEGER NOT NULL,
    performance_penalties_attempted INTEGER NOT NULL,
    performance_yellow_cards INTEGER NOT NULL,
    performance_red_cards INTEGER NOT NULL,
    per_90_minutes_goals FLOAT NOT NULL,
    per_90_minutes_assists FLOAT NOT NULL,
    per_90_minutes_goals_plus_assists FLOAT NOT NULL,
    per_90_minutes_goals_minus_pks FLOAT NOT NULL,
    per_90_minutes_plus_assists_minus_pks FLOAT NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_xa FLOAT NOT NULL,
    expected_npxg_plus_xa FLOAT NOT NULL,
    per_90_minutes_xg FLOAT NOT NULL,
    per_90_minutes_xa FLOAT NOT NULL,
    per_90_minutes_xg_plus_xa FLOAT NOT NULL,
    per_90_minutes_npxg FLOAT NOT NULL,
    per_90_minutes_npxg_plus_xa FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_teams_standard_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INT NOT NULL,
    avg_player_age FLOAT NOT NULL, --weighted by minutes
    possession FLOAT NOT NULL,
    playing_time_matches_played INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_minutes TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_goals INTEGER NOT NULL,
    performance_assists INTEGER NOT NULL,
    performance_non_penalty_goals INTEGER NOT NULL,
    performance_penalties_scored INTEGER NOT NULL,
    performance_penalties_attempted INTEGER NOT NULL,
    performance_yellow_cards INTEGER NOT NULL,
    performance_red_cards INTEGER NOT NULL,
    per_90_minutes_goals FLOAT NOT NULL,
    per_90_minutes_assists FLOAT NOT NULL,
    per_90_minutes_goals_plus_assists FLOAT NOT NULL,
    per_90_minutes_goals_minus_pks FLOAT NOT NULL,
    per_90_minutes_plus_assists_minus_pks FLOAT NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_xa FLOAT NOT NULL,
    expected_npxg_plus_xa FLOAT NOT NULL,
    per_90_minutes_xg FLOAT NOT NULL,
    per_90_minutes_xa FLOAT NOT NULL,
    per_90_minutes_xg_plus_xa FLOAT NOT NULL,
    per_90_minutes_npxg FLOAT NOT NULL,
    per_90_minutes_npxg_plus_xa FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_goalkeeping (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    playing_time_matches_played INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_minutes TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_ga INTEGER NOT NULL,
    performance_ga_per_90 FLOAT NOT NULL,
    performance_shots_on_target_against INTEGER NOT NULL,
    performance_saves INTEGER NOT NULL,
    performance_save_percent FLOAT NOT NULL,
    performance_wins INTEGER NOT NULL,
    performance_draws INTEGER NOT NULL,
    performance_losses INTEGER NOT NULL,
    performance_clean_sheets INTEGER NOT NULL,
    performance_clean_sheet_percentage FLOAT NOT NULL,
    penalty_kicks_attempted INTEGER NOT NULL,
    penalty_kicks_allowed INTEGER NOT NULL,
    penalty_kicks_saved INTEGER NOT NULL,
    penalty_kicks_missed INTEGER NOT NULL,
    penalty_save_pct FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_squad_goalkeeping (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    playing_time_matches_played INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_minutes TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_ga INTEGER NOT NULL,
    performance_ga_per_90 FLOAT NOT NULL,
    performance_shots_on_target_against INTEGER NOT NULL,
    performance_saves INTEGER NOT NULL,
    performance_save_percent FLOAT NOT NULL,
    performance_wins INTEGER NOT NULL,
    performance_draws INTEGER NOT NULL,
    performance_losses INTEGER NOT NULL,
    performance_clean_sheets INTEGER NOT NULL,
    performance_clean_sheet_percentage FLOAT NOT NULL,
    penalty_kicks_attempted INTEGER NOT NULL,
    penalty_kicks_allowed INTEGER NOT NULL,
    penalty_kicks_saved INTEGER NOT NULL,
    penalty_kicks_missed INTEGER NOT NULL,
    penalty_save_pct FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_advanced_goalkeeping (
    season TEXT NOT NULL,
	squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s INTEGER NOT NULL,
    goals_against INTEGER NOT NULL,
    goals_penalty_kicks_allowed INTEGER NOT NULL,
    goals_free_kicks_against INTEGER NOT NULL,
    goals_corner_kick_goals_against INTEGER NOT NULL,
    goal_own_goals_against INTEGER NOT NULL,
    expected_post_shot_expected_goals FLOAT NOT NULL,
    expexted_post_shot_expected_goals_per_shot_on_target FLOAT NOT NULL,
    expexted_post_shot_expected_goals_minus_goals_allowed FLOAT NOT NULL,
    expexted_post_shot_expected_goals_minus_goals_allowed_per_90 FLOAT NOT NULL,
    launched_cmp INTEGER NOT NULL,
    launched_att INTEGER NOT NULL,
    launched_cmp_pct FLOAT NOT NULL,
    passes_att INTEGER NOT NULL,
    passes_thr INTEGER NOT NULL,
    passes_launch_pct FLOAT NOT NULL,
    passes_avglen FLOAT NOT NULL,
    goal_kicks_att INTEGER NOT NULL,
    goal_kicks_launch_pct FLOAT NOT NULL,
    goal_kicks_avglen FLOAT NOT NULL,
    crosses_opp INTEGER NOT NULL,
    crosses_stp INTEGER NOT NULL,
    crosses_stp_pct FLOAT NOT NULL,
    sweeper_num_opa INTEGER NOT NULL,
    sweeper_num_opa_per_90 FLOAT NOT NULL,
    sweeper_avgdist FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_advanced_goalkeeping (
    season TEXT NOT NULL,
	squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s INTEGER NOT NULL,
    goals_against INTEGER NOT NULL,
    goals_penalty_kicks_allowed INTEGER NOT NULL,
    goals_free_kicks_against INTEGER NOT NULL,
    goals_corner_kick_goals_against INTEGER NOT NULL,
    goal_own_goals_against INTEGER NOT NULL,
    expected_post_shot_expected_goals FLOAT NOT NULL,
    expexted_post_shot_expected_goals_per_shot_on_target FLOAT NOT NULL,
    expexted_post_shot_expected_goals_minus_goals_allowed FLOAT NOT NULL,
    expexted_post_shot_expected_goals_minus_goals_allowed_per_90 FLOAT NOT NULL,
    launched_cmp INTEGER NOT NULL,
    launched_att INTEGER NOT NULL,
    launched_cmp_pct FLOAT NOT NULL,
    passes_att INTEGER NOT NULL,
    passes_thr INTEGER NOT NULL,
    passes_launch_pct FLOAT NOT NULL,
    passes_avglen FLOAT NOT NULL,
    goal_kicks_att INTEGER NOT NULL,
    goal_kicks_launch_pct FLOAT NOT NULL,
    goal_kicks_avglen FLOAT NOT NULL,
    crosses_opp INTEGER NOT NULL,
    crosses_stp INTEGER NOT NULL,
    crosses_stp_pct FLOAT NOT NULL,
    sweeper_num_opa INTEGER NOT NULL,
    sweeper_num_opa_per_90 FLOAT NOT NULL,
    sweeper_avgdist FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_shooting (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    standard_goals INTEGER NOT NULL,
    standard_sh INTEGER NOT NULL, --shots
    standard_sot INTEGER NOT NULL,
    standard_sot_pct FLOAT NOT NULL,
    standard_shots_per_90 FLOAT NOT NULL,
    standard_shots_on_target_per_90 FLOAT NOT NULL,
    standard_goals_per_shot FLOAT NOT NULL,
    standard_goals_per_shot_on_target FLOAT NOT NULL,
    standard_dist FLOAT NOT NULL, --avg distance in yards from goal of shots
    standard_fk INTEGER NOT NULL, --shots from free kicks
    standard_pk INTEGER NOT NULL,
    standard_pkatt INTEGER NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_npxg_per_shot FLOAT NOT NULL,
    expected_g_minus_xg FLOAT NOT NULL,
    expected_npg_minus_xg FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_shooting (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    standard_goals INTEGER NOT NULL,
    standard_sh INTEGER NOT NULL, --shots
    standard_sot INTEGER NOT NULL,
    standard_sot_pct FLOAT NOT NULL,
    standard_shots_per_90 FLOAT NOT NULL,
    standard_shots_on_target_per_90 FLOAT NOT NULL,
    standard_goals_per_shot FLOAT NOT NULL,
    standard_goals_per_shot_on_target FLOAT NOT NULL,
    standard_dist FLOAT NOT NULL, --avg distance in yards from goal of shots
    standard_fk INTEGER NOT NULL, --shots from free kicks
    standard_pk INTEGER NOT NULL,
    standard_pkatt INTEGER NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_npxg_per_shot FLOAT NOT NULL,
    expected_g_minus_xg FLOAT NOT NULL,
    expected_npg_minus_xg FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_passing (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    total_cmp INTEGER NOT NULL,
    total_att INTEGER NOT NULL,
    total_cmp_pct FLOAT NOT NULL,
    total_totdist INTEGER NOT NULL, --total distance in yards passes have travelled in any direction
    total_prgdist INTEGER NOT NULL,
    short_cmp INTEGER NOT NULL, -- short = 5 < x < 15 yards
    short_att INTEGER NOT NULL,
    short_cmp_pct FLOAT NOT NULL,
    medium_cmp INTEGER NOT NULL, -- medium = 15 < x < 30 yards
    medium_att INTEGER NOT NULL,
    medium_cmp_pct FLOAT NOT NULL,
    long_cmp INTEGER NOT NULL, -- long = x > 30 yards
    long_att INTEGER NOT NULL,
    long_cmp_pct FLOAT NOT NULL,
    ast INTEGER NOT NULL,
    xa FLOAT NOT NULL,
    a_minus_xa FLOAT NOT NULL,
    kp INTEGER NOT NULL, --key passes
    final_third_passes INTEGER NOT NULL, --does not include set pieces
    ppa INTEGER NOT NULL, --completed passes into the penalty area not including set pieces
    crspa INTEGER NOT NULL,
    prog INTEGER NOT NULL, --excludes passes from defending 40%
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_passing (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    total_cmp INTEGER NOT NULL,
    total_att INTEGER NOT NULL,
    total_cmp_pct FLOAT NOT NULL,
    total_totdist INTEGER NOT NULL, --total distance in yards passes have travelled in any direction
    total_prgdist INTEGER NOT NULL,
    short_cmp INTEGER NOT NULL, -- short = 5 < x < 15 yards
    short_att INTEGER NOT NULL,
    short_cmp_pct FLOAT NOT NULL,
    medium_cmp INTEGER NOT NULL, -- medium = 15 < x < 30 yards
    medium_att INTEGER NOT NULL,
    medium_cmp_pct FLOAT NOT NULL,
    long_cmp INTEGER NOT NULL, -- long = x > 30 yards
    long_att INTEGER NOT NULL,
    long_cmp_pct FLOAT NOT NULL,
    ast INTEGER NOT NULL,
    xa FLOAT NOT NULL,
    a_minus_xa FLOAT NOT NULL,
    kp INTEGER NOT NULL, --key passes
    final_third_passes INTEGER NOT NULL, --does not include set pieces
    ppa INTEGER NOT NULL, --completed passes into the penalty area not including set pieces
    crspa INTEGER NOT NULL,
    prog INTEGER NOT NULL, --excludes passes from defending 40%
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_pass_types (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    att INTEGER NOT NULL,
    pass_types_live INTEGER NOT NULL,
    pass_types_dead INTEGER NOT NULL,
    pass_types_fk INTEGER NOT NULL,
    pass_types_tb INTEGER NOT NULL, --completed pass sent between back defenders into open space
    pass_types_press INTEGER NOT NULL, --passes made while under pressure
    pass_types_sw INTEGER NOT NULL, --passes that travel more than 40 yards of the width of the pitch
    pass_types_crs INTEGER NOT NULL,
    pass_types_ck INTEGER NOT NULL,
    corner_kicks_in INTEGER NOT NULL,
    corner_kicks_out INTEGER NOT NULL,
    corner_kicks_str INTEGER NOT NULL, --straight corner kicks
    height_ground INTEGER NOT NULL,
    height_low INTEGER NOT NULL,
    height_high INTEGER NOT NULL,
    body_parts_left INTEGER NOT NULL,
    body_parts_right INTEGER NOT NULL,
    body_parts_head INTEGER NOT NULL,
    body_parts_it INTEGER NOT NULL, -- throw ins taken
    body_parts_other INTEGER NOT NULL,
    outcomes_cmp INTEGER NOT NULL,
    outcomes_off INTEGER NOT NULL,
    outcomes_out INTEGER NOT NULL,
    outcomes_int INTEGER NOT NULL,
    outcomes_blocks INTEGER NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_pass_types (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    att INTEGER NOT NULL,
    pass_types_live INTEGER NOT NULL,
    pass_types_dead INTEGER NOT NULL,
    pass_types_fk INTEGER NOT NULL,
    pass_types_tb INTEGER NOT NULL, --completed pass sent between back defenders into open space
    pass_types_press INTEGER NOT NULL, --passes made while under pressure
    pass_types_sw INTEGER NOT NULL, --passes that travel more than 40 yards of the width of the pitch
    pass_types_crs INTEGER NOT NULL,
    pass_types_ck INTEGER NOT NULL,
    corner_kicks_in INTEGER NOT NULL,
    corner_kicks_out INTEGER NOT NULL,
    corner_kicks_str INTEGER NOT NULL, --straight corner kicks
    height_ground INTEGER NOT NULL,
    height_low INTEGER NOT NULL,
    height_high INTEGER NOT NULL,
    body_parts_left INTEGER NOT NULL,
    body_parts_right INTEGER NOT NULL,
    body_parts_head INTEGER NOT NULL,
    body_parts_it INTEGER NOT NULL, -- throw ins taken
    body_parts_other INTEGER NOT NULL,
    outcomes_cmp INTEGER NOT NULL,
    outcomes_off INTEGER NOT NULL,
    outcomes_out INTEGER NOT NULL,
    outcomes_int INTEGER NOT NULL,
    outcomes_blocks INTEGER NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_goal_and_shot_creation (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    sca_sca INTEGER NOT NULL, -- shot creating actions
    sca_sca90 FLOAT NOT NULL,
    sca_types_passlive INTEGER NOT NULL,
    sca_types_passdead INTEGER NOT NULl,
    sca_types_drib INTEGER NOT NULL,
    sca_types_sh INTEGER NOT NULL,
    sca_types_fld INTEGER NOT NULL,
    sca_types_def INTEGER NOT NULL, -- defensive actions that lead to a shot attempt
    gca_gca INTEGER NOT NULL,
    gca_gca90 FLOAT NOT NULL,
    gca_types_passlive INTEGER NOT NULL,
    gca_types_passdead INTEGER NOT NULL,
    gca_types_drib INTEGER NOT NULL,
    gca_types_sh INTEGER NOT NULL,
    gca_types_fld INTEGER NOT NULL,
    gca_types_def INTEGER NOT NULL, -- defensive actions that lead to a goal
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_goal_and_shot_creation (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    sca_sca INTEGER NOT NULL, -- shot creating actions
    sca_sca90 FLOAT NOT NULL,
    sca_types_passlive INTEGER NOT NULL,
    sca_types_passdead INTEGER NOT NULl,
    sca_types_drib INTEGER NOT NULL,
    sca_types_sh INTEGER NOT NULL,
    sca_types_fld INTEGER NOT NULL,
    sca_types_def INTEGER NOT NULL, -- defensive actions that lead to a shot attempt
    gca_gca INTEGER NOT NULL,
    gca_gca90 FLOAT NOT NULL,
    gca_types_passlive INTEGER NOT NULL,
    gca_types_passdead INTEGER NOT NULL,
    gca_types_drib INTEGER NOT NULL,
    gca_types_sh INTEGER NOT NULL,
    gca_types_fld INTEGER NOT NULL,
    gca_types_def INTEGER NOT NULL, -- defensive actions that lead to a goal
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_defensive_actions (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    tackles_tkl INTEGER NOT NULL,
    tackles_tklw INTEGER NOT NULL,
    tackles_def_3rd INTEGER NOT NULL,
    tackles_mid_3rd INTEGER NOT NULl,
    tackles_att_3rd INTEGER NOT NULL,
    vs_dribbles_tkl INTEGER NOT NULL,
    vs_dribbles_att INTEGER NOT NULL,
    vs_dribbles_tkl_pct FLOAT NOT NULL,
    vs_dribbles_past INTEGER NOT NULL, -- num times dribbled past by an opposing player
    pressures_press INTEGER NOT NULL, -- num times applying pressure
    pressures_succ INTEGER NOT NULL,
    pressures_pct FLOAT NOT NULL, -- successful pressure pct
    pressures_def_3rd INTEGER NOT NULL,
    pressures_mid_3rd INTEGER NOT NULL,
    pressures_att_3rd INTEGER NOT NULL,
    blocks_blocks INTEGER NOT NULL,
    blocks_sh INTEGER NOT NULL,
    blocks_shsv INTEGER NOT NULL, -- nunmber of times blocking a shot that was on target
    blocks_pass INTEGER NOT NULL,
    interceptions INTEGER NOT NULL, 
    tkl_plus_int INTEGER NOT NULL,
    clr INTEGER NOT NULL,
    err INTEGER NOT NULL, -- mistakes leading to an opponent shot
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_defensive_actions (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    tackles_tkl INTEGER NOT NULL,
    tackles_tklw INTEGER NOT NULL,
    tackles_def_3rd INTEGER NOT NULL,
    tackles_mid_3rd INTEGER NOT NULl,
    tackles_att_3rd INTEGER NOT NULL,
    vs_dribbles_tkl INTEGER NOT NULL,
    vs_dribbles_att INTEGER NOT NULL,
    vs_dribbles_tkl_pct FLOAT NOT NULL,
    vs_dribbles_past INTEGER NOT NULL, -- num times dribbled past by an opposing player
    pressures_press INTEGER NOT NULL, -- num times applying pressure
    pressures_succ INTEGER NOT NULL,
    pressures_pct FLOAT NOT NULL, -- successful pressure pct
    pressures_def_3rd INTEGER NOT NULL,
    pressures_mid_3rd INTEGER NOT NULL,
    pressures_att_3rd INTEGER NOT NULL,
    blocks_blocks INTEGER NOT NULL,
    blocks_sh INTEGER NOT NULL,
    blocks_shsv INTEGER NOT NULL, -- nunmber of times blocking a shot that was on target
    blocks_pass INTEGER NOT NULL,
    interceptions INTEGER NOT NULL, 
    tkl_plus_int INTEGER NOT NULL,
    clr INTEGER NOT NULL,
    err INTEGER NOT NULL, -- mistakes leading to an opponent shot
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_possesion (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    touches_touches INTEGER NOT NULL,
    touches_def_pen INTEGER NOT NULL, -- defensive touches in the defensive penalty area
    touches_def_3rd INTEGER NOT NULL,
    touches_mid_3rd INTEGER NOT NULL,
    touches_att_3rd INTEGER NOT NULL,
    touches_att_pen INTEGER NOT NULL,
    touches_live INTEGER NOT NULL,
    dribbles_live INTEGER NOT NULL,
    dribbles_att INTEGER NOT NULL,
    dribbles_succ_pct FLOAT NOT NULL,
    dribbles_num_pl INTEGER NOT NULL,
    dribbles_megs INTEGER NOT NULL,
    carries_carries INTEGER NOT NULL,
    carries_totdist INTEGER NOT NULL,
    carries_prgdist INTEGER NOT NULL,
    carries_prog INTEGER NOT NULL,
    carries_final_third INTEGER NOT NULL,
    carries_cpa INTEGER NOT NULL, -- carries into the pen area
    carries_mis INTEGER NOT NULL, -- miscontrols
    receiving_targ INTEGER NOT NULL,
    receiving_rec INTEGER NOT NULL,
    receiving_rec_pct FLOAT NOT NULL,
    receiving_prog INTEGER NOT NULL, -- progressive passes recieved
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_possesion (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    touches_touches INTEGER NOT NULL,
    touches_def_pen INTEGER NOT NULL, -- defensive touches in the defensive penalty area
    touches_def_3rd INTEGER NOT NULL,
    touches_mid_3rd INTEGER NOT NULL,
    touches_att_3rd INTEGER NOT NULL,
    touches_att_pen INTEGER NOT NULL,
    touches_live INTEGER NOT NULL,
    dribbles_live INTEGER NOT NULL,
    dribbles_att INTEGER NOT NULL,
    dribbles_succ_pct FLOAT NOT NULL,
    dribbles_num_pl INTEGER NOT NULL,
    dribbles_megs INTEGER NOT NULL,
    carries_carries INTEGER NOT NULL,
    carries_totdist INTEGER NOT NULL,
    carries_prgdist INTEGER NOT NULL,
    carries_prog INTEGER NOT NULL,
    carries_final_third INTEGER NOT NULL,
    carries_cpa INTEGER NOT NULL, -- carries into the pen area
    carries_mis INTEGER NOT NULL, -- miscontrols
    receiving_targ INTEGER NOT NULL,
    receiving_rec INTEGER NOT NULL,
    receiving_rec_pct FLOAT NOT NULL,
    receiving_prog INTEGER NOT NULL, -- progressive passes recieved
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_playing_time (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    age FLOAT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_mn_per_mp INTEGER NOT NULL, -- minutes played per match played. always 90 not sure why this is a thing
    playing_time_min_pct FLOAT NOT NULL,
    playing_time_full_90s INTEGER NOT NULL,
    starts_starts INTEGER NOT NULL,
    starts_mn_per_start INTEGER NOT NULL,
    starts_compl INTEGER NOT NULL,
    subs_subs INTEGER NOT NULL,
    subs_mn_per_sub INTEGER NOT NULL,
    subs_unsub INTEGER NOT NULL,
    team_success_ppm FLOAT NOT NULL, -- points per match 
    team_success_ong INTEGER NOT NULL, -- goals scored by team while on pitch
    team_success_onga INTEGER NOT NULL,
    team_success_plus_minus INTEGER NOT NULL,
    team_success_plus_minus90 FLOAT NOT NULL,
    team_success_xg_onxg FLOAT NOT NULL,
    team_success_xg_onxga FLOAT NOT NULL,
    team_success_xg_plus_minus FLOAT NOT NULL,
    team_success_xg_plus_minus_per_90 FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_playing_time (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    age FLOAT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_mn_per_mp INTEGER NOT NULL, -- minutes played per match played. always 90 not sure why this is a thing
    playing_time_min_pct FLOAT NOT NULL,
    playing_time_full_90s INTEGER NOT NULL,
    starts_starts INTEGER NOT NULL,
    starts_mn_per_start INTEGER NOT NULL,
    starts_compl INTEGER NOT NULL,
    subs_subs INTEGER NOT NULL,
    subs_mn_per_sub INTEGER NOT NULL,
    subs_unsub INTEGER NOT NULL,
    team_success_ppm FLOAT NOT NULL, -- points per match 
    team_success_ong INTEGER NOT NULL, -- goals scored by team while on pitch
    team_success_onga INTEGER NOT NULL,
    team_success_plus_minus INTEGER NOT NULL,
    team_success_plus_minus90 FLOAT NOT NULL,
    team_success_xg_onxg FLOAT NOT NULL,
    team_success_xg_onxga FLOAT NOT NULL,
    team_success_xg_plus_minus FLOAT NOT NULL,
    team_success_xg_plus_minus_per_90 FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_miscellaneous_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    performance_crdy INTEGER NOT NULL,
    performance_crdr INTEGER NOT NULL,
    performance_2crdy INTEGER NOT NULL,
    performance_fls INTEGER NOT NULL, -- fouls committed
    performance_fld INTEGER NOT NULL, -- fouls drawn
    performance_off INTEGER NOT NULL,
    performance_crs INTEGER NOT NULL,
    performance_int INTEGER NOT NULL,
    performance_tklw INTEGER NOT NULL,
    performance_pkwon INTEGER NOT NULL,
    performance_pkcon INTEGER NOT NULL,
    performance_og INTEGER NOT NULL, -- own goals
    performnace_recov INTEGER NOT NULL, -- num loose balls recovered
    aerial_duels_won INTEGER NOT NULL,
    aerial_duels_lost INTEGER NOT NULL,
    aerial_duels_won_pct FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_miscellaneous_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    performance_crdy INTEGER NOT NULL,
    performance_crdr INTEGER NOT NULL,
    performance_2crdy INTEGER NOT NULL,
    performance_fls INTEGER NOT NULL, -- fouls committed
    performance_fld INTEGER NOT NULL, -- fouls drawn
    performance_off INTEGER NOT NULL,
    performance_crs INTEGER NOT NULL,
    performance_int INTEGER NOT NULL,
    performance_tklw INTEGER NOT NULL,
    performance_pkwon INTEGER NOT NULL,
    performance_pkcon INTEGER NOT NULL,
    performance_og INTEGER NOT NULL, -- own goals
    performnace_recov INTEGER NOT NULL, -- num loose balls recovered
    aerial_duels_won INTEGER NOT NULL,
    aerial_duels_lost INTEGER NOT NULL,
    aerial_duels_won_pct FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE player_standard_stats (
    season TEXT NOT NULL,
	team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL, 
    possession FLOAT NOT NULL,
    playing_time_matches_played INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_minutes TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_goals INTEGER NOT NULL,
    performance_assists INTEGER NOT NULL,
    performance_non_penalty_goals INTEGER NOT NULL,
    performance_penalties_scored INTEGER NOT NULL,
    performance_penalties_attempted INTEGER NOT NULL,
    performance_yellow_cards INTEGER NOT NULL,
    performance_red_cards INTEGER NOT NULL,
    per_90_minutes_goals FLOAT NOT NULL,
    per_90_minutes_assists FLOAT NOT NULL,
    per_90_minutes_goals_plus_assists FLOAT NOT NULL,
    per_90_minutes_goals_minus_pks FLOAT NOT NULL,
    per_90_minutes_plus_assists_minus_pks FLOAT NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_xa FLOAT NOT NULL,
    expected_npxg_plus_xa FLOAT NOT NULL,
    per_90_minutes_xg FLOAT NOT NULL,
    per_90_minutes_xa FLOAT NOT NULL,
    per_90_minutes_xg_plus_xa FLOAT NOT NULL,
    per_90_minutes_npxg FLOAT NOT NULL,
    per_90_minutes_npxg_plus_xa FLOAT NOT NULL,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE scores_and_fixtures (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    "date" DATE NOT NULL,
    "time" TIMESTAMP NOT NULL,
    comp TEXT NOT NULL,
    comp_round TEXT NOT NULL,
    day_of_week TEXT NOT NULL,
    venue TEXT NOT NULL,
    "result" TEXT NOT NULL,
    gf INTEGER NOT NULL,
    ga INTEGER NOT NULL,
    opponent TEXT NOT NULL,
    xg FLOAT NOT NULL,
    xga FLOAT NOT NULL,
    attendance INTEGER NOT NULL,
    captain TEXT NOT NULL,
    formation TEXT NOT NULL,
    referee TEXT NOT NULL,
    notes TEXT NOT NULL,
    PRIMARY KEY(season, team, "date")
);

CREATE TABLE player_goalkeeping (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    playing_time_mp INT NOT NULL,
    playing_time_starts INT NOT NULL,
    playing_time_min INT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_ga INT NOT NULL,
    performance_ga90 FLOAT NOT NULL,
    performance_sota INT NOT NULL,
    performance_saves INT NOT NULL,
    performance_save_pct FLOAT NOT NULL,
    performance_w INT NOT NULL,
    performance_d INT NOT NULL,
    performance_l INT NOT NULL,
    performance_cs INT NOT NULL,
    performance_cs_pct FLOAT NOT NULL,
    penalty_kicks_pkatt INT NOT NULL,
    penalty_kicks_pka INT NOT NULL,
    penalty_kicks_pksv INT NOT NULL,
    penalty_kicks_pkm INT NOT NULL,
    penalty_kicks_save_pct FLOAT NOT NULL,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_advanced_goalkeeping (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    goals_ga INT NOT NULL,
    goals_pka INT NOT NULL,
    goals_fk INT NOT NULL,
    goals_ck INT NOT NULL, -- corner kick goals against
    goals_og INT NOT NULL,
    expected_psxg FLOAT NOT NULL,
    expected_psxg_per_sot FLOAT NOT NULL,
    expecter_psxg_plus_minus FLOAT NOT NULL,
    expected_per_90 FLOAT NOT NULL, -- psxg minus goals allowed per 90
    launched_cmp INT NOT NULL,
    launched_att INT NOT NULL,
    launched_cmp_pct FLOAT NOT NULL,
    passes_att INT NOT NULL,
    passes_thr INT NOT NULL, -- throws attempted
    passes_launch_pct FLOAT NOT NULL,
    passes_avglen FLOAT NOT NULL, -- in yards, not including goal kicks
    goal_kicks_att INT NOT NULL,
    goal_kicks_launch_pct FLOAT NOT NULL,
    goal_kicks_avglen FLOAT NOT NULL,
    crosses_opp INT NOT NULL,
    crosses_stp INT NOT NULL,
    crosses_stp_pct FLOAT NOT NULL,
    sweeper_num_opa INT NOT NULL, -- num defensive actions outside pen area
    sweeper_num_opa_per_90 FLOAT NOT NULL,
    sweeper_avgdist FLOAT NOT NULL,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_shooting (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation VARCHAR(3) NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    standard_goals INTEGER NOT NULL,
    standard_sh INTEGER NOT NULL, --shots
    standard_sot INTEGER NOT NULL,
    standard_sot_pct FLOAT NOT NULL,
    standard_shots_per_90 FLOAT NOT NULL,
    standard_shots_on_target_per_90 FLOAT NOT NULL,
    standard_goals_per_shot FLOAT NOT NULL,
    standard_goals_per_shot_on_target FLOAT NOT NULL,
    standard_dist FLOAT NOT NULL, --avg distance in yards from goal of shots
    standard_fk INTEGER NOT NULL, --shots from free kicks
    standard_pk INTEGER NOT NULL,
    standard_pkatt INTEGER NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_npxg_per_shot FLOAT NOT NULL,
    expected_g_minus_xg FLOAT NOT NULL,
    expected_npg_minus_xg FLOAT NOT NULL,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_passing (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    total_cmp INTEGER NOT NULL,
    total_att INTEGER NOT NULL,
    total_cmp_pct FLOAT NOT NULL,
    total_totdist INTEGER NOT NULL, --total distance in yards passes have travelled in any direction
    total_prgdist INTEGER NOT NULL,
    short_cmp INTEGER NOT NULL, -- short = 5 < x < 15 yards
    short_att INTEGER NOT NULL,
    short_cmp_pct FLOAT NOT NULL,
    medium_cmp INTEGER NOT NULL, -- medium = 15 < x < 30 yards
    medium_att INTEGER NOT NULL,
    medium_cmp_pct FLOAT NOT NULL,
    long_cmp INTEGER NOT NULL, -- long = x > 30 yards
    long_att INTEGER NOT NULL,
    long_cmp_pct FLOAT NOT NULL,
    ast INTEGER NOT NULL,
    xa FLOAT NOT NULL,
    a_minus_xa FLOAT NOT NULL,
    kp INTEGER NOT NULL, --key passes
    final_third INTEGER NOT NULL, --does not include set pieces
    ppa INTEGER NOT NULL, --completed passes into the penalty area not including set pieces
    crspa INTEGER NOT NULL,
    prog INTEGER NOT NULL, --excludes passes from defending 40%
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_pass_types (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    att INTEGER NOT NULL,
    pass_types_live INTEGER NOT NULL,
    pass_types_dead INTEGER NOT NULL,
    pass_types_fk INTEGER NOT NULL,
    pass_types_tb INTEGER NOT NULL, --completed pass sent between back defenders into open space
    pass_types_press INTEGER NOT NULL, --passes made while under pressure
    pass_types_sw INTEGER NOT NULL, --passes that travel more than 40 yards of the width of the pitch
    pass_types_crs INTEGER NOT NULL,
    pass_types_ck INTEGER NOT NULL,
    corner_kicks_in INTEGER NOT NULL,
    corner_kicks_out INTEGER NOT NULL,
    corner_kicks_str INTEGER NOT NULL, --straight corner kicks
    height_ground INTEGER NOT NULL,
    height_low INTEGER NOT NULL,
    height_high INTEGER NOT NULL,
    body_parts_left INTEGER NOT NULL,
    body_parts_right INTEGER NOT NULL,
    body_parts_head INTEGER NOT NULL,
    body_parts_it INTEGER NOT NULL, -- throw ins taken
    body_parts_other INTEGER NOT NULL,
    outcomes_cmp INTEGER NOT NULL,
    outcomes_off INTEGER NOT NULL,
    outcomes_out INTEGER NOT NULL,
    outcomes_int INTEGER NOT NULL,
    outcomes_blocks INTEGER NOT NULL,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_goal_and_shot_creation (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    sca_sca INTEGER NOT NULL, -- shot creating actions
    sca_sca90 FLOAT NOT NULL,
    sca_types_passlive INTEGER NOT NULL,
    sca_types_passdead INTEGER NOT NULl,
    sca_types_drib INTEGER NOT NULL,
    sca_types_sh INTEGER NOT NULL,
    sca_types_fld INTEGER NOT NULL,
    sca_types_def INTEGER NOT NULL, -- defensive actions that lead to a shot attempt
    gca_gca INTEGER NOT NULL,
    gca_gca90 FLOAT NOT NULL,
    gca_types_passlive INTEGER NOT NULL,
    gca_types_passdead INTEGER NOT NULL,
    gca_types_drib INTEGER NOT NULL,
    gca_types_sh INTEGER NOT NULL,
    gca_types_fld INTEGER NOT NULL,
    gca_types_def INTEGER NOT NULL, -- defensive actions that lead to a goal
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_defensive_actions (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    num_players_used INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    tackles_tkl INTEGER NOT NULL,
    tackles_tklw INTEGER NOT NULL,
    tackles_def_3rd INTEGER NOT NULL,
    tackles_mid_3rd INTEGER NOT NULl,
    tackles_att_3rd INTEGER NOT NULL,
    vs_dribbles_tkl INTEGER NOT NULL,
    vs_dribbles_att INTEGER NOT NULL,
    vs_dribbles_tkl_pct FLOAT NOT NULL,
    vs_dribbles_past INTEGER NOT NULL, -- num times dribbled past by an opposing player
    pressures_press INTEGER NOT NULL, -- num times applying pressure
    pressures_succ INTEGER NOT NULL,
    pressures_pct FLOAT NOT NULL, -- successful pressure pct
    pressures_def_3rd INTEGER NOT NULL,
    pressures_mid_3rd INTEGER NOT NULL,
    pressures_att_3rd INTEGER NOT NULL,
    blocks_blocks INTEGER NOT NULL,
    blocks_sh INTEGER NOT NULL,
    blocks_shsv INTEGER NOT NULL, -- nunmber of times blocking a shot that was on target
    blocks_pass INTEGER NOT NULL,
    interceptions INTEGER NOT NULL, 
    tkl_plus_int INTEGER NOT NULL,
    clr INTEGER NOT NULL,
    err INTEGER NOT NULL, -- mistakes leading to an opponent shot
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_possesion (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    touches_touches INTEGER NOT NULL,
    touches_def_pen INTEGER NOT NULL, -- defensive touches in the defensive penalty area
    touches_def_3rd INTEGER NOT NULL,
    touches_mid_3rd INTEGER NOT NULL,
    touches_att_3rd INTEGER NOT NULL,
    touches_att_pen INTEGER NOT NULL,
    touches_live INTEGER NOT NULL,
    dribbles_live INTEGER NOT NULL,
    dribbles_att INTEGER NOT NULL,
    dribbles_succ_pct FLOAT NOT NULL,
    dribbles_num_pl INTEGER NOT NULL,
    dribbles_megs INTEGER NOT NULL,
    carries_carries INTEGER NOT NULL,
    carries_totdist INTEGER NOT NULL,
    carries_prgdist INTEGER NOT NULL,
    carries_prog INTEGER NOT NULL,
    carries_final_third INTEGER NOT NULL,
    carries_cpa INTEGER NOT NULL, -- carries into the pen area
    carries_mis INTEGER NOT NULL, -- miscontrols
    receiving_targ INTEGER NOT NULL,
    receiving_rec INTEGER NOT NULL,
    receiving_rec_pct FLOAT NOT NULL,
    receiving_prog INTEGER NOT NULL, -- progressive passes recieved
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_playing_time (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_mn_per_mp INTEGER NOT NULL, -- minutes played per match played. always 90 not sure why this is a thing
    playing_time_min_pct FLOAT NOT NULL,
    playing_time_full_90s INTEGER NOT NULL,
    starts_starts INTEGER NOT NULL,
    starts_mn_per_start INTEGER NOT NULL,
    starts_compl INTEGER NOT NULL,
    subs_subs INTEGER NOT NULL,
    subs_mn_per_sub INTEGER NOT NULL,
    subs_unsub INTEGER NOT NULL,
    team_success_ppm FLOAT NOT NULL, -- points per match 
    team_success_ong INTEGER NOT NULL, -- goals scored by team while on pitch
    team_success_onga INTEGER NOT NULL,
    team_success_plus_minus INTEGER NOT NULL,
    team_success_plus_minus90 FLOAT NOT NULL,
    team_success_xg_onxg FLOAT NOT NULL,
    team_success_xg_onxga FLOAT NOT NULL,
    team_success_xg_plus_minus FLOAT NOT NULL,
    team_success_xg_plus_minus_per_90 FLOAT NOT NULL,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_miscellaneous_stats (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT NOT NULL,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    performance_crdy INTEGER NOT NULL,
    performance_crdr INTEGER NOT NULL,
    performance_2crdy INTEGER NOT NULL,
    performance_fls INTEGER NOT NULL, -- fouls committed
    performance_fld INTEGER NOT NULL, -- fouls drawn
    performance_off INTEGER NOT NULL,
    performance_crs INTEGER NOT NULL,
    performance_int INTEGER NOT NULL,
    performance_tklw INTEGER NOT NULL,
    performance_pkwon INTEGER NOT NULL,
    performance_pkcon INTEGER NOT NULL,
    performance_og INTEGER NOT NULL, -- own goals
    performnace_recov INTEGER NOT NULL, -- num loose balls recovered
    aerial_duels_won INTEGER NOT NULL,
    aerial_duels_lost INTEGER NOT NULL,
    aerial_duels_won_pct FLOAT NOT NULL,
    PRIMARY KEY(season, team, first_name, last_name)
);