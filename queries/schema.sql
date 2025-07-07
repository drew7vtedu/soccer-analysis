--DROP DATABASE IF EXISTS premier_league_data;
--CREATE DATABASE premier_league_data;
--USE premier_league_data;

CREATE TABLE league_table (
    season TEXT NOT NULL,
    rk INTEGER,
    squad TEXT NOT NULL,
    mp INTEGER NOT NULL,
    w INTEGER NOT NULL,
    d INTEGER NOT NULL,
    l INTEGER NOT NULL,
    gf INTEGER NOT NULL,
    ga INTEGER NOT NULL,
    gd TEXT NOT NULL,
    pts INTEGER NOT NULL,
    pts_per_mp FLOAT,
    xg FLOAT NOT NULL,
    xga FLOAT NOT NULL,
    xgd FLOAT NOT NULL,
    xgd_per_90 FLOAT,
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
    home_mp INTEGER NOT NULL,
    home_w INTEGER NOT NULL,
    home_d INTEGER NOT NULL,
    home_l INTEGER NOT NULL,
    home_gf INTEGER NOT NULL,
    home_ga INTEGER NOT NULL,
    home_gd TEXT NOT NULL,
    home_pts INTEGER NOT NULL,
    home_pts_per_mp FLOAT NOT NULL,
    home_xg FLOAT NOT NULL,
    home_xga FLOAT NOT NULL,
    home_xgd FLOAT NOT NULL,
    home_xgd_per_90 FLOAT NOT NULL,
    away_mp INTEGER NOT NULL,
    away_w INTEGER NOT NULL,
    away_d INTEGER NOT NULL,
    away_l INTEGER NOT NULL,
    away_gf INTEGER NOT NULL,
    away_ga INTEGER NOT NULL,
    away_gd TEXT NOT NULL,
    away_pts INTEGER NOT NULL,
    away_pts_per_mp FLOAT NOT NULL,
    away_xg FLOAT NOT NULL,
    away_xga FLOAT NOT NULL,
    away_xgd FLOAT NOT NULL,
    away_xgd_per_90 FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_standard_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INT NOT NULL,
    age FLOAT NOT NULL, -- weighted by minutes
    poss FLOAT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_gls INTEGER NOT NULL,
    performance_ast INTEGER NOT NULL,
    performance_g_plus_a INTEGER NOT NULL,
    performance_g_minus_pk INTEGER NOT NULL,
    performance_pk INTEGER NOT NULL, -- penalties scored
    performance_pkatt INTEGER NOT NULL,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
    per_90_minutes_gls FLOAT NOT NULL,
    per_90_minutes_ast FLOAT NOT NULL,
    per_90_minutes_g_plus_a FLOAT NOT NULL,
    per_90_minutes_g_minus_pk FLOAT NOT NULL,
    per_90_minutes_g_plus_a_minus_pk FLOAT NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_xag FLOAT NOT NULL,
    expected_npxg_plus_xag FLOAT NOT NULL,
    progression_prgc INTEGER NOT NULL,
    progression_prgp INTEGER NOT NULL,
    per_90_minutes_xg FLOAT NOT NULL,
    per_90_minutes_xag FLOAT NOT NULL,
    per_90_minutes_xg_plus_xag FLOAT NOT NULL,
    per_90_minutes_npxg FLOAT NOT NULL,
    per_90_minutes_npxg_plus_xag FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_standard_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INT NOT NULL,
    age FLOAT NOT NULL, --weighted by minutes
    poss FLOAT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_gls INTEGER NOT NULL,
    performance_ast INTEGER NOT NULL,
    performance_g_minus_pk INTEGER NOT NULL,
    performance_pk INTEGER NOT NULL, -- penalties scored
    performance_pkatt INTEGER NOT NULL,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
    per_90_minutes_gls FLOAT NOT NULL,
    per_90_minutes_ast FLOAT NOT NULL,
    per_90_minutes_g_plus_a FLOAT NOT NULL,
    per_90_minutes_g_minus_pk FLOAT NOT NULL,
    per_90_minutes_g_plus_a_minus_pk FLOAT NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_xag FLOAT NOT NULL,
    expected_npxg_plus_xag FLOAT NOT NULL,
    progression_prgc INTEGER NOT NULL,
    progression_prgp INTEGER NOT NULL,
    per_90_minutes_xg FLOAT NOT NULL,
    per_90_minutes_xag FLOAT NOT NULL,
    per_90_minutes_xg_plus_xag FLOAT NOT NULL,
    per_90_minutes_npxg FLOAT NOT NULL,
    per_90_minutes_npxg_plus_xag FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_goalkeeping (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_ga INTEGER NOT NULL,
    performance_ga90 FLOAT NOT NULL,
    performance_sota INTEGER NOT NULL, -- shots on target against
    performance_saves INTEGER NOT NULL,
    performance_save_pct FLOAT NOT NULL,
    performance_w INTEGER NOT NULL,
    performance_d INTEGER NOT NULL,
    performance_l INTEGER NOT NULL,
    performance_cs INTEGER NOT NULL,
    performance_cs_pct FLOAT NOT NULL,
    penalty_kicks_pkatt INTEGER NOT NULL,
    penalty_kicks_pka INTEGER NOT NULL, -- pk goals allowed
    penalty_kicks_pksv INTEGER NOT NULL,
    penalty_kicks_pkm INTEGER NOT NULL,
    penalty_kicks_save_pct FLOAT,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_goalkeeping (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_ga INTEGER NOT NULL,
    performance_ga90 FLOAT NOT NULL,
    performance_sota INTEGER NOT NULL, -- shots on target against
    performance_saves INTEGER NOT NULL,
    performance_save_pct FLOAT NOT NULL,
    performance_w INTEGER NOT NULL,
    performance_d INTEGER NOT NULL,
    performance_l INTEGER NOT NULL,
    performance_cs INTEGER NOT NULL,
    performance_cs_pct FLOAT NOT NULL,
    penalty_kicks_pkatt INTEGER NOT NULL,
    penalty_kicks_pka INTEGER NOT NULL, -- pk goals allowed
    penalty_kicks_pksv INTEGER NOT NULL,
    penalty_kicks_pkm INTEGER NOT NULL,
    penalty_kicks_save_pct FLOAT,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_advanced_goalkeeping (
    season TEXT NOT NULL,
	squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    goals_ga INTEGER NOT NULL,
    goals_pka INTEGER NOT NULL,
    goals_fk INTEGER NOT NULL,
    goals_ck INTEGER NOT NULL,
    goals_og INTEGER NOT NULL,
    expected_psxg FLOAT NOT NULL,
    expected_psxg_per_sot FLOAT NOT NULL,
    expected_ps_plus_minus FLOAT NOT NULL, -- psxg plus minus
    expected_per_90 FLOAT NOT NULL,
    launched_cmp INTEGER NOT NULL,
    launched_att INTEGER NOT NULL,
    launched_cmp_pct FLOAT NOT NULL,
    passes_att_gk INTEGER NOT NULL,
    passes_thr INTEGER NOT NULL,
    passes_launch_pct FLOAT NOT NULL,
    passes_avglen FLOAT,
    goal_kicks_att INTEGER NOT NULL,
    goal_kicks_launch_pct FLOAT NOT NULL,
    goal_kicks_avglen FLOAT,
    crosses_opp INTEGER NOT NULL,
    crosses_stp INTEGER NOT NULL,
    crosses_stp_pct FLOAT NOT NULL,
    sweeper_num_opa INTEGER NOT NULL,
    sweeper_num_opa_per_90 FLOAT NOT NULL,
    sweeper_avgdist FLOAT,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_advanced_goalkeeping (
    season TEXT NOT NULL,
	squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s INTEGER NOT NULL,
    goals_ga INTEGER NOT NULL,
    goals_pka INTEGER NOT NULL,
    goals_fk INTEGER NOT NULL,
    goals_ck INTEGER NOT NULL,
    goal_og INTEGER NOT NULL,
    expected_psxg FLOAT NOT NULL,
    expected_psxg_per_sot FLOAT NOT NULL,
    expected_ps_plus_minus FLOAT NOT NULL, 
    expexted_per_90 FLOAT NOT NULL,
    launched_cmp INTEGER NOT NULL,
    launched_att INTEGER NOT NULL,
    launched_cmp_pct FLOAT NOT NULL,
    passes_att_gk INTEGER NOT NULL,
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
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    standard_gls INTEGER NOT NULL,
    standard_sh INTEGER NOT NULL, --shots
    standard_sot INTEGER NOT NULL,
    standard_sot_pct FLOAT,
    standard_sh_per_90 FLOAT,
    standard_sot_per_90 FLOAT,
    standard_g_per_sh FLOAT,
    standard_g_per_sot FLOAT,
    standard_dist FLOAT, --avg distance in yards from goal of shots
    standard_fk INTEGER NOT NULL, --shots from free kicks
    standard_pk INTEGER NOT NULL,
    standard_pkatt INTEGER NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_npxg_per_sh FLOAT,
    expected_g_minus_xg FLOAT NOT NULL,
    expected_npg_minus_xg FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_shooting (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    standard_gls INTEGER NOT NULL,
    standard_sh INTEGER NOT NULL, --shots
    standard_sot INTEGER NOT NULL,
    standard_sot_pct FLOAT NOT NULL,
    standard_sh_per_90 FLOAT NOT NULL,
    standard_sot_per_90 FLOAT NOT NULL,
    standard_g_per_sh FLOAT NOT NULL,
    standard_g_per_sot FLOAT NOT NULL,
    standard_dist FLOAT NOT NULL, --avg distance in yards from goal of shots
    standard_fk INTEGER NOT NULL, --shots from free kicks
    standard_pk INTEGER NOT NULL,
    standard_pkatt INTEGER NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_npxg_per_sh FLOAT NOT NULL,
    expected_g_minus_xg FLOAT NOT NULL,
    expected_npg_minus_xg FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_passing (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
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
    xag FLOAT NOT NULL,
    expected_xa FLOAT NOT NULL,
    expected_a_minus_xag FLOAT NOT NULL,
    kp INTEGER NOT NULL, --key passes
    final_third INTEGER NOT NULL, --does not include set pieces
    ppa INTEGER NOT NULL, --completed passes into the penalty area not including set pieces
    crspa INTEGER NOT NULL,
    prgp INTEGER NOT NULL, --excludes passes from defending 40%
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_passing (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
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
    xag FLOAT NOT NULL,
    expected_xa FLOAT NOT NULL,
    expected_a_minus_xag FLOAT NOT NULL,
    kp INTEGER NOT NULL, --key passes
    final_third INTEGER NOT NULL, --does not include set pieces
    ppa INTEGER NOT NULL, --completed passes into the penalty area not including set pieces
    crspa INTEGER NOT NULL,
    prgp INTEGER NOT NULL, --excludes passes from defending 40%
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_pass_types (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    att INTEGER NOT NULL,
    pass_types_live INTEGER NOT NULL,
    pass_types_dead INTEGER NOT NULL,
    pass_types_fk INTEGER NOT NULL,
    pass_types_tb INTEGER NOT NULL, --completed pass sent between back defenders into open space
    pass_types_press INTEGER, --passes made while under pressure
    pass_types_sw INTEGER NOT NULL, --passes that travel more than 40 yards of the width of the pitch
    pass_types_crs INTEGER NOT NULL,
    pass_types_ti INTEGER NOT NULL,
    pass_types_ck INTEGER NOT NULL,
    corner_kicks_in INTEGER NOT NULL,
    corner_kicks_out INTEGER NOT NULL,
    corner_kicks_str INTEGER NOT NULL, --straight corner kicks
    height_ground INTEGER,
    height_low INTEGER,
    height_high INTEGER,
    body_parts_left INTEGER,
    body_parts_right INTEGER,
    body_parts_head INTEGER,
    body_parts_ti INTEGER, -- throw ins taken
    body_parts_other INTEGER,
    outcomes_cmp INTEGER NOT NULL,
    outcomes_off INTEGER NOT NULL,
    outcomes_blocks INTEGER NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_pass_types (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    att INTEGER NOT NULL,
    pass_types_live INTEGER NOT NULL,
    pass_types_dead INTEGER NOT NULL,
    pass_types_fk INTEGER NOT NULL,
    pass_types_tb INTEGER NOT NULL, --completed pass sent between back defenders into open space
    pass_types_press INTEGER, --passes made while under pressure
    pass_types_sw INTEGER NOT NULL, --passes that travel more than 40 yards of the width of the pitch
    pass_types_crs INTEGER NOT NULL,
    pass_types_ti INTEGER NOT NULL,
    pass_types_ck INTEGER NOT NULL,
    corner_kicks_in INTEGER NOT NULL,
    corner_kicks_out INTEGER NOT NULL,
    corner_kicks_str INTEGER NOT NULL, --straight corner kicks
    height_ground INTEGER,
    height_low INTEGER,
    height_high INTEGER,
    body_parts_left INTEGER,
    body_parts_right INTEGER,
    body_parts_head INTEGER,
    body_parts_ti INTEGER, -- throw ins taken
    body_parts_other INTEGER,
    outcomes_cmp INTEGER NOT NULL,
    outcomes_off INTEGER NOT NULL,
    outcomes_blocks INTEGER NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_goal_and_shot_creation (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    sca_sca INTEGER NOT NULL, -- shot creating actions
    sca_sca90 FLOAT NOT NULL,
    sca_types_passlive INTEGER NOT NULL,
    sca_types_passdead INTEGER NOT NULl,
    sca_types_to INTEGER NOT NULL,
    sca_types_sh INTEGER NOT NULL,
    sca_types_fld INTEGER NOT NULL,
    sca_types_def INTEGER NOT NULL, -- defensive actions that lead to a shot attempt
    gca_gca INTEGER NOT NULL,
    gca_gca90 FLOAT NOT NULL,
    gca_types_passlive INTEGER NOT NULL,
    gca_types_passdead INTEGER NOT NULL,
    gca_types_to INTEGER NOT NULL,
    gca_types_sh INTEGER NOT NULL,
    gca_types_fld INTEGER NOT NULL,
    gca_types_def INTEGER NOT NULL, -- defensive actions that lead to a goal
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_goal_and_shot_creation (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    sca_sca INTEGER NOT NULL, -- shot creating actions
    sca_sca90 FLOAT NOT NULL,
    sca_types_passlive INTEGER NOT NULL,
    sca_types_passdead INTEGER NOT NULl,
    sca_types_to INTEGER NOT NULL,
    sca_types_sh INTEGER NOT NULL,
    sca_types_fld INTEGER NOT NULL,
    sca_types_def INTEGER NOT NULL, -- defensive actions that lead to a shot attempt
    gca_gca INTEGER NOT NULL,
    gca_gca90 FLOAT NOT NULL,
    gca_types_passlive INTEGER NOT NULL,
    gca_types_passdead INTEGER NOT NULL,
    gca_types_to INTEGER NOT NULL,
    gca_types_fld INTEGER NOT NULL,
    gca_types_def INTEGER NOT NULL, -- defensive actions that lead to a goal
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_defensive_actions (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    tackles_tkl INTEGER NOT NULL,
    tackles_tklw INTEGER NOT NULL,
    tackles_def_3rd INTEGER NOT NULL,
    tackles_mid_3rd INTEGER NOT NULl,
    tackles_att_3rd INTEGER NOT NULL,
    challenges_tkl INTEGER NOT NULL,
    challenges_att INTEGER NOT NULL,
    challenges_tkl_pct FLOAT NOT NULL,
    challenges_lost INTEGER NOT NULL, -- num times dribbled past by an opposing player
    -- pressures_press INTEGER NOT NULL, -- num times applying pressure
    -- pressures_succ INTEGER NOT NULL,
    -- pressures_pct FLOAT NOT NULL, -- successful pressure pct
    -- pressures_def_3rd INTEGER NOT NULL,
    -- pressures_mid_3rd INTEGER NOT NULL,
    -- pressures_att_3rd INTEGER NOT NULL,
    blocks_blocks INTEGER NOT NULL,
    blocks_sh INTEGER NOT NULL,
    -- blocks_shsv INTEGER NOT NULL, -- nunmber of times blocking a shot that was on target
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
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    tackles_tkl INTEGER NOT NULL,
    tackles_tklw INTEGER NOT NULL,
    tackles_def_3rd INTEGER NOT NULL,
    tackles_mid_3rd INTEGER NOT NULl,
    tackles_att_3rd INTEGER NOT NULL,
    challenges_tkl INTEGER NOT NULL,
    challenges_att INTEGER NOT NULL,
    challenges_tkl_pct FLOAT NOT NULL,
    challenges_lost INTEGER NOT NULL, -- num times dribbled past by an opposing player
    -- pressures_press INTEGER NOT NULL, -- num times applying pressure
    -- pressures_succ INTEGER NOT NULL,
    -- pressures_pct FLOAT NOT NULL, -- successful pressure pct
    -- pressures_def_3rd INTEGER NOT NULL,
    -- pressures_mid_3rd INTEGER NOT NULL,
    -- pressures_att_3rd INTEGER NOT NULL,
    blocks_blocks INTEGER NOT NULL,
    blocks_sh INTEGER NOT NULL,
    -- blocks_shsv INTEGER NOT NULL, -- nunmber of times blocking a shot that was on target
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
    num_pl INTEGER NOT NULL,
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
    num_pl INTEGER NOT NULL,
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
    num_pl INTEGER NOT NULL,
    age FLOAT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_mn_per_mp INTEGER NOT NULL, -- minutes played per match played. always 90 not sure why this is a thing
    playing_time_min_pct FLOAT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    starts_starts INTEGER NOT NULL,
    starts_mn_per_start INTEGER,
    starts_compl INTEGER, -- total players who played a full 90 minutes in a game
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
    team_success_xg_plus_minus90 FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_playing_time (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    age FLOAT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_mn_per_mp INTEGER NOT NULL, -- minutes played per match played. always 90 not sure why this is a thing
    playing_time_min_pct FLOAT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    starts_starts INTEGER NOT NULL,
    starts_mn_per_start INTEGER NOT NULL,
    starts_compl INTEGER,
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
    team_success_xg_plus_minus90 FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE squad_miscellaneous_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
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
    performance_recov INTEGER NOT NULL, -- num loose balls recovered
    aerial_duels_won INTEGER NOT NULL,
    aerial_duels_lost INTEGER NOT NULL,
    aerial_duels_won_pct FLOAT NOT NULL,
    PRIMARY KEY(season, squad)
);

CREATE TABLE opponent_stats_squad_miscellaneous_stats (
    season TEXT NOT NULL,
    squad TEXT NOT NULL,
    num_pl INTEGER NOT NULL,
    full_90s FLOAT NOT NULL,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
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
    performance_recov INTEGER NOT NULL, -- num loose balls recovered
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
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL, 
    playing_time_mp INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_gls INTEGER NOT NULL,
    performance_ast INTEGER NOT NULL,
    performance_g_plus_a INTEGER NOT NULL,
    performance_g_minus_pk INTEGER NOT NULL,
    performance_pk INTEGER NOT NULL, -- penalties scored
    performance_pkatt INTEGER NOT NULL,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
    per_90_minutes_gls FLOAT,
    per_90_minutes_ast FLOAT,
    per_90_minutes_g_plus_a FLOAT,
    per_90_minutes_g_minus_pk FLOAT,
    per_90_minutes_g_plus_a_minus_pk FLOAT,
    expected_xg FLOAT,
    expected_npxg FLOAT,
    expected_xag FLOAT,
    expected_npxg_plus_xag FLOAT,
    progression_prgc INTEGER,
    progression_prgp INTEGER,
    progression_prgr INTEGER,
    per_90_minutes_xg FLOAT,
    per_90_minutes_xag FLOAT,
    per_90_minutes_xg_plus_xag FLOAT,
    per_90_minutes_npxg FLOAT,
    per_90_minutes_npxg_plus_xag FLOAT,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE scores_and_fixtures (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    "date" DATE NOT NULL,
    "time" TIMESTAMP NOT NULL,
    comp TEXT NOT NULL,
    "round" TEXT NOT NULL,
    "day" TEXT NOT NULL, -- day of week
    venue TEXT NOT NULL,
    "result" TEXT NOT NULL,
    gf INTEGER NOT NULL,
    ga INTEGER NOT NULL,
    opponent TEXT NOT NULL,
    xg FLOAT,
    xga FLOAT,
    poss INT, -- possession as pct of passes completed
    attendance INTEGER,
    captain TEXT,
    formation TEXT,
    referee TEXT,
    notes TEXT,
    shootout_gf INT,
    shootout_ga INT,
    PRIMARY KEY(season, team, "date")
);

CREATE TABLE player_goalkeeping (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_ga INTEGER,
    performance_ga90 FLOAT,
    performance_sota INTEGER, -- shots on target against
    performance_saves INTEGER,
    performance_save_pct FLOAT,
    performance_w INTEGER,
    performance_d INTEGER,
    performance_l INTEGER,
    performance_cs INTEGER,
    performance_cs_pct FLOAT,
    penalty_kicks_pkatt INTEGER,
    penalty_kicks_pka INTEGER, -- pk goals allowed
    penalty_kicks_pksv INTEGER,
    penalty_kicks_pkm INTEGER,
    penalty_kicks_save_pct FLOAT,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_advanced_goalkeeping (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    goals_ga INTEGER,
    goals_pka INTEGER,
    goals_fk INTEGER,
    goals_ck INTEGER,
    goals_og INTEGER,
    expected_psxg FLOAT,
    expected_psxg_per_sot FLOAT,
    expected_ps_plus_minus FLOAT, -- psxg plus minus
    expected_per_90 FLOAT,
    launched_cmp INTEGER,
    launched_att INTEGER,
    launched_cmp_pct FLOAT,
    passes_att_gk INTEGER, -- passes attempted minus goal kicks
    passes_thr INTEGER,
    passes_launch_pct FLOAT,
    passes_avglen FLOAT,
    goal_kicks_att INTEGER,
    goal_kicks_launch_pct FLOAT,
    goal_kicks_avglen FLOAT,
    crosses_opp INTEGER,
    crosses_stp INTEGER,
    crosses_stp_pct FLOAT,
    sweeper_num_opa INTEGER,
    sweeper_num_opa_per_90 FLOAT,
    sweeper_avgdist FLOAT,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_shooting (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    standard_gls INTEGER NOT NULL,
    standard_sh INTEGER NOT NULL, --shots
    standard_sot INTEGER NOT NULL,
    standard_sot_pct FLOAT,
    standard_sh_per_90 FLOAT,
    standard_sot_per_90 FLOAT,
    standard_g_per_sh FLOAT,
    standard_g_per_sot FLOAT,
    standard_dist FLOAT, --avg distance in yards from goal of shots
    standard_fk INTEGER NOT NULL, --shots from free kicks
    standard_pk INTEGER NOT NULL,
    standard_pkatt INTEGER NOT NULL,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_npxg_per_sh FLOAT,
    expected_g_minus_xg FLOAT,
    expected_npg_minus_xg FLOAT,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_passing (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    total_cmp INTEGER,
    total_att INTEGER,
    total_cmp_pct FLOAT,
    total_totdist INTEGER, --total distance in yards passes have travelled in any direction
    total_prgdist INTEGER,
    short_cmp INTEGER, -- short = 5 < x < 15 yards
    short_att INTEGER,
    short_cmp_pct FLOAT,
    medium_cmp INTEGER, -- medium = 15 < x < 30 yards
    medium_att INTEGER,
    medium_cmp_pct FLOAT,
    long_cmp INTEGER, -- long = x > 30 yards
    long_att INTEGER,
    long_cmp_pct FLOAT,
    ast INTEGER,
    xag FLOAT,
    expected_xa FLOAT,
    expected_a_minus_xag FLOAT,
    kp INTEGER, --key passes
    final_third INTEGER, --does not include set pieces
    ppa INTEGER, --completed passes into the penalty area not including set pieces
    crspa INTEGER,
    prgp INTEGER, --excludes passes from defending 40%
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_pass_types (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    att INTEGER,
    pass_types_live INTEGER,
    pass_types_dead INTEGER,
    pass_types_fk INTEGER,
    pass_types_tb INTEGER, --completed pass sent between back defenders into open space
    -- pass_types_press INTEGER NOT NULL, --passes made while under pressure
    pass_types_sw INTEGER, --passes that travel more than 40 yards of the width of the pitch
    pass_types_crs INTEGER,
    pass_types_ti INTEGER,
    pass_types_ck INTEGER,
    corner_kicks_in INTEGER,
    corner_kicks_out INTEGER,
    corner_kicks_str INTEGER, --straight corner kicks
    -- height_ground INTEGER NOT NULL,
    -- height_low INTEGER NOT NULL,
    -- height_high INTEGER NOT NULL,
    -- body_parts_left INTEGER NOT NULL,
    -- body_parts_right INTEGER NOT NULL,
    -- body_parts_head INTEGER NOT NULL,
    -- body_parts_ti INTEGER NOT NULL, -- throw ins taken
    -- body_parts_other INTEGER NOT NULL,
    outcomes_cmp INTEGER,
    outcomes_off INTEGER,
    outcomes_blocks INTEGER,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_goal_and_shot_creation (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT,
    sca_sca INTEGER, -- shot creating actions
    sca_sca90 FLOAT,
    sca_types_passlive INTEGER,
    sca_types_passdead INTEGER,
    sca_types_to INTEGER,
    sca_types_sh INTEGER,
    sca_types_fld INTEGER, -- fouls drawn
    sca_types_def INTEGER, -- defensive actions that lead to a shot attempt
    gca_gca INTEGER,
    gca_gca90 FLOAT,
    gca_types_passlive INTEGER,
    gca_types_passdead INTEGER,
    gca_types_to INTEGER,
    gca_types_sh INTEGER,
    gca_types_fld INTEGER,
    gca_types_def INTEGER, -- defensive actions that lead to a goal
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
    full_90s FLOAT,
    tackles_tkl INTEGER,
    tackles_tklw INTEGER,
    tackles_def_3rd INTEGER,
    tackles_mid_3rd INTEGER,
    tackles_att_3rd INTEGER,
    challenges_tkl INTEGER,
    challenges_att INTEGER,
    challenges_tkl_pct FLOAT,
    challenges_lost INTEGER, -- num times dribbled past by an opposing player
    -- pressures_press INTEGER NOT NULL, -- num times applying pressure
    -- pressures_succ INTEGER NOT NULL,
    -- pressures_pct FLOAT, -- successful pressure pct
    -- pressures_def_3rd INTEGER NOT NULL,
    -- pressures_mid_3rd INTEGER NOT NULL,
    -- pressures_att_3rd INTEGER NOT NULL,
    blocks_blocks INTEGER,
    blocks_sh INTEGER,
    -- blocks_shsv INTEGER NOT NULL, -- nunmber of times blocking a shot that was on target
    blocks_pass INTEGER,
    interceptions INTEGER, 
    tkl_plus_int INTEGER,
    clr INTEGER,
    err INTEGER, -- mistakes leading to an opponent shot
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_possesion (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    touches_touches INTEGER,
    touches_def_pen INTEGER, -- defensive touches in the defensive penalty area
    touches_def_3rd INTEGER,
    touches_mid_3rd INTEGER,
    touches_att_3rd INTEGER,
    touches_att_pen INTEGER,
    touches_live INTEGER,
    take_ons_att INTEGER,
    take_ons_succ INT,
    take_ons_succ_pct FLOAT,
    take_ons_tkld INTEGER,
    take_ons_tkld_pct INTEGER,
    carries_carries INTEGER,
    carries_totdist INTEGER,
    carries_prgdist INTEGER,
    carries_prgc INTEGER,
    carries_final_third INTEGER,
    carries_cpa INTEGER, -- carries into the pen area
    carries_mis INTEGER, -- miscontrols
    carries_dis INTEGER,
    receiving_rec INTEGER,
    receiving_prgr INTEGER, -- progressive passes recieved
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_playing_time (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    playing_time_mp INTEGER NOT NULL,
    playing_time_min INTEGER NOT NULL,
    playing_time_mn_per_mp INTEGER, -- minutes played per match played
    playing_time_min_pct FLOAT,
    playing_time_full_90s FLOAT NOT NULL,
    starts_starts INTEGER NOT NULL,
    starts_mn_per_start INTEGER,
    starts_compl INTEGER, -- total players who played a full 90 minutes in a game
    subs_subs INTEGER NOT NULL,
    subs_mn_per_sub INTEGER,
    subs_unsub INTEGER NOT NULL,
    team_success_ppm FLOAT, -- points per match when player was involved min 30 mins
    team_success_ong INTEGER, -- goals scored by team while on pitch
    team_success_onga INTEGER,
    team_success_plus_minus INTEGER,
    team_success_plus_minus90 FLOAT,
    team_success_on_minus_off FLOAT,
    team_success_xg_onxg FLOAT,
    team_success_xg_onxga FLOAT,
    team_success_xg_plus_minus FLOAT,
    team_success_xg_plus_minus90 FLOAT,
    team_success_xg_on_minus_off FLOAT,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE player_miscellaneous_stats (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL,
    full_90s FLOAT NOT NULL,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
    performance_2crdy INTEGER,
    performance_fls INTEGER NOT NULL, -- fouls committed
    performance_fld INTEGER NOT NULL, -- fouls drawn
    performance_off INTEGER NOT NULL,
    performance_crs INTEGER NOT NULL,
    performance_int INTEGER NOT NULL,
    performance_tklw INTEGER NOT NULL,
    performance_pkwon INTEGER,
    performance_pkcon INTEGER,
    performance_og INTEGER NOT NULL, -- own goals
    performance_recov INTEGER, -- num loose balls recovered
    aerial_duels_won INTEGER,
    aerial_duels_lost INTEGER,
    aerial_duels_won_pct FLOAT,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE championship_player_standard_stats (
    season TEXT NOT NULL,
	team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    nation TEXT,
    pos TEXT NOT NULL,
    age TEXT NOT NULL, 
    playing_time_mp INTEGER NOT NULL,
    playing_time_starts INTEGER NOT NULL,
    playing_time_min TEXT NOT NULL,
    playing_time_full_90s FLOAT NOT NULL,
    performance_gls INTEGER NOT NULL,
    performance_ast INTEGER NOT NULL,
    performance_g_plus_a INTEGER NOT NULL,
    performance_g_minus_pk INTEGER NOT NULL,
    performance_pk INTEGER NOT NULL, -- penalties scored
    performance_pkatt INTEGER NOT NULL,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
    per_90_minutes_gls FLOAT,
    per_90_minutes_ast FLOAT,
    per_90_minutes_g_plus_a FLOAT,
    per_90_minutes_g_minus_pk FLOAT,
    per_90_minutes_g_plus_a_minus_pk FLOAT,
    expected_xg FLOAT NOT NULL,
    expected_npxg FLOAT NOT NULL,
    expected_xag FLOAT NOT NULL,
    expected_npxg_plus_xag FLOAT NOT NULL,
    progression_prgc INTEGER NOT NULL,
    progression_prgp INTEGER NOT NULL,
    progression_prgr INTEGER NOT NULL,
    per_90_minutes_xg FLOAT,
    per_90_minutes_xag FLOAT,
    per_90_minutes_xg_plus_xag FLOAT,
    per_90_minutes_npxg FLOAT,
    per_90_minutes_npxg_plus_xag FLOAT,
    PRIMARY KEY(season, team, first_name, last_name)
);

CREATE TABLE championship_league_table (
    season TEXT NOT NULL,
    rk INTEGER,
    squad TEXT NOT NULL,
    mp INTEGER NOT NULL,
    w INTEGER NOT NULL,
    d INTEGER NOT NULL,
    l INTEGER NOT NULL,
    gf INTEGER NOT NULL,
    ga INTEGER NOT NULL,
    gd TEXT NOT NULL,
    pts INTEGER NOT NULL,
    pts_per_mp FLOAT,
    xg FLOAT NOT NULL,
    xga FLOAT NOT NULL,
    xgd FLOAT NOT NULL,
    xgd_per_90 FLOAT,
    attendance TEXT,
    top_team_scorer TEXT,
    goalkeeper TEXT,
    notes TEXT,
    PRIMARY KEY(season, squad)
);

CREATE TABLE fpl_fbref_mapping (
    fbref_first_name TEXT,
    fbref_last_name TEXT,
    fpl_first_name TEXT,
    fpl_second_name TEXT,
    season TEXT,
    PRIMARY KEY(fbref_first_name, fbref_last_name, fpl_first_name, fpl_second_name, season)
);

CREATE TABLE player_match_log (
    season TEXT NOT NULL,
    team TEXT NOT NULL,
    first_name TEXT NOT NULL,
    last_name TEXT NOT NULL,
    match_date DATE NOT NULL,
    day_of_week TEXT,
    comp TEXT,
    round TEXT,
    venue TEXT,
    match_result TEXT,
    squad TEXT,
    opponent TEXT,
    did_player_start TEXT,
    pos TEXT,
    played_minutes TEXT,
    performance_gls INTEGER,
    performance_ast INTEGER,
    performance_pk INTEGER,
    performance_pkatt INTEGER,
    performance_sh INTEGER,
    performance_sot INTEGER,
    performance_crdy INTEGER,
    performance_crdr INTEGER,
    performance_touches INTEGER,
    performance_tkl INTEGER,
    performance_int INTEGER,
    performance_blocks INTEGER,
    expected_xg FLOAT,
    expected_npxg FLOAT,
    expected_xag FLOAT,
    sca_sca INTEGER,
    sca_gca INTEGER,
    passes_cmp INTEGER,
    passes_att INTEGER,
    passes_cmp_pct FLOAT,
    passes_prgp INTEGER,
    carries_carries INTEGER,
    carries_prgc INTEGER,
    take_ons_att INTEGER,
    take_ons_succ INTEGER,
    performance_sota INTEGER,
    performance_ga INTEGER,
    performance_saves INTEGER,
    performance_save_pct FLOAT,
    performance_cs INTEGER,
    performance_psxg FLOAT,
    penalty_kicks_pka INTEGER,
    penalty_kicks_pkatt INTEGER,
    penalty_kicks_pksv INTEGER,
    penalty_kicks_pkm INTEGER,
    launched_att INTEGER,
    launched_cmp INTEGER,
    launched_cmp_pct FLOAT,
    passes_att_gk INTEGER,
    passes_thr INTEGER,
    passes_launch_pct FLOAT,
    passes_avglen FLOAT,
    goal_kicks_att INTEGER,
    goal_kicks_avglen FLOAT,
    goal_kicks_launch_pct FLOAT,
    crosses_opp INTEGER,
    crosses_stp INTEGER,
    crosses_stp_pct FLOAT,
    sweeper_num_opa INTEGER,
    sweeper_avgdist FLOAT,
    PRIMARY KEY(season, first_name, last_name, match_date)
);