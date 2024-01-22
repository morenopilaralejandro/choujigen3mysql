/*

database choujigen3ogre

drop database choujigen3ogre;
create database choujigen3ogre;
use choujigen3ogre;
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/choujigen3.sql
*/

/*1-drop*/
drop table if exists link_lock;
drop table if exists link_chest;
drop table if exists link_player;
drop table if exists conn_link;
drop table if exists conn_link_type;
drop table if exists conn_panel;
drop table if exists player_received_during_story;
drop table if exists item_gifted_during_story;
drop table if exists story;
drop table if exists utc_session_drops;
drop table if exists utc_drop_type;
drop table if exists utc_session_develops_stat;
drop table if exists utc_session;
drop table if exists old_pin_badge_exchange;
drop table if exists gacha_yields;
drop table if exists gacha;
drop table if exists tournament_rank_may_drop_item;
drop table if exists tournament_rank_disputed_by_team;
drop table if exists tournament_rank_requires_player;
drop table if exists tournament_name;
drop table if exists tournament_rank;
drop table if exists practice_game_can_drop_item;
drop table if exists item_vscard;
drop table if exists practice_game_dictated_by_pgc;
drop table if exists practice_game;
drop table if exists practice_game_condition;
drop table if exists route_path;
drop table if exists extra_battle_route;
drop table if exists tactic_executed_by_team;
drop table if exists player_plays_during_story_team;
drop table if exists player_is_part_of_team;
drop table if exists team;
drop table if exists item_formation_organized_as_positi;
drop table if exists item_formation;
drop table if exists item_formation_type;
drop table if exists player_decrypted_with_passwd;
drop table if exists player_has_recommended_routine_tm;
drop table if exists player_has_recommended_gear_equipment;
drop table if exists player_has_recommended_slot_hissatsu;
drop table if exists player_learns_hissatsu;
drop table if exists hissatsu_evokes_attri;
drop table if exists hissatsu_restricted_by_hissatsu_special_restriction;
drop table if exists hissatsu_special_restriction;
drop table if exists hissatsu_available_for_positi;
drop table if exists hissatsu_constrained_by_body_type;
drop table if exists hissatsu_limited_by_genre;
drop table if exists hissatsu_evolves;
drop table if exists growth_type_can_achieve_growth_rate;
drop table if exists growth_rate;
drop table if exists growth_type;
drop table if exists hissatsu_skill;
drop table if exists hissatsu_catch;
drop table if exists hissatsu_block;
drop table if exists hissatsu_dribble;
drop table if exists hissatsu_shoot_can_have_shoot_special_property;
drop table if exists hissatsu_shoot;
drop table if exists shoot_special_property;
drop table if exists catch_type;
drop table if exists equipment_strengthens_stat;
drop table if exists item_sold_at_stor;
drop table if exists chest;
drop table if exists npc;
drop table if exists player_found_at_zone;
drop table if exists item_wear;
drop table if exists item_ultimate_note;
drop table if exists item_recovery;
drop table if exists item_key;
drop table if exists item_map;
drop table if exists item_reward_player;
drop table if exists item_currency;
drop table if exists item_equipment;
drop table if exists equipment_type;
drop table if exists item_tactic;
drop table if exists tactic_side;
drop table if exists tactic_type;
drop table if exists item_hissatsu;
drop table if exists hissatsu_type;
drop table if exists item;
drop table if exists item_type;
drop table if exists player;
drop table if exists player_obtention_method;
drop table if exists passwd;
drop table if exists attri;
drop table if exists positi;
drop table if exists body_type;
drop table if exists genre;
drop table if exists training_method_focuses_on_stat;
drop table if exists stat;
drop table if exists training_method;
drop table if exists stor;
drop table if exists stor_type;
drop table if exists zone_building_floor;
drop table if exists zone_building;
drop table if exists zone_level;
drop table if exists zone_inner;
drop table if exists zone_outer;
drop table if exists zone;
drop table if exists zone_type;
drop table if exists region;

/*2-create*/
/*page-zone*/
create table region (
    region_id int not null auto_increment,
    region_name_ja varchar(32),
    region_name_en varchar(32),
    region_name_es varchar(32),
    constraint region_pk primary key (region_id)
);

create table zone_type (
    zone_type_id int not null auto_increment,
    zone_type_name varchar(32),
    constraint zone_type_pk primary key (zone_type_id)
);

create table zone (
    zone_id int not null auto_increment,
    zone_name_ja varchar(32),
    zone_name_en varchar(32),
    zone_name_es varchar(32),
    zone_type_id int,
    constraint zone_pk primary key (zone_id),
    constraint zone_fk_zone_type foreign key (zone_type_id) 
        references zone_type(zone_type_id) on delete cascade
);

create table zone_outer (
    zone_outer_id int not null,
    region_id int,
    constraint zone_outer_pk primary key (zone_outer_id),
    constraint zone_outer_fk_zone foreign key (zone_outer_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_outer_fk_region foreign key (region_id) 
        references region(region_id) on delete cascade
);

create table zone_inner ( 
    zone_inner_id int not null,
    zone_outer_id int,
    constraint zone_inner_pk primary key (zone_inner_id),
    constraint zone_inner_fk_zone foreign key (zone_inner_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_inner_fk_zone_outer foreign key (zone_outer_id) 
        references zone_outer(zone_outer_id) on delete cascade
);

create table zone_level ( 
    zone_level_id int not null,
    zone_inner_id int,
    constraint zone_level_pk primary key (zone_level_id),
    constraint zone_level_fk_zone foreign key (zone_level_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_level_fk_zone_inner foreign key (zone_inner_id) 
        references zone_inner(zone_inner_id) on delete cascade
);

create table zone_building ( 
    zone_building_id int not null,
    zone_level_id int,
    constraint zone_building_pk primary key (zone_building_id),
    constraint zone_building_fk_zone foreign key (zone_building_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_building_fk_zone_level foreign key (zone_level_id) 
        references zone_level(zone_level_id) on delete cascade
);

create table zone_building_floor ( 
    zone_building_floor_id int not null,
    zone_building_id int,
    constraint zone_building_floor_pk primary key (zone_building_floor_id),
    constraint zone_building_floor_fk_zone foreign key (zone_building_floor_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_building_floor_fk_building foreign key (zone_building_id) 
        references zone_building(zone_building_id) on delete cascade
);

create table stor_type ( 
    stor_type_id int not null auto_increment,
    stor_type_name_ja varchar(32),
    stor_type_name_en varchar(32),
    stor_type_name_es varchar(32),
    constraint stor_type_pk primary key (stor_type_id)
);

create table stor ( 
    stor_id int not null auto_increment,
    stor_type_id int,
    zone_id int,
    constraint stor_pk primary key (stor_id),
    constraint stor_fk_stor_type foreign key (stor_type_id) 
        references stor_type(stor_type_id) on delete cascade,
    constraint stor_fk_zone foreign key (zone_id) 
        references zone(zone_id) on delete cascade
);
/*page-training-method*/
create table training_method (
    training_method_id int not null auto_increment,
    training_method_name_ja varchar(32),
    training_method_name_en varchar(32),
    training_method_name_es varchar(32),
    training_method_desc_ja varchar(200),
    training_method_desc_en varchar(200),
    training_method_desc_es varchar(200),
    constraint training_method_pk primary key (training_method_id)
);

create table stat (
    stat_id int not null auto_increment,
    stat_name_ja varchar(32),
    stat_name_en varchar(32),
    stat_name_es varchar(32),
    constraint stat_pk primary key (stat_id)
);

create table training_method_focuses_on_stat (
    training_method_id int not null,
    stat_id int not null,
    constraint training_method_focuses_on_stat_pk 
        primary key (training_method_id, stat_id),    
    constraint training_method_focuses_on_stat_fk_training_method
        foreign key (training_method_id) 
        references training_method(training_method_id) on delete cascade,
    constraint training_method_focuses_on_stat_fk_stat foreign key (stat_id) 
        references stat(stat_id) on delete cascade
);
/*page-player*/
create table genre (
    genre_id int not null auto_increment,
    genre_name_ja varchar(32),
    genre_name_en varchar(32),
    genre_name_es varchar(32),
    genre_symbol varchar(1),
    constraint genre_pk primary key (genre_id)
);

create table body_type (
    body_type_id int not null auto_increment,
    body_type_name_ja varchar(32),
    body_type_name_en varchar(32),
    body_type_name_es varchar(32),
    constraint body_type_pk primary key (body_type_id)
);

create table positi (
    positi_id int not null auto_increment,
    positi_name_ja varchar(32),
    positi_name_en varchar(32),
    positi_name_es varchar(32),
    constraint positi_pk primary key (positi_id)
);

create table attri (
    attri_id int not null auto_increment,
    attri_name_ja varchar(32),
    attri_name_en varchar(32),
    attri_name_es varchar(32),
    constraint attri_pk primary key (attri_id)
);

create table passwd (
    passwd_id int not null auto_increment,
    passwd_ja varchar(32),
    passwd_en varchar(32),
    passwd_es varchar(32),
    constraint passwd_pk primary key (passwd_id)
);

create table player_obtention_method (
    player_obtention_method_id int not null auto_increment,
    player_obtention_method_desc_ja varchar(32),
    player_obtention_method_desc_en varchar(32),
    player_obtention_method_desc_es varchar(32),
    constraint player_obtention_method_pk 
        primary key (player_obtention_method_id)
);

create table player (
    player_id int not null auto_increment,
    player_name_ja varchar(32),
    player_name_hiragana varchar(32),
    player_name_kanji varchar(32),
    player_name_romanji varchar(32),
    player_name_en varchar(32),
    player_name_en_full varchar(32),
    player_initial_lv int,
    player_gp_99 int,
    player_tp_99 int,
    player_kick_99 int,
    player_body_99 int,
    player_control_99 int,
    player_guard_99 int,
    player_speed_99 int,
    player_stamina_99 int,
    player_guts_99 int,
    player_freedom_99 int,
    attri_id int,
    positi_id int,
    genre_id int,
    body_type_id int,
    player_obtention_method_id int,
    original_version int,
    constraint player_pk primary key (player_id),
    constraint player_fk_attri foreign key (attri_id) 
        references attri(attri_id) on delete cascade,
    constraint player_fk_positi foreign key (positi_id) 
        references positi(positi_id) on delete cascade,
    constraint player_fk_genre foreign key (genre_id) 
        references genre(genre_id) on delete cascade,
    constraint player_fk_body_type foreign key (body_type_id) 
        references body_type(body_type_id) on delete cascade,
    constraint player_fk_player_obtention_method 
        foreign key (player_obtention_method_id) 
        references player_obtention_method(player_obtention_method_id) on delete cascade,
    constraint player_fk_player foreign key (original_version) 
        references player(player_id) on delete cascade
);
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/player.sql

/*page-item*/
create table item_type (
    item_type_id int not null auto_increment,
    item_type_name_ja varchar(32),
    item_type_name_en varchar(32),
    item_type_name_es varchar(32),
    constraint item_type_pk primary key (item_type_id)
);

create table item (
    item_id int not null auto_increment,
    item_name_ja varchar(32),
    item_name_en varchar(32),
    item_name_es varchar(32),
    item_price_buy int,
    item_price_sell int,
    item_type_id int,
    constraint item_pk primary key (item_id),
    constraint item_fk_item_type foreign key (item_type_id) 
        references item_type(item_type_id) on delete cascade
);

create table hissatsu_type (
    hissatsu_type_id int not null auto_increment,
    hissatsu_type_name varchar(32),
    constraint hissatsu_type_pk primary key (hissatsu_type_id)
);

create table item_hissatsu (
    item_hissatsu_id int not null,
    hissatsu_type_id int,
    constraint item_hissatsu_pk primary key (item_hissatsu_id),
    constraint item_hissatsu_fk_item foreign key (item_hissatsu_id) 
        references item(item_id) on delete cascade,
    constraint item_hissatsu_fk_hissatsu_type foreign key (hissatsu_type_id) 
        references hissatsu_type(hissatsu_type_id) on delete cascade
);
/*page-tactic*/
create table tactic_type (
    tactic_type_id int not null auto_increment,
    tactic_type_name_ja varchar(32),
    tactic_type_name_en varchar(32),
    tactic_type_name_es varchar(32),
    constraint tactic_type_pk primary key (tactic_type_id)
);

create table tactic_side (
    tactic_side_id int not null auto_increment,
    tactic_side_name_ja varchar(32),
    tactic_side_name_en varchar(32),
    tactic_side_name_es varchar(32),
    constraint tactic_side_pk primary key (tactic_side_id)    
);
/*page-item*/
create table item_tactic (
    item_tactic_id int not null,
    item_tactic_ttp int,
    item_tactic_effect_ja varchar(200),
    item_tactic_effect_en varchar(200),
    item_tactic_effect_es varchar(200),
    tactic_type_id int,
    tactic_side_id int,
    constraint item_tactic_id_pk primary key (item_tactic_id),
    constraint item_tactic_fk_item foreign key (item_tactic_id)
        references item(item_id) on delete cascade,
    constraint item_tactic_fk_tactic_type foreign key (tactic_type_id) 
        references tactic_type(tactic_type_id) on delete cascade,
    constraint item_tactic_fk_tactic_side foreign key (tactic_side_id) 
        references tactic_side(tactic_side_id) on delete cascade
);

create table equipment_type (
    equipment_type_id int not null,
    equipment_type_name_ja varchar(32),
    equipment_type_name_en varchar(32),
    equipment_type_name_es varchar(32),
    constraint equipment_type_pk primary key (equipment_type_id)   
);

create table item_equipment (
    item_equipment_id int not null,
    equipment_type_id int,
    constraint equipment_type_pk primary key (equipment_type_id),
    constraint item_equipment_fk_item foreign key (item_equipment_id)
        references item(item_id) on delete cascade,
    constraint item_equipment_fk_equipment_type foreign key (equipment_type_id) 
        references equipment_type(equipment_type_id) on delete cascade
);

create table item_currency (
    item_currency_id int not null,
    item_currency_carry_limit int,
    constraint item_currency_pk primary key (item_currency_id),
    constraint item_currency_fk_item foreign key (item_currency_id)
        references item(item_id) on delete cascade
);

create table item_reward_player (
    item_reward_player_id int not null,
    player_id int,
    constraint item_reward_player_pk primary key (item_reward_player_id),
    constraint item_reward_player_fk_item foreign key (item_reward_player_id) 
        references item(item_id) on delete cascade,
    constraint item_reward_player_fk_player foreign key (player_id) 
        references player(player_id) on delete cascade
);

create table item_map (
    item_map_id int not null,
    zone_id int,
    constraint item_map_pk primary key (item_map_id),
    constraint item_map_fk_item foreign key (item_map_id)
        references item(item_id) on delete cascade,
    constraint item_map_fk_zone foreign key (zone_id) 
        references zone(zone_id) on delete cascade
);

create table item_key (
    item_key_id int not null,
    zone_building_id int,
    constraint item_key_pk primary key (item_key_id),
    constraint item_key_fk_item foreign key (item_key_id) 
        references item(item_id) on delete cascade,
    constraint item_key_fk_zone_building foreign key (zone_building_id) 
        references zone_building(zone_building_id) on delete cascade
);

create table item_recovery (
    item_recovery_id int not null,
    item_recovery_gp int,
    item_recovery_tp int,
    constraint item_recovery_pk primary key (item_recovery_id),
    constraint item_recovery_fk_item foreign key (item_recovery_id)
        references item(item_id) on delete cascade
);

create table item_ultimate_note (
    item_ultimate_note_id int not null,
    item_ultimate_note_order int,
    constraint item_ultimate_note_pk primary key (item_ultimate_note_id),
    constraint item_ultimate_note_fk_item foreign key (item_ultimate_note_id)
        references item(item_id) on delete cascade
);

create table item_wear (
    item_wear_id int not null,
    item_wear_hex varchar(6), 
    constraint item_wear_pk primary key (item_wear_id),
    constraint item_wear_fk_item foreign key (item_wear_id)
        references item(item_id) on delete cascade
);
/*missing vscard*/
/*page-zone*/
create table player_found_at_zone (
    player_id int not null,
    zone_id int not null,
    is_random boolean,
    hint_ja varchar(200), 
    hint_en varchar(200), 
    hint_es varchar(200),
    constraint player_found_at_zone_pk primary key (player_id),
    constraint player_found_at_zone_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_found_at_zone_fk_zone foreign key (zone_id)
        references zone(zone_id) on delete cascade
);

create table npc (
    npc_id int not null auto_increment,
    npc_name_ja varchar(32),
    npc_name_en varchar(32),
    zone_id int,
    constraint npc_pk primary key (npc_id),
    constraint npc_fk_zone foreign key (zone_id)
        references zone(zone_id) on delete cascade
);

create table chest (
    chest_id int not null auto_increment,
    chest_hint_ja varchar(200), 
    chest_hint_en varchar(200), 
    chest_hint_es varchar(200), 
    zone_id int,
    item_id int,
    constraint chest_pk primary key (chest_id),
    constraint chest_fk_zone foreign key (zone_id)
        references zone(zone_id) on delete cascade,
    constraint chest_fk_item foreign key (item_id)
        references item(item_id) on delete cascade
);

create table item_sold_at_stor (
    stor_id int not null,
    item_id int not null,
    constraint item_sold_at_stor_pk primary key (stor_id, item_id),
    constraint item_sold_at_stor_fk_stor foreign key (stor_id)
        references stor(stor_id) on delete cascade,
    constraint item_sold_at_stor_fk_item foreign key (item_id)
        references item(item_id) on delete cascade
);
/*page-equipment*/
create table equipment_strengthens_stat (
    item_equipment_id int not null,
    stat_id int not null,    
    constraint equipment_strengthens_stat_pk 
        primary key (item_equipment_id, stat_id),
    constraint equipment_strengthens_stat_fk_item_equipment 
        foreign key (item_equipment_id)
        references item_equipment(item_equipment_id) on delete cascade,
    constraint equipment_strengthens_stat_fk_stat foreign key (stat_id)
        references stat(stat_id) on delete cascade
);
/*page-hissatsu*/
create table catch_type (
    catch_type_id int not null auto_increment,
    catch_type_name_ja varchar(32),
    catch_type_name_en varchar(32),
    catch_type_name_es varchar(32),
    constraint catch_type_pk primary key (catch_type_id)
);

create table shoot_special_property (
    shoot_special_property_id int not null auto_increment,
    shoot_special_property_name_ja varchar(32),
    shoot_special_property_name_en varchar(32),
    shoot_special_property_name_es varchar(32),
    constraint shoot_special_property_pk primary key (shoot_special_property_id)
);

create table hissatsu_shoot (
    item_hissatsu_id int not null,
    hissatsu_shoot_power int,
    hissatsu_shoot_tp int,
    hissatsu_shoot_participants int,
    constraint hissatsu_shoot_pk primary key (item_hissatsu_id),
    constraint hissatsu_shoot_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade
);

create table hissatsu_shoot_can_have_shoot_special_property (
    item_hissatsu_id int not null,
    shoot_special_property_id int not null,
    constraint hissatsu_shoot_can_have_spp_pk primary key (item_hissatsu_id),
    constraint hissatsu_shoot_can_have_ssp_fk_hissatsu_shoot foreign key (item_hissatsu_id)
        references hissatsu_shoot(item_hissatsu_id) on delete cascade,
    constraint hissatsu_shoot_can_have_spp_fk_spp foreign key (shoot_special_property_id)
        references shoot_special_property(shoot_special_property_id) on delete cascade
);

create table hissatsu_dribble (
    item_hissatsu_id int not null,
    hissatsu_dribble_power int,
    hissatsu_dribble_tp int,
    hissatsu_dribble_participants int,
    hissatsu_dribble_foul int,
    constraint hissatsu_dribble_pk primary key (item_hissatsu_id),
    constraint hissatsu_dribble_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade
);

create table hissatsu_block (
    item_hissatsu_id int not null,
    hissatsu_block_power int,
    hissatsu_block_tp int,
    hissatsu_block_participants int,
    hissatsu_block_foul int,
    constraint hissatsu_block_pk primary key (item_hissatsu_id),
    constraint hissatsu_block_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade
);

create table hissatsu_catch (
    item_hissatsu_id int not null,
    hissatsu_catch_power int,
    hissatsu_catch_tp int,
    hissatsu_catch_participants int,
    catch_type_id int,
    constraint hissatsu_catch_pk primary key (item_hissatsu_id),
    constraint hissatsu_catch_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_catch_fk_catch_type foreign key (catch_type_id)
        references catch_type(catch_type_id) on delete cascade
);

create table hissatsu_skill (
    item_hissatsu_id int not null,
    hissatsu_skill_effect_ja varchar(400),
    hissatsu_skill_effect_en varchar(400),
    hissatsu_skill_effect_es varchar(400),
    constraint hissatsu_skill_pk primary key (item_hissatsu_id),
    constraint hissatsu_skill_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade
);

create table growth_type (
    growth_type_id int not null auto_increment,
    growth_type_name_ja varchar(32),
    growth_type_name_en varchar(32),
    growth_type_name_es varchar(32),
    constraint growth_type_pk primary key (growth_type_id)
);

create table growth_rate (
    growth_rate_id int not null auto_increment,
    growth_rate_name_ja varchar(32),
    growth_rate_name_en varchar(32),
    growth_rate_name_es varchar(32),
    constraint growth_rate_pk primary key (growth_rate_id)
);

create table growth_type_can_achieve_growth_rate (
    growth_type_id int not null,
    growth_rate_id int not null,
    additional_power int, 
    number_of_uses int,    
    constraint growth_type_can_achieve_growth_rate_pk 
        primary key (growth_type_id, growth_rate_id),
    constraint growth_type_can_achieve_growth_rate_fk_growth_type
        foreign key (growth_type_id)
        references growth_type(growth_type_id) on delete cascade,
    constraint growth_type_can_achieve_growth_rate_fk_growth_rate 
        foreign key (growth_rate_id)
        references growth_rate(growth_rate_id) on delete cascade
);

create table hissatsu_evolves (
    item_hissatsu_id int not null,
    growth_type_id int not null,
    growth_rate_id int not null,
    constraint hissatsu_evolves_pk primary key (item_hissatsu_id, growth_type_id, growth_rate_id),
    constraint hissatsu_evolves_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_evolves_fk_growth_type foreign key (growth_type_id)
        references growth_type(growth_type_id) on delete cascade,
    constraint hissatsu_evolves_fk_growth_rate 
        foreign key (growth_rate_id)
        references growth_rate(growth_rate_id) on delete cascade
);

create table hissatsu_limited_by_genre (
    item_hissatsu_id int not null,
    genre_id int not null,
    constraint hissatsu_limited_by_genre_pk primary key (item_hissatsu_id),
    constraint hissatsu_limited_by_genre_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_limited_by_genre_fk_genre
        foreign key (genre_id)
        references genre(genre_id) on delete cascade
);

create table hissatsu_constrained_by_body_type (
    item_hissatsu_id int not null,
    body_type_id int not null,
    constraint hissatsu_constrained_by_body_type_pk 
        primary key (item_hissatsu_id, body_type_id),
    constraint hissatsu_constrained_by_body_type_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_constrained_by_body_type_fk_body_type
        foreign key body_type(body_type_id)
        references body_type(body_type_id) on delete cascade
);

create table hissatsu_available_for_positi (
    item_hissatsu_id int not null,
    positi_id int not null,
    constraint hissatsu_available_for_positi_pk 
        primary key (item_hissatsu_id, positi_id),
    constraint hissatsu_available_for_positi_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_available_for_positi_fk_positi
        foreign key (positi_id)
        references positi(positi_id) on delete cascade
);

create table hissatsu_special_restriction (
    hissatsu_special_restriction_id int not null auto_increment,
    hissatsu_special_restriction_desc_ja varchar(200),
    hissatsu_special_restriction_desc_en varchar(200),
    hissatsu_special_restriction_desc_es varchar(200),
    constraint hissatsu_special_restriction_pk 
        primary key (hissatsu_special_restriction_id)
);

create table hissatsu_restricted_by_hissatsu_special_restriction (
    item_hissatsu_id int not null,
    hissatsu_special_restriction_id int not null,
    constraint hissatsu_restricted_by_hsp_pk primary key (item_hissatsu_id),
    constraint hissatsu_restricted_by_hsp_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_restricted_by_hsp_fk_hsp foreign key (hissatsu_special_restriction_id)
        references hissatsu_special_restriction(hissatsu_special_restriction_id) on delete cascade
);

create table hissatsu_evokes_attri (
    item_hissatsu_id int not null,
    attri_id int not null,
    constraint hissatsu_evokes_attri_pk primary key (item_hissatsu_id),
    constraint hissatsu_evokes_attri_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_evokes_attri_fk_attri foreign key (attri_id) 
        references attri(attri_id) on delete cascade
);
/*page-player*/
create table player_learns_hissatsu (
    player_id int not null,
    item_hissatsu_id int not null,
    learn_lv int,
    learn_order int,
    constraint player_learns_hissatsu_pk 
        primary key (player_id, item_hissatsu_id),
    constraint player_learns_hissatsu_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_learns_hissatsu_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade
);

create table player_has_recommended_slot_hissatsu (
    player_id int not null,
    item_hissatsu_id int not null,
    constraint player_has_recommended_slot_hissatsu_pk 
        primary key (player_id, item_hissatsu_id),
    constraint player_has_recommended_slot_hissatsu_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_has_recommended_slot_hissatsu_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade
);

create table player_has_recommended_gear_equipment (
    player_id int not null,
    item_equipment_id int not null,
    constraint player_has_recommended_gear_equipment_pk 
        primary key (player_id, item_equipment_id),
    constraint player_has_recommended_gear_equipment_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_has_recommended_gear_equipment_fk_item_equipment 
        foreign key (item_equipment_id)
        references item_equipment(item_equipment_id) on delete cascade
);

create table player_has_recommended_routine_tm (
    player_id int not null,
    training_method_id int not null,
    constraint player_has_recommended_routine_tm_pk 
        primary key (player_id, training_method_id),
    constraint player_has_recommended_routine_tm_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_has_recommended_routine_tm_fk_tm foreign key (training_method_id)
        references training_method(training_method_id) on delete cascade
);

create table player_decrypted_with_passwd (
    player_id int not null,
    passwd_id int not null,
    constraint player_decrypted_with_passwd_pk primary key (player_id, passwd_id),
    constraint player_decrypted_with_passwd_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_decrypted_with_passwd_fk_passwd foreign key (passwd_id)
        references passwd(passwd_id) on delete cascade
);
/*page-team*/
create table item_formation_type (
    item_formation_type_id int not null auto_increment,
    item_formation_type_name_ja varchar(32),
    item_formation_type_name_en varchar(32),
    item_formation_type_name_es varchar(32),
    constraint item_formation_type_pk primary key (item_formation_type_id)
);

create table item_formation (
    item_formation_id int not null auto_increment,
    item_formation_id_name_ja varchar(32),
    item_formation_id_name_en varchar(32),
    item_formation_id_name_es varchar(32),
    item_formation_type_id int,
    constraint item_formation_pk primary key (item_formation_id),
    constraint item_formation_fk_item_formation_type 
        foreign key (item_formation_type_id)
        references item_formation_type(item_formation_type_id) on delete cascade,
    constraint item_formation_fk_item foreign key (item_formation_id)
        references item(item_id) on delete cascade
);

create table item_formation_organized_as_positi (
    item_formation_id int not null,
    positi_id int not null,
    place int not null,
    constraint item_formation_organized_as_positi_pk 
        primary key (item_formation_id, positi_id, place),
    constraint item_formation_organized_as_positi_fk_item_formation 
        foreign key (item_formation_id)
        references item_formation(item_formation_id) on delete cascade,
    constraint item_formation_organized_as_positi_fk_positi foreign key (positi_id)
        references positi(positi_id) on delete cascade
);

create table team (
    team_id int not null auto_increment,
    team_name_ja varchar(32),
    team_name_en varchar(32),
    team_name_es varchar(32),
    item_formation_id int,
    item_wear_id int,
    constraint team_pk primary key (team_id),
    constraint team_fk_item_formation foreign key (item_formation_id)
        references item_formation(item_formation_id) on delete cascade,
    constraint team_fk_item_wear foreign key (item_wear_id)
        references item_wear(item_wear_id) on delete cascade
);

create table player_is_part_of_team (
    player_id int not null,
    team_id int not null,
    place int,
    constraint player_is_part_of_team_pk primary key (player_id, team_id),
    constraint player_is_part_of_team_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_is_part_of_team_fk_team foreign key (team_id)
        references team(team_id) on delete cascade
);

create table player_plays_during_story_team (
    player_id int not null,
    team_id int not null,
    constraint player_plays_during_story_team_pk primary key (player_id),
    constraint player_plays_during_story_team_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_plays_during_story_team_fk_team foreign key (team_id)
        references team(team_id) on delete cascade
);
/*page-tactic*/
create table tactic_executed_by_team (
    item_tactic_id int not null,
    team_id int not null,
    constraint tactic_executed_by_team_pk primary key (item_tactic_id, team_id),
    constraint tactic_executed_by_team_fk_item_tactic 
        foreign key (item_tactic_id)
        references item_tactic(item_tactic_id) on delete cascade,
    constraint tactic_executed_by_team_fk_team foreign key (team_id)
        references team(team_id) on delete cascade
);
/*page-extra-battle-route*/
create table extra_battle_route (
    extra_battle_route_id int not null auto_increment,
    extra_battle_route_name_ja varchar(32),
    extra_battle_route_name_en varchar(32),
    extra_battle_route_name_es varchar(32),
    npc_id int,
    constraint extra_battle_route_pk primary key (extra_battle_route_id),
    constraint extra_battle_route_fk_npc foreign key (npc_id)
        references npc(npc_id) on delete cascade
);

create table route_path (
    route_path_id int not null auto_increment,
    route_path_order int,
    extra_battle_route_id int,
    reward_n int,
    reward_s int,
    constraint route_path_pk primary key (route_path_id),
    constraint route_path_fk_extra_battle_route 
        foreign key (extra_battle_route_id)
        references extra_battle_route(extra_battle_route_id) on delete cascade,
    constraint route_path_fk_item_n foreign key (reward_n)
        references item(item_id) on delete cascade,
    constraint route_path_fk_item_s foreign key (reward_s)
        references item(item_id) on delete cascade
);

create table practice_game_condition (
    practice_game_condition_id int not null auto_increment,
    practice_game_condition_desc_ja varchar(200),
    practice_game_condition_desc_en varchar(200),
    practice_game_condition_desc_es varchar(200),
    constraint practice_game_condition_pk 
        primary key (practice_game_condition_id)
);

create table practice_game (
    practice_game_id int not null auto_increment,
    practice_game_order int,
    route_path_id int,
    team_id int,
    constraint practice_game_pk primary key (practice_game_id),
    constraint practice_game_fk_route_path foreign key (route_path_id)
        references route_path(route_path_id) on delete cascade,
    constraint practice_game_fk_team foreign key (team_id)
        references team(team_id) on delete cascade
);

create table practice_game_dictated_by_pgc (
    practice_game_id int not null,
    practice_game_condition_id int not null,
    constraint practice_game_dictated_by_pgc_pk primary key (practice_game_id),
    constraint practice_game_dictated_by_pgc_fk_practice_game 
        foreign key (practice_game_id)
        references practice_game(practice_game_id) on delete cascade,
    constraint practice_game_dictated_by_pgc_fk_pgc 
        foreign key (practice_game_condition_id)
        references practice_game_condition(practice_game_condition_id) on delete cascade
);

create table item_vscard (
    item_vscard_id int not null,
    practice_game_id int,
    constraint item_vscard_pk primary key (item_vscard_id),
    constraint item_vscard_fk_item foreign key (item_vscard_id) 
        references item(item_id) on delete cascade,
    constraint item_vscard_fk_practice_game foreign key (practice_game_id) 
        references practice_game(practice_game_id) on delete cascade
);

create table practice_game_can_drop_item (
    practice_game_id int not null,
    item_id int not null,
    drop_rate int,
    constraint practice_game_can_drop_item_pk primary key (practice_game_id, item_id),
    constraint practice_game_can_drop_item_fk_practice_game 
        foreign key (practice_game_id)
        references practice_game(practice_game_id) on delete cascade,
    constraint practice_game_can_drop_item_fk_item foreign key (item_id)
        references item(item_id) on delete cascade
);
/*page-tournament-rank*/
create table tournament_rank (
    tournament_rank_id int not null auto_increment,
    tournament_rank_lv_range varchar(5),
    constraint tournament_rank_pk primary key (tournament_rank_id)
);

create table tournament_name (
    tournament_name_id int not null auto_increment,
    tournament_name_ja varchar(32),
    tournament_name_en varchar(32),
    tournament_name_es varchar(32),
    tournament_rank_id int,
    constraint tournament_name_pk primary key (tournament_name_id),
    constraint tournament_name_fk_tournament_rank 
        foreign key (tournament_rank_id)
        references tournament_rank(tournament_rank_id) on delete cascade 
);

create table tournament_rank_requires_player (
    tournament_rank_id int not null,
    player_id int not null,
    constraint tournament_rank_requires_player_pk primary key (player_id),
    constraint tournament_rank_requires_player_fk_tournament_rank 
        foreign key (tournament_rank_id)
        references tournament_rank(tournament_rank_id) on delete cascade,
    constraint tournament_rank_requires_player_fk_player 
        foreign key (player_id)
        references player(player_id) on delete cascade  
);

create table tournament_rank_disputed_by_team (
    tournament_rank_id int not null,
    team_id int not null,
    constraint tournament_rank_disputed_by_team_pk 
        primary key (tournament_rank_id, team_id),
    constraint tournament_rank_disputed_by_team_fk_tournament_rank 
        foreign key (tournament_rank_id)
        references tournament_rank(tournament_rank_id) on delete cascade,
    constraint tournament_rank_disputed_by_team_fk_team
        foreign key (team_id)
        references team(team_id) on delete cascade  
);

create table tournament_rank_may_drop_item (
    tournament_rank_id int not null,
    item_id int not null,
    amount int,
    selection_rate int, 
    drop_rate int,
    no_recover_rate int,
    constraint tournament_rank_may_drop_item_pk 
        primary key (tournament_rank_id, item_id),
    constraint tournament_rank_may_drop_item_fk_tournament_rank 
        foreign key (tournament_rank_id)
        references tournament_rank(tournament_rank_id) on delete cascade,
    constraint tournament_rank_may_drop_item_fk_item
        foreign key (item_id)
        references item(item_id) on delete cascade  
);
/*page-gacha*/
create table gacha (
    gacha_id int not null auto_increment,
    zone_id int,
    constraint gacha_pk primary key (gacha_id),
    constraint gacha_fk_zone foreign key (zone_id)
        references zone(zone_id) on delete cascade  
);

create table gacha_yields (
    gacha_id int not null, 
    player_id int not null,
    item_currency_id int not null,
    constraint gacha_yields_pk 
        primary key (gacha_id, player_id, item_currency_id),
    constraint gacha_yields_fk_gacha foreign key (gacha_id)
        references gacha(gacha_id) on delete cascade,
    constraint gacha_yields_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint gacha_yields_fk_item_currency foreign key (item_currency_id)
        references item_currency(item_currency_id) on delete cascade
);

create table old_pin_badge_exchange (
    old_pin_badge_exchange_id int not null auto_increment,
    old_pin_badge_exchange_amount int,
    item_id int,
    constraint old_pin_badge_exchange_pk 
        primary key (old_pin_badge_exchange_id),
    constraint old_pin_badge_exchange_fk_item foreign key (item_id)
        references item(item_id) on delete cascade  
);
/*page-underground-training-center-session*/
create table utc_session (
    utc_session_id int not null auto_increment,
    utc_session_name_ja varchar(32),
    utc_session_name_en varchar(32),
    utc_session_name_es varchar(32),
    constraint utc_session_pk primary key (utc_session_id)
);

create table utc_session_develops_stat (
    utc_session_id int not null,
    stat_id int not null,
    constraint utc_session_develops_stat_pk 
        primary key (utc_session_id, stat_id),
    constraint utc_session_develops_stat_fk_utc_session 
        foreign key (utc_session_id)
        references utc_session(utc_session_id) on delete cascade,
    constraint utc_session_develops_stat_fk_stat foreign key (stat_id)
        references stat(stat_id) on delete cascade    
);

create table utc_drop_type (
    utc_drop_type_id int not null auto_increment,
    utc_drop_type_name varchar(32),
    constraint utc_drop_type_pk primary key (utc_drop_type_id)
);

create table utc_session_drops (
    utc_session_id int not null,
    item_id int not null,
    utc_drop_type_id int,
    drop_rate int,
    constraint utc_session_drops_pk 
        primary key (utc_session_id, item_id),
    constraint utc_session_drops_fk_utc_session foreign key (utc_session_id)
        references utc_session(utc_session_id) on delete cascade, 
    constraint utc_session_drops_fk_item foreign key (item_id)
        references item(item_id) on delete cascade, 
    constraint utc_session_drops_fk_utc_drop_type 
        foreign key (utc_drop_type_id)
        references utc_drop_type(utc_drop_type_id) on delete cascade 
);
/*page-story*/
create table story (
    story_id int not null auto_increment,
    story_name_ja varchar(32),
    story_name_en varchar(32),
    story_name_es varchar(32),
    constraint story_pk primary key (story_id)
);

create table item_gifted_during_story (
    item_id int not null,
    story_id int not null,
    constraint item_gifted_during_story_pk primary key (item_id, story_id),
    constraint item_gifted_during_story_fk_item foreign key (item_id)
        references item(item_id) on delete cascade, 
    constraint item_gifted_during_story_fk_story foreign key (story_id)
        references story(story_id) on delete cascade 
);

create table player_received_during_story (
    player_id int not null,
    story_id int not null,
    constraint player_received_during_story_pk 
        primary key (player_id, story_id),
    constraint player_received_during_story_fk_player foreign key (player_id)
        references player(player_id) on delete cascade, 
    constraint player_received_during_story_fk_story foreign key (story_id)
        references story(story_id) on delete cascade 
);
/*page-connection-panel*/
create table conn_panel (
    conn_panel_id int not null auto_increment,
    conn_panel_name_ja varchar(32),
    conn_panel_name_en varchar(32),
    conn_panel_name_es varchar(32),
    constraint conn_panel_pk primary key (conn_panel_id)
);

create table conn_link_type (
    conn_link_type_id int not null auto_increment,
    conn_link_type_name varchar(32),
    constraint conn_link_type_pk primary key (conn_link_type_id)
);

create table conn_link (
    conn_link_id int not null auto_increment,
    conn_panel_id int,
    constraint conn_link_pk primary key (conn_link_id),
    constraint conn_link_fk_conn_panel foreign key (conn_panel_id)
        references conn_panel(conn_panel_id) on delete cascade 
);


create table link_player (
    link_player_id int not null, 
    link_player_team_lv int,
    link_player_needs_girl boolean,
    link_player_is_wifi boolean,
    link_player_num_players int,
    player_id int,
    constraint link_player_pk primary key (link_player_id),
    constraint link_player_fk_conn_link foreign key (link_player_id)
        references conn_link(conn_link_id) on delete cascade,
    constraint link_player_fk_player foreign key (player_id)
        references player(player_id) on delete cascade
);

create table link_chest (
    link_chest_id int not null,
    item_id int,
    constraint link_chest_pk primary key (link_chest_id),
    constraint link_chest_fk_conn_link foreign key (link_chest_id)
        references conn_link(conn_link_id) on delete cascade,
    constraint link_chest_fk_item foreign key (item_id)
        references item(item_id) on delete cascade
);

create table link_lock (
    link_lock_id int not null,
    story_id int,
    player_id int,
    constraint link_lock_pk primary key (link_lock_id),
    constraint link_lock_fk_conn_link foreign key (link_lock_id)
        references conn_link(conn_link_id) on delete cascade,
    constraint link_lock_fk_story foreign key (story_id)
        references story(story_id) on delete cascade,
    constraint link_lock_fk_player foreign key (player_id)
        references player(player_id) on delete cascade
);

/*3-insert*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
/*----------------------------------------------------------------------------*/
insert into region (
    region_id, 
    region_name_ja, 
    region_name_en, 
    region_name_es) 
values 
    (1, '日本', 'Japan', 'Japón'),
    (2, 'ライオコット島', 'Liocott Island', 'Isla Liocott'),
    (3, '未来', 'Future', 'Futuro'),
    (4, 'イナズマキャラバン', 'Inazuma Caravan', 'Caravana Inazuma');

insert into zone_type (
    zone_type_id,
    zone_type_name) 
values 
    (1, 'zone-outer'),
    (2, 'zone-inner'),
    (3, 'zone-level'),
    (4, 'zone-building'),
    (5, 'zone-building-floor');

insert into zone (
    zone_id, 
    zone_name_ja, 
    zone_name_en, 
    zone_name_es, 
    zone_type_id) 
values
/*zone-zone_outer*/
    (1, '北東京', 'North Tokyo', 'Norte de Tokio', 1),
    (2, '南東京', 'South Tokyo', 'Sur de Tokio', 1),
    (3, '北海道', 'Hokkaido', 'Hokkaido', 1),
    (4, '奈良', 'Nara', 'Nara', 1),
    (5, '大阪', 'Osaka', 'Osaka', 1),
    (6, '京都', 'Kioto', 'Kioto', 1),
    (7, '愛媛', 'Ehime', 'Ehime', 1),
    (8, '福岡', 'Fukuoka', 'Fukuoka', 1),
    (9, '沖縄', 'Okinawa', 'Okinawa', 1),
    (10, '富士', 'Fuji', 'Fuji', 1),
    (11, 'エントランス', 'Entrance', 'Ciudad', 1),
    (12, 'ジャパンエリア', 'Japan Area', 'Área de Japón', 1),
    (13, 'イギリスエリア', 'UK Area', 'Área de Inglaterra', 1),
    (14, 'ウミヘビ島', 'Sea Snake Island', 'Isla de Hidra', 1),
    (15, 'アルゼンチンエリア', 'Argentina Area', 'Área de Argentina', 1),
    (16, 'ヤマネコ島', 'Wildcat Island', 'Isla del Gato Montés', 1),
    (17, 'アメリカエリア', 'US Area', 'Área de EE.UU.', 1),
    (18, 'クジャク島', 'Peacock Island', 'Isla del Pavo Real', 1),
    (19, 'イタリアエリア', 'Italy Area', 'Área de Iia', 1),
    (20, 'コンドル島', 'Condor Island', 'Isla Cóndor', 1),
    (21, 'ブラジルエリア', 'Brazil Area', 'Área de Brasil', 1),
    (22, 'ウミガメ島', 'Sea Turtle Island', 'Isla de la Tortuga Marina', 1),
    (23, 'コトアールエリア', 'Cotarl Area', 'Costail', 1),
    (24, 'マグニード山', 'Mt.Magnitude', 'Monte Magnitud', 1),
    (25, '未来', 'Future', 'Futuro', 1),
    (26, 'イナズマキャラバン', 'Inazuma Caravan', 'Caravana Inazuma', 1),
/*zone-zone_inner*/
/*north-tokyo*/
    (27, '住宅街', 'Residential Area', 'Zona Residencial', 2),
    (28, '商店街', 'Shopping Street', 'Barrio de Tiendas', 2),
    (29, '雷門中', 'Raimon Junior High', 'Instituto Raimon', 2),
    (30, '河川敷', 'Stream Bed', 'Rivera del Rio', 2),
    (31, '鉄塔', 'Steel Tower', 'Torre', 2),
    (32, '病院', 'Hospital', 'Hospital', 2),
    (33, '駅前', 'Station', 'Estación', 2),
    (34, '傘美野中', 'Umbrella Junior High', 'Instituto Umbrella', 2),
    (35, '帝国学園', 'Royal Academy', 'Royal Academy', 2),
    (36, '裏山', 'Hill Behind', 'Cerro Arcano', 2),
/*south-tokyo*/
    (37, '東京大江戸国際空港', 'Tokyo International Airport', 'Aeropuerto de Tokio', 2),
    (38, 'サッカー協会', 'Football Association', 'Sede de la Asociación de Fútbol', 2),
    (39, 'フロンティアスタジアム', 'Frontier Stadium', 'Estadio Fútbol Frontier', 2),
    (40, '虎ノ屋', 'Hobbes\'s Restaurant', 'Casa Hobbes', 2),
/*hokkaido*/
    (41, '市街地', 'Urban Area', 'Ciudad', 2),
    (42, '大雪原', 'Heavy Snow Field', 'Pico del Norte', 2),
    (43, '白恋中', 'Alpine Junior High', 'Instituto Alpine', 2),
/*nara*/
    (44, '奈良市街地', 'Nara City Area', 'Ciudad', 2),
    (45, 'シカ公園', 'Deer Park', 'Parque Deerfield', 2),
/*osaka*/
    (46, '市街地', 'Urban Area', 'Ciudad', 2),
    (47, 'ナニワランド', 'Naniwaland', 'Osakaland', 2),
/*kioto*/
    (48, '京都市街地', 'Kyoto City Area', 'Ciudad', 2),
    (49, '漫遊寺中', 'Cloister Divinity', 'Claustro Sagrado', 2),
/*ehime*/
    (50, '愛媛市街地', 'Ehime City Area', 'Ciudad', 2),
    (51, '埠頭', 'Pier', 'Puerto', 2),
/*fukuoka*/
    (52, '福岡市街地', 'Fukuoka City Area', 'Ciudad', 2),
    (53, '陽花戸中', 'Fauxshore', 'Fauxshore', 2),
/*okinawa*/
    (54, '沖縄市街地', 'Okinawa City Area', 'Ciudad', 2),
    (55, '大海原中', 'Mary Times Junior High', 'Instituto Mary Times', 2),
/*fuji*/
    (56, '富士の樹海', 'Fuji Forest', 'Bosque del Monte Fuji', 2),
    (57, '星の使徒研究所', 'Fuji Lab', 'Laboratorio M. de las Estrellas', 2),
/*entrance*/
    (58, 'ライオコット空港', 'Liocott Airport', 'Aeropuerto de Liocott', 2),
    (59, 'セントラルパーク', 'Central Park', 'Parque Central', 2),
    (60, 'タイタニックスタジアム', 'Titanic Stadium', 'Estadio Monumental', 2),
    (61, 'ライオコット港', 'Liocott Port', 'Puerto', 2),
    (62, '病院', 'Hospital', 'Hospital', 2),
/*japan-area*/
    (63, '店舗通り', 'Shopping Street', 'Zona de Tiendas', 2),
    (64, '宿舎前', 'Hostel', 'Albergue', 2),
/*uk-area*/
    (65, '噴水通り', 'Fountain Street', 'Calle de la Fuente', 2),
    (66, '空き地前', 'Empty Lot', 'Solar Vacío', 2),
/*sea-snake-island*/
    (67, 'ウミヘビ港', 'Sea Snake Port', 'Puerto Hidra', 2),
    (68, 'スタジアムへの道', 'Road to the Stadium', 'Camino del Estadio', 2),
    (69, 'ウミヘビスタジアム', 'Sea Snake Stadium', 'Estadio Hidra', 2),
/*argentina-area*/
    (70, 'メインストリート', 'Main Street', 'Calle Principal', 2),
    (71, '銅像広場', 'Statue Square', 'Plaza de la Estatua', 2),
    (72, 'Y字路前', 'Y-Intersection', 'Intersección en Y', 2),
/*wildcat-island*/
    (73, 'ヤマネコ港', 'Wildcat Port', 'Puerto Gato Montés', 2),
    (74, 'スタジアムへの道', 'Road to the Stadium', 'Camino del estadio', 2),
    (75, 'ヤマネコスタジアム', 'Wildcat Stadium', 'Estadio Gato Montés', 2),
/*us-area*/
    (76, '入り口前', 'Urban Area', 'Ciudad', 2),
    (77, 'スクラップ広場', 'Scrapping', 'Desguace', 2),
    (78, '駅前広場', 'Station', 'Estación', 2),
/*peacock-island*/
    (79, 'クジャク港', 'Peacock Port', 'Puerto Pavo Real', 2),
    (80, 'スタジアムへの道', 'Road to the Stadium', 'Camino del Estadio', 2),
    (81, 'クジャクスタジアム', 'Peacock Stadium', 'Estadio Pavo Real', 2),
/*italy-area*/
    (82, 'メインストリート', 'Main Street', 'Calle Principal', 2),
    (83, '公園前', 'Park', 'Parque', 2),
    (84, 'グラウンド前', 'Football Court', 'Campo de Fútbol', 2),
/*condor-island*/
    (85, 'コンドル港', 'Condor Port', 'Puerto Cóndor', 2),
    (86, 'コンドルスタジアム', 'Condor Stadium', 'Estadio Cóndor', 2),
/*brazil-area*/
    (87, 'メインストリート', 'Main Street', 'Calle Principal', 2),
    (88, '下道', 'Downtown', 'Calle lateral', 2),
    (89, '路地裏', 'Back Alley', 'Callejón', 2),
/*sea-turtle-island*/
    (90, 'ウミガメ港', 'Sea Turtle Port', 'Puerto Tortuga Marina', 2),
    (91, 'スタジアムへの道', 'Road to the Stadium', 'Camino del Estadio', 2),
    (92, 'ウミガメスタジアム', 'Sea Turtle Stadium', 'Estadio Tortuga Marina', 2),
/*cotarl-area*/
    (93, '入り口前', 'Urban Area', 'Ciudad', 2),
    (94, '広場前', 'Square', 'Lugar de Reunión', 2),
/*mount-magnitude*/
    (95, 'エントランス', 'Entrance', 'Entrada', 2),
/*future*/
    (96, '未来', 'Future', 'Futuro', 2),
/*zone-level-building-building-floor*/
/*north-tokyo-residential-area*/
    (97, '住宅街', 'Residential Area', 'Calle de Mark', 3),
/*north-tokyo-shopping-street*/
    (98, '商店街', 'Shopping Street', 'Barrio de Tiendas', 3),
    (99, '商店街 路地裏', 'Back Alley', 'Calle de Bares', 3),
    (100, '商店街グラウンド', 'Shopping Street Court', 'Campo Barrio de Tiendas', 3),
    (101, '商店街アーケード', 'Shopping Street Gallery', 'Calle Peatonal', 3),
    (102, '商店街 倉庫前', 'Shopping Street Warehouse', 'Zona del Almazén', 3),
/*north-tokyo-raimon-junior-high*/
    (103, '雷門中 正門前', 'Raimon Entrance', 'Entrada del Raimon', 3),
        (104, '合宿所', 'Training Camp', 'Residencia', 4),
                    (105, '1F', 'GF', 'PB', 5),
                    (106, '2F', 'F1', 'P1', 5),
        (107, '正面校舎', 'Main Building', 'Edificio Principal', 4),
                    (108, '1F', 'GF', 'PB', 5),
                    (109, '2F', 'F1', 'P1', 5),
                    (110, '3F', 'F2', 'P2', 5),
    (111, '雷門中 部室前', 'Club Area', 'Area de la Caseta', 3),
        (112, 'サッカー部室', 'Club', 'Club', 4),
            (113, 'サッカー部室', 'Club', 'Club', 5),
            (114, '物置', 'Storage Room', 'Trastero', 5),
            (115, '地下理手長室', 'Underground Bunker', 'Búnker Presidente', 5),
    (116, '雷門中 体育館前', 'Raimon Gym Area', 'Gimnasio Raimon', 3),
        (117, '雷門中 体育館', 'Raimon Gym', 'Gimnasio', 4),
    (118, '駄菓子屋前', 'Sweet Shop Area', 'Zona Tienda Chuches', 3),
        (119, '駄菓子屋', 'Sweet Shop', 'Tienda de Chuches', 4),
/*north-tokyo-stream-bed*/
    (120, '河川敷', 'Stream Bed', 'Ribera del Río', 3),
    (121, '河川敷グラウンド', 'Stream Bed Court', 'Campo del Río', 3),
/*north-tokyo-steel-tower*/
    (122, '鉄塔', 'Steel Tower', 'Torre', 3),
        (123, '鉄塔小屋', 'Steel Tower Hut', 'Caseta', 4),
        (124, '鉄塔上', 'Platform', 'Plataforma', 4),
/*north-tokyo-hospital*/
    (125, '稲妻総合病院 中庭', 'Hospital Courtyard', 'Hospital', 3),
        (126, '稲妻総合病院', 'Hospital', 'Hospital', 4),
            (127, '受付', 'Reception', 'Recepción', 5),
            (128, '2F', 'F1', 'P1', 5),
            (129, '3F', 'F2', 'P2', 5),
/*north-tokyo-station*/
    (130, '稲妻町駅 駅前', 'Inazuma Station Square', 'Estacion Inazuma', 3),
/*north-tokyo-umbrella-junior-high*/
    (131, '傘美野中', 'Umbrella Junior High', 'Instututo Umbrella', 3),
/*north-tokyo-royal-academy*/
    (132, '帝国学園', 'Royal Academy', 'Royal Academy', 3),
    (133, '帝国学園 通路', 'Royal Academy Passage', 'Entrada R. Academy', 3),
/*north-tokyo-arcane-hill*/
    (134, '裏山', 'Hill Behind', 'Cerro Arcano', 3),
/*south-tokyo-tokyo-international-airport*/
    (135, '東京大江戸国際空港', 'Tokyo International Airport', 'Aeropuerto de Tokyo', 3),
        (136, '東京大江戸国際空港', 'Tokyo International Airport', 'Aeropuerto de Tokyo', 4),
/*south-tokyo-football-association*/
    (137, 'サッカー協会前', 'Football Association', 'Asociación de Fútbol', 3),
        (138, 'サッカー協会', 'Football Association', 'Asociación de Fútbol', 4),
            (139, 'サッカー協会 ロビー', 'Lobby', 'Recepción', 5),
            (140, 'サッカー協会 資料室', 'Resource Room', 'Archivo', 5),
/*south-tokyo-frontier-stadium*/
    (141, 'Fスタジアム前', 'Entrance', 'Entrada', 3),
        (142, 'Fスタジアム', 'Frontier Stadium', 'Estadio FF', 4),
            (143, 'Fスタジアム 廊下', 'Corridor', 'Vestíbulo', 5),
            (144, 'Fスタジアム', 'Frontier Stadium', 'Estadio FF', 5),   
/*south-tokyo-toramarus-restaurant*/
    (145, '虎ノ屋周辺', 'Around Hobbes\'s Restaurant', 'Alrededores C.Hobbes', 3),
    (146, '虎ノ屋前', 'Hobbes\'s Restaurant Area', 'Casa Hobbes', 3),
        (147, '虎ノ屋', 'Hobbes\'s Restaurant', 'Casa Hobbes', 4),
/*hokkaido-urban-area*/
    (148, '北海道街中', 'Hokkaido City Center', 'Hokkaido', 3),
/*hokkaido-heavy-snow-field*/
    (149, '北ヶ峰', 'Heavy Snow Field', 'Pico del Norte', 3),
/*hokkaido-alpine-junior-high*/
    (150, '白恋中 校舎側', 'Alpine Junior High Building Side', 'Instituto Alpino', 3),
    (151, '白恋中 グラウンド側', 'Alpine Junior High Court Side', 'Campo Alpino', 3),
/*nara-nara-city-area*/
    (152, '奈良市街地 東側', 'Nara City Area - East Side', 'Nara - Este', 3),
    (153, '奈良市街地 西側', 'Nara City Area - West Side', 'Nara - Oeste', 3), 
/*nara-deer-park*/
    (154, 'シカ公園 市街地側', 'Deer Park', 'Parque Deerfield', 3),
    (155, 'シカ公園 巨シカ像側 ', 'Deer Park Statue Side', 'Estatua P. Deerfield', 3),
/*osaka-urban-area*/
    (156, '大阪市街地', 'Osaka City Area', 'Osaka', 3),
    (157, '大阪市街地 商店街側', 'Shopping Street Side', 'Barrio de Tiendas', 3),
/*osaka-naniwaland*/
    (158, 'ナニワランド 入り口', 'Naniwaland Entrance', 'Ciudad', 3),
    (159, 'ナニワランド 広場', 'Naniwaland Square', 'Osakaland', 3),
/*kioto-kyoto-city-area*/
    (160, '京都市街地', 'Kyoto City Area', 'Kioto', 3),
/*kioto-cloister-divinity*/
    (161, '漫遊寺中', 'Cloister Divinity', 'Claustro Sagrado', 3),
/*ehime-ehime-city-area*/
    (162, '愛媛市街地', 'Ehime City Area', 'Ehime', 3),
/*ehime-pier*/
    (163, '埠頭', 'Pier', 'Puerto', 3),
/*fukuoka-fukuoka-city-area*/
    (164, '福岡市街地', 'Fukuoka City Area', 'Fukuoka', 3),
/*fukuoka-fauxshore*/
    (165, '陽花戸中', 'Fauxshore', 'Fauxshore', 3),
/*okinawa-okinawa-city-area*/
    (166, '沖縄市街地', 'Okinawa City Area', 'Okinawa', 3),
        (167, '灯台', 'Lighthouse', 'Faro', 4),  
            (168, '1F', 'GF', 'PB', 5), 
            (169, '小部屋', 'Small Room', 'Casa del Faro', 5),
            (170, '屋上', 'Rooftop', 'Parte Superior', 5),        
/*okinawa-mary-times-junior-high*/
    (171, '大海原中', 'Mary Times Junior High', 'Mary Times', 3),
/*fuji-fuji-forest
    (172, '', '', 'Entrada del Bosque', 3), 星の使徒研究所
    256 × 192
*/
    (173, '富士の樹海 迷路', 'Fuji Forest Maze', 'Laberinto del Bosque', 3),
    (174, '最果ての洞くつ', 'Forest Cave', 'Cueva del Bosque', 3),
/*fuji-fuji-lab*/
    (175, '研究所駐車場', 'Lab Parking', 'Aparcam. Laboratorio', 3),
    (176, '研究所 迷路', 'Lab Maze', 'Laberinto del Laboratorio', 3),
        (177, 'エイリア石の部屋', 'Alius Stone Room', 'Camara Piedra Alius', 4),
            (178, '下側', 'Lower Side', 'Parte Inferior', 5),
            (179, '上側', 'Upper Side', 'Parte Superior', 5),    
    (180, '星の使徒グラウンド', 'Fuji Lab Court', 'Campo Academia Alius', 3),
/*entrance-liocott-airport*/
    (181, 'ライオコット空港', 'Liocott Airport', 'Aeropuerto de Liocott', 3),
        (182, 'ライオコット空港', 'Liocott Airport', 'Aeropuerto de Liocott', 4),
/*entrance-central-park*/
    (183, 'セントラルパーク', 'Central Park', 'Parque Central', 3),
        (184, '新修練場 受付', 'New Training Center Reception', 'Nuevo C.E. Recepción', 4),
/*entrance-titanic-stadium*/
    (185, 'Tスタジアム前', 'Titanic Stadium Area', 'Estadio Monumental', 3),
        (186, 'Tスタジアム', 'Titanic Stadium', 'Estadio Monumental', 4),
            (187, 'Tスタジアム 廊下', 'Corridor', 'Vestíbulo', 5),
            (188, 'Tスタジアム 控え室 1', 'Waiting Room 1', 'Vestuario 1', 5),
            (189, 'Tスタジアム 控え室 2', 'Waiting Room 2', 'Vestuario 2', 5),
            (190, 'Tスタジアム 控え室 3', 'Waiting Room 3', 'Vestuario 3', 5),
            (191, 'Tスタジアム', 'Titanic Stadium', 'Estadio Monumental', 5),
/*entrance-liocott-port*/
    (192, 'ライオコット港', 'Liocott Port', 'Puerto de Liocott', 3),
/*entrance-hospital*/
    (193, 'ライオコット病院', 'Liocott Hospital', 'Hospital de Liocott', 3),
        (194, 'ライオコット病院', 'Liocott Hospital', 'Hospital de Liocott', 4),
            (195, 'ライオコット病院', 'Liocott Hospital', 'Hospital de Liocott', 5),
            (196, 'ライオコット病院', 'Liocott Hospital', 'Hospital de Liocott', 5),
/*japan-area-shopping-street*/
    (197, '店舗通り', 'Shopping Street', 'Zona de Tiendas', 3),
        (198, '修練場 受付', 'Training Center Reception', 'Recepción C.E.', 4),
/*japan-area-hostel*/
    (199, '宿舎前', 'Hostel Area', 'Albergue', 3),
        (200, '宿舎', 'Hostel', 'Albergue', 4),
            (201, '1F', 'GF', 'PB', 5),
            (202, '2F', 'F1', 'P1', 5),
/*uk-area-fountain-street*/
    (203, '噴水通り', 'Fountain Street', 'Calle de la Fuente', 3),
/*uk-area-empty-lot*/
    (204, '空き地前', 'Empty Lot Area', 'Solar Vacío', 3),
/*sea-snake-island-sea-snake-port*/
    (205, 'ウミヘビ港', 'Sea Snake Port', 'Puerto Hidra', 3),
/*sea-snake-island-road-to-the-stadium*/
    (206, 'スタジアムへの道', 'Road to the Stadium', 'Camino del Estadio', 3),
/*sea-snake-island-sea-snake-stadium*/
    (207, 'ウミヘビスタジアム前', 'Sea Snake Stadium Entrance', 'Estadio Hidra - Entrada', 3),
        (208, 'ウミヘビスタジアム', 'Sea Snake Stadium', 'Estadio Hidra', 4),
/*argentina-area-main-street*/
    (209, 'メインストリート', 'Main Street', 'Calle Principal', 3),
/*argentina-area-statue-square*/
    (210, '銅像広場', 'Statue Square', 'Plaza de la Estatua', 3),
/*argentina-area-y-intersection*/
    (211, 'Y字路前', 'Y-Intersection Area', 'Intersección en Y', 3),
/*wildcat-island-wildcat-port*/
    (212, 'ヤマネコ港', 'Wildcat Port', 'Puerto Gato Montés', 3),
/*wildcat-island-road-to-the-stadium*/
    (213, 'スタジアムへの道', 'Road to the Stadium', 'Camino del Estadio', 3),
/*wildcat-island-wildcat-stadium*/
    (214, 'ヤマネコスタジアム前', 'Wildcat Stadium Entrance', 'E. Gato Montés - Entrada', 3),
        (215, 'ヤマネコスタジアム', 'Wildcat Stadium', 'Estadio Gato Montés', 4),
/*us-area-urban-area*/
    (216, '入り口前', 'Urban Area', 'Ciudad', 3),
/*us-area-scrapping*/
    (217, 'スクラップ広場', 'Scrapping', 'Desguace', 3),
/*us-area-station*/
    (218, '駅前広場', 'Station', 'Estación', 3),
/*peacock-island-peacock-port*/
    (219, 'クジャク港', 'Peacock Port', 'Puerto Pavo Real', 3),
/*peacock-island-road-to-the-stadium*/
    (220, 'スタジアムへの道', 'Road to the Stadium', 'Camino del Estadio', 3),
/*peacock-island-peacock-stadium*/
    (221, 'クジャクスタジアム前', 'Peacock Stadium Entrance', 'E. Pavo Real - Entrada', 3),
        (222, 'クジャクスタジアム', 'Peacock Stadium', 'Estadio Pavo Real', 4),
/*italy-area-main-street*/
    (223, 'メインストリート', 'Main Street', 'Calle Principal', 3),
/*italy-area-park*/
    (224, '公園前', 'Park Area', 'Parque', 3),
/*italy-area-football-court*/
    (225, 'グラウンド前', 'Football Court', 'Campo de Fútbol', 3),
/*condor-island-condor-port*/
    (226, 'コンドル港', 'Condor Port', 'Puerto Cóndor', 3),
/*condor-island-condor-stadium*/
    (227, 'コンドルスタジアム前', 'Condor Stadium Entrance', 'Estadio Cóndor - Entrada', 3),
        (228, 'コンドルタワー', 'Condor Tower', 'Torre Cóndor', 4),
            (229, '1F', 'GF', 'PB', 5),
            (230, '2F', 'F1', 'P1', 5),
            (231, '3F', 'F2', 'P2', 5),
            (232, '4F', 'F3', 'P3', 5),
            (233, '5F', 'F4', 'P4', 5),
            (234, '6F', 'F5', 'P5', 5),
            (235, '7F', 'F6', 'P6', 5),
            (236, 'コンドルスタジアム', 'Condor Stadium', 'Estadio Cóndor', 5),
/*brazil-area-main-street*/
    (237, 'メインストリート', 'Main Street', 'Calle Principal', 3),
    (238, 'ガルシルド邸', 'Zoolan Mansión', 'Mansión de Zoolan', 3),
        (260, 'ガルシルド邸', 'Zoolan Mansión', 'Mansión de Zoolan', 4),
/*brazil-area-downtown*/
    (239, '下道', 'Downtown', 'Calle Lateral', 3),
/*brazil-area-back-alley*/
    (240, '路地裏', 'Back Alley', 'Callejón', 3),
/*sea-turtle-island-sea-turtle-port*/
    (241, 'ウミガメ港', 'Sea Turtle Port', 'Puerto Tortuga Marina', 3),
/*sea-turtle-island-road-to-the-stadium*/
    (242, 'スタジアムへの道', 'Road to the Stadium', 'Camino del Estadio', 3),
/*sea-turtle-island-sea-turtle-stadium*/
    (243, 'ウミガメスタジアム前', 'Sea Turtle Stadium Entrance', 'E. Tortuga M. - Entrada', 3),
        (244, 'ウミガメスタジアム', 'Sea Turtle Stadium', 'Estadio Tortuga Marina', 4),
/*cotarl-area-urban-area*/
    (245, '入り口前', 'Urban Area', 'Ciudad', 3),
/*cotarl-area-square*/
    (246, '広場前', 'Square', 'Lugar de Reunión', 3),
/*mount-magnitude-entrance*/
    (247, 'マグニード山 迷路', 'Mt.Magnitude Maze', 'Laberinto Monte Magnitud', 3),
    (248, 'デモンズゲート', 'Demon\'s Gate', 'Puerta Demoníaca', 3),
    (249, 'ヘブンズガーデン', 'Heaven\'s Garden', 'Jardín Celestial', 3),
    (250, '伝説の地', 'Legendary Land', 'Tierra Legendaria', 3),
/*future-future*/
    (251, '未来 ストリート', 'Future Street', 'El Futuro - Calle', 3),
    (252, '未来 住宅街', 'Future Residential Area', 'El Futuro - Z. Residencial', 3),
        (253, 'カノンの家', 'Canon\'s House', 'Casa de Canon', 4),
    (254, '未来 研究所前', 'Future Research Institute', 'El Futuro - Laboratorio', 3),
        (255, 'キラード研究室', 'Killard\'s Laboratory', 'Laboratorio Prof. Killard', 4),
    (256, '地下道路', 'Underground Tunnel', 'Túnel Subterráneo', 3),
    (257, '下水道', 'Sewer', 'Alacantarilla', 3),
    (258, 'オーガスタジアム前', 'Ogre Stadium Entrance', 'E. Ogro - Entrada', 3),
        (259, 'オーガスタジアム', 'Ogre Stadium', 'Estadio del Ogro', 4);

insert into zone_outer (
    zone_outer_id, 
    region_id) values 
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), 
(11, 2), (12, 2), (13, 2), (14, 2), (15, 2), (16, 2), (17, 2), (18, 2), (19, 2), 
(20, 2), (21, 2), (22, 2), (23, 2), (24, 2), (25, 3), (26, 4);

insert into zone_inner (
    zone_inner_id, 
    zone_outer_id) values 
(27, 1), (28, 1), (29, 1), (30, 1), (31, 1), (32, 1), (33, 1), (34, 1), (35, 1), 
(36, 1), (37, 2), (38, 2), (39, 2), (40, 2), (41, 3), (42, 3), (43, 3), (44, 4),
(45, 4), (46, 5), (47, 5), (48, 6), (49, 6), (50, 7), (51, 7), (52, 8), (53, 8),
(54, 9), (55, 9), 
(56, 10), (57, 10), (58, 11), (59, 11), (60, 11), (61, 11), (62, 11), (63, 12), 
(64, 12), (65, 13), (66, 13), (67, 14), (68, 14), (69, 14), (70, 15), (71, 15),
(72, 15), (73, 16), (74, 16), (75, 16), (76, 17), (77, 17), (78, 17), (79, 18), 
(80, 18), (81, 18), (82, 19), (83, 19), (84, 19), (85, 20), (86, 20), (87, 21), 
(88, 21), (89, 21), (90, 22), (91, 22), (92, 22), (93, 23), (94, 23), (95, 24), 
(96, 25);

insert into zone_level ( 
    zone_level_id,
    zone_inner_id) values
(97, 27), (98, 28), (99, 28), (100, 28), (101, 28), (102, 28), (103, 29), 
(111, 29), (116, 29), (118, 29), (120, 30), (121, 30), (122, 31), (125, 32), 
(130, 33), (131, 34), (132, 35), (133, 35), (134, 36), (135, 37), (137, 38), 
(141, 39), (145, 40), (146, 40), (148, 41), (149, 42), (150, 43), (151, 43), 
(152, 44), (153, 44), (154, 45), (155, 45), (156, 46), (157, 46), (158, 47), 
(159, 47), (160, 48), (161, 49), (162, 50), (163, 51), (164, 52), (165, 53), 
(166, 54), (171, 55), /*(172, 56),*/ (173, 56), (174, 56), (175, 57), (176, 57), 
(180, 57), (181, 58), (183, 59), (185, 60), (192, 61), (193, 62), (197, 63), 
(199, 64), (203, 65), (204, 66), (205, 67), (206, 68), (207, 69), (209, 70), 
(210, 71), (211, 72), (212, 73), (213, 74), (214, 75), (216, 76), (217, 77), 
(218, 78), (219, 79), (220, 80), (221, 81), (223, 82), (224, 83), (225, 84), 
(226, 85), (227, 86), (237, 87), (238, 87), (239, 88), (240, 89), (241, 90), 
(242, 91), (243, 92), (245, 93), (246, 94), (247, 95), (248, 95), (249, 95), 
(250, 95), (251, 96), (252, 96), (254, 96), (256, 96), (257, 96), (258, 96); 

insert into zone_building ( 
    zone_building_id,
    zone_level_id) values
(104, 103), (107, 103), (112, 111), (117, 116), (119, 118), (123, 122),
(124, 122), (126, 125), (136, 135), (138, 137), (142, 141), (147, 146), 
(167, 166), (177, 176), (182, 181), (184, 183), (186, 185), (194, 193), 
(198, 197), (200, 199), (208, 207), (215, 214), (222, 221), (228, 227), 
(244, 243), (253, 252), (255, 254), (259, 258), (260, 238);

insert into zone_building_floor ( 
    zone_building_floor_id,
    zone_building_id) values
(105, 104), (106, 104), (108, 107), (109, 107), (110, 107), (113, 112), 
(114, 112), (115, 112), (127, 126), (128, 126), (129, 126), (139, 138), 
(140, 138), (143, 142), (144, 142), (168, 167), (169, 167), (170, 167), 
(178, 177), (179, 177), (187, 186), (188, 186), (189, 186), (190, 186), 
(191, 186), (195, 194), (196, 194), (201, 200), (202, 200), (229, 228), 
(230, 228), (231, 228), (232, 228), (233, 228), (234, 228), (235, 228),
(236, 228);

insert into stor_type (
    stor_type_id, 
    stor_type_name_ja, 
    stor_type_name_en, 
    stor_type_name_es) values
(1, 'ごくらくマーケット', 'Market', 'Mercazuma'),
(2, 'ペンギーゴ', 'Sport Shop', 'Balón Bazar'),
(3, '秘宝堂', 'Tech Shop', 'Todotécnicas'),
(4, '万屋', 'Salesman', 'Vendedor'),
(5, '最強ショップ', 'Strongest shop', 'Supertienda'),
(6, '真・最強ショップ', 'True Strongest shop', 'Supertienda Redux'),
(7, '駄菓子屋', 'Sweet Shop', 'Tienda de Chuches');

insert into stor (
    stor_id,
    stor_type_id,
    zone_id) values 
/*tokio*/
(1, 1, 98), (2, 2, 98), (3, 2, 101), (4, 1, 130), (5, 4, 116), (6, 5, 109), 
(7, 4, 146), (8, 4, 143),
/*kioto*/
(9, 1, 160), (10, 2, 160),
/*fukuoka*/
(11, 2, 164), (12, 3, 164),
/*nara*/
(13, 2, 152), (14, 1, 153), (15, 3, 152),
/*ehime*/
(16, 1, 162), (17, 3, 162),
/*okinawa*/
(18, 1, 166), (19, 2, 166), (20, 3, 166),
/*hokkaido*/
(21, 2, 148), (22, 1, 148), (23, 3, 148),
/*osaka*/
(24, 1, 156), (25, 2, 157), (26, 3, 157),
/*sea-snake-port*/
(27, 4, 205),
/*wildcat-port*/
(28, 4, 212),
/*condor-port*/
(29, 4, 226),
/*peacock-port*/
(30, 4, 219),
/*sea-turtle-port*/
(31, 4, 241), 
/*cotarl-area*/
(32, 1, 245), (33, 3, 245), (34, 2, 246),
/*brazil-area*/
(35, 1, 237), (36, 2, 240), (37, 3, 239),
/*us-area*/
(38, 2, 217), (39, 1, 216), (40, 3, 218),
/*argentina-area*/
(41, 3, 209), (42, 1, 209), (43, 2, 211),
/*italy-area*/ 
(44, 1, 223), (45, 3, 224), (46, 2, 223),
/*japan-area*/
(47, 1, 197), (48, 3, 197), (49, 2, 197),
/*uk-area*/
(50, 1, 204), (51, 3, 203), (52, 2, 203),
/*mount-magnitude*/
(53, 6, 250),
/*other*/
(54, 7, 119);

insert into training_method (    
    training_method_id,
    training_method_name_ja,
    training_method_name_en,
    training_method_name_es,
    training_method_desc_ja,
    training_method_desc_en,
    training_method_desc_es) values
(1, 'エクスプローシブストライカー', 'Explosive Striker', 'Delantero Explosivo', 
    '最大のショット力。', 
    'Maxed out shooting power.', 
    'Máximo poder de tiro.'),
(2, 'ライトニングストライカー', 'Lightning Striker', 'Delantero Relámpago', 
    '平均的なショット力と高いスピード。', 
    'Average shooting power and high speed.', 
    'Poder de tiro intermedio y elevada rapidez.'),
(3, 'バランスストライカー', 'All-rounder Striker', 'Delantero Todoterreno', 
    'スピードに優れたバランスの取れたシュートとドリブル能力。 攻撃的ミッドフィールダーにも有効です。', 
    'Balanced shooting and dribbling capability with high speed. It also works for offensive midfielders.', 
    'Capacidad equilibrada de tiro y regate con elevada rapidez. También sirve para mediocentros ofensivos.'),
(4, 'エクスプローシブミッドフィールダー', 'Explosive Midfielder', 'Medio Explosivo', 
    'ドリブル力とブロック力は向上しますが、スピードは低下します。', 
    'Greater dribbling and blocking power but lesser speed.', 
    'Mayor poder de regate y bloqueo pero menor rapidez.'),
(5, 'バランス', 'en', 'All-rounder', 
    '高いスピードを備えたバランスの取れたドリブルとブロック能力。', 
    'Balanced dribbling and blocking capability with high speed.', 
    'Capacidad equilibrada de regate y bloqueo con elevada rapidez.'),
(6, 'コントミッドフィールダー', 'Control Midfielder', 'Medio Control', 
    'コントの影響を受けたアクションでゴールを決めることができます。', 
    'It is possible to score a goal with actions influenced by control.', 
    'Permite marcar gol con acciones influenciadas por el control.'),
(7, 'ガッツディフェンダー', 'Guts Defender', 'Defensa Valor', 
    '平均的なブロック能力と高いスピード。', 
    'Average blocking capability and high speed.', 
    'Capacidad de bloqueo intermedia y elevada rapidez.'),
(8, 'ガッツキーパー', 'Guts Keeper', 'Portero Valor', 
    '最大のキャッチ力。', 
    'Maxed out save power.', 
    'Máximo poder de parada.'),
(9, 'スピードキーパー', 'Speed Keeper', 'Portero Rapidez', 
    '平均的なキャッチ能力と高いスピード。', 
    'Average saving capability and high speed.', 
    'Capacidad de parada intermedia y elevada rapidez.');

insert into stat (    
    stat_id,
    stat_name_ja,
    stat_name_en,
    stat_name_es) values
(1, 'GP', 'FP', 'PE'),
(2, 'TP', 'TP', 'PT'),
(3, 'キック', 'Kick', 'Tiro'),
(4, 'ボディ', 'Body', 'Físico'),
(5, 'コント', 'Control', 'Control'),
(6, 'ガード', 'Guard', 'Defensa'),
(7, 'スピード', 'Speed', 'Rapidez'),
(8, 'スタミナ', 'Stamina', 'Aguante'),
(9, 'ガッツ', 'Guts', 'Valor'),
(10, '自由値', 'Freedom', 'Libertad');

insert into training_method_focuses_on_stat (    
    training_method_id,
    stat_id) values
(1, 3), (1, 5), (1, 9),
(2, 3), (2, 7), (2, 9),
(3, 3), (3, 7), (3, 4),
(4, 4), (4, 6), (4, 9),
(5, 4), (5, 6), (5, 7),
(6, 4), (6, 6), (6, 5),
(7, 6), (7, 9), (7, 7),
(8, 6), (8, 4), (8, 9),
(9, 6), (9, 4), (9, 7);

insert into genre (    
    genre_id,
    genre_name_ja,
    genre_name_en,
    genre_name_es,
    genre_symbol) values
(1, '男', 'Male', 'Hombre', '♂'),
(2, '女', 'Female', 'Mujer', '♀');

insert into body_type (    
    body_type_id,
    body_type_name_ja,
    body_type_name_en,
    body_type_name_es) values
(1, '小', 'Small', 'Pequeño'),
(2, '中', 'Medium', 'Normal'),
(3, '大', 'Large', 'Grande'),
(4, '特大', 'Extra Large', 'Gigante');

insert into positi (    
    positi_id,
    positi_name_ja,
    positi_name_en,
    positi_name_es) values
(1, 'FW', 'FW', 'DL'),
(2, 'MF', 'MF', 'MD'),
(3, 'DF', 'DF', 'DF'),
(4, 'GK', 'GK', 'PR');

insert into attri (    
    attri_id,
    attri_name_ja,
    attri_name_en,
    attri_name_es) values
(1, '風', 'Wind', 'Aire'),
(2, '林', 'Wood', 'Bosque'),
(3, '火', 'Fire', 'Fuego'),
(4, '山', 'Earth', 'Montaña');


insert into passwd (
    passwd_id,
    passwd_ja,
    passwd_en,
    passwd_es) values
/*cuarteto del más allá - コロコロ*/
/*lucien thrope (howler) - オオカミ*/
(1, 'つよくてこわい', 'fullmoon', 'lunallena'),
/*lenton gouger (gouger) - ランタン*/
(2, 'こわくてつよい', 'pumpkin', 'calabaza'),
/*titania khamun (wraps) - マミー*/
(3, 'コロコロげんてい', 'wrappedup', 'todavendada'),
/*eveline veitch (vicked) - くろまじょ*/
(4, 'ハロウィンズだ！', 'broomstick', 'vuelaescoba'),
/*tarjeteros - TCG*/
/*bernie ellement (bernie) - ねっけつ	
そしき
ねっけつ
とくしゅ
しっぷう
*/
(5, 'よっつのぞくせい', 'elements', '4elementos'),
/*decker pile (deck) - やまふだ
やまふだ
すてふだ
キラレア
せいた
*/
(6, 'デッキをつくろう', 'buildadeck', 'granbaraja'),
/*larry pogue (pogue) - パック
パック
カード
ファイル
シデン
*/
(7, 'カードであそぼう', 'fullhouse', 'pokerdeases'),
/*walken ruhlbuch (stickler) - チェアマン
チェアマン
おとながい
プロモ
いしどう
*/
(8, 'われらでんどうし', 'followrules', 'siguenormas'),
/*otros*/
/*dino zolletta (zolletta) - ディノ マルディーニ*/
(9, 'いまをまもれ', 'Cappuccino', 'Cappuccino'),
/*isaac glass (isaac) - めがね かずと*/
(10, 'めがねかける', 'William', 'William'),
/*jordan greenway (jordan) - みどりかわ リュウジ*/
(11, 'よくほえる', 'word', 'mordedor'),
(12, 'すべてよし', 'ends well', 'volando'),
(13, 'いっけんにしかず', 'believe', 'bienes'),
(14, 'てんめいをまつ', 'merrier', 'diente'),
/*dave quagmire (quagmire) - さぎぬま おさむ*/
(15, 'グングニル', 'Gungnir', 'Odín'),
(16, 'イプシロン', 'Epsilon', 'Épsilon'),
(17, 'ファースト', 'Kyoto', 'Kioto'),
(18, 'さぎぬまおさむ', 'Dave', 'Quagmire'),
(19, 'ガイア', 'Gaia', 'Gaia'),
/*ファミ通*/
/*andy - あずま
あずま
おおたに
みやさか
まつばら
*/
(20, 'エンター', 'letsplay', 'juguemos'),
/*aurelia dingle - おおたに
あずま
おおたに
みやさか
まつばら
*/
(21, 'ブレイン', 'football', 'alfutbol'),
/*super exp*/
(22, 'ゆうきがあれば', 'moreexp', 'subenivel');

/*ゲット法*/
insert into player_obtention_method (
    player_obtention_method_id,
    player_obtention_method_desc_ja,
    player_obtention_method_desc_en,
    player_obtention_method_desc_es) values
(1, 'ストーリー', 'story', 'historia'),
(2, 'スカウト', 'other team scouting', 'fichaje de otros equipos'),
(3, 'ガチャ', 'gacha', 'gacha'),
(4, '人脈システム', 'connection map', 'mapa de contactos'),
(5, 'ダウンロード', 'download', 'descarga'),
(6, 'パスワード', 'password', 'contraseña'),
(7, 'ミニバトル', 'random battle', 'pachanga'),
/*extra battle route*/
(8, '隠しキャラ', 'special player', 'jugador especial'),
(9, 'リワード', 'reward', 'recompensa'),
(10, 'イベント', 'limited distribution', 'distribución limitada'),
(11, 'プレミアムスカウト', 'premium scout', 'fichaje especial'),
(12, 'オーガプレミアムリンク', 'ogre premium link', 'conexión especial ogro'),
(13, 'スパーク交换', 'trade spark', 'intercambio rayo celeste'),
(14, 'ボンバー交换', 'trade bomber', 'intercambio fuego explosivo'),
(15, '入手不可能', 'unobtainable', 'imposible de conseguir'),
(16, 'なし', 'unknown', 'desconocido');

/*player*/

insert into item_type (
    item_type_id,
    item_type_name_ja,
    item_type_name_en,
    item_type_name_es) values
(1, '必殺技', 'Hissatsu Technique', 'Supertécnicas'),
(2, '装備品', 'Equipment', 'Equipación'),
(3, '通貨', 'Currency', 'Divisa'),
(4, '報酬 選手', 'Reward Player', 'Jugador Recompensa'),
(5, 'マップチケット', 'Map', 'Mapa'),
(6, '鍵', 'Key', 'Llave'),
(7, '対戦チケット', 'VS Card', 'Tarjeta VS'),
(8, '回復', 'Recovery', 'Recuperación'),
(9, 'さいごのノート', 'Ultimate Note', 'Cuaderno Definitivo'),
(10, 'ウェア', 'Uniform', 'Uniforme'),
(11, '必殺タクティクス', 'Hissatsu tactics', 'Supertácticas'),
(12, 'フォーメーション', 'Formation', 'Formación');

insert into item (
    item_id,
    item_name_ja,
    item_name_en,
    item_name_es,
    item_price_buy,
    item_price_sell,
    item_type_id) values
/*必殺技*/
(1, 'スパイラルショット', 'Spiral Shot', 'Remate en Espiral', 400, null, 1),
(2, 'スピニングシュート', 'Spinning Shoot', 'Tiro Giratorio', 400, null, 1),
(3, 'すいせいシュート', 'Comet Shot', 'Tiro del Cometa', 600, null, 1),
(4, 'コンドルダイブ', 'Condor Dive', 'Ataque de Cóndor', 600, null, 1),
(5, 'コロドラシュート', 'Baby Dragon', 'Tiro Chispadraco', 800, null, 1),
(6, 'クロスドライブ', 'Cross Drive', 'Pase Cruzado', 1000, null, 1),
(7, 'バックトルネード', 'Back Tornado', 'Tornado Inverso', 1400, null, 1),
(8, 'ホークショット', 'Hawk Shot', 'Remate Halcón', 1800, null, 1),
(9, 'ツナミブースト', 'Tsunami Boost', 'Remate Tsunami', 1800, null, 1),
(10, 'イナズマおとし', 'Inazuma Drop', 'Trampolín Relámpago', 2200, null, 1),
(11, 'エターナルブリザード', 'Eternal Blizzard', 'Ventisca Eterna', 3200, null, 1),
(12, 'イナズマ1ごう', 'Inazuma-1', 'Súper Relámpago', 2600, null, 1),
(13, 'メガロドン', 'Megalodon', 'Megalodón', 2600, null, 1),
(14, 'ディバインアロー', 'Divine Arrow', 'Flecha Divina', 3600, null, 1),
(15, 'ザ・タイフーン', 'The Typhoon', 'Gran Tifón', 3600, null, 1),
(16, 'レボリューションV', ' Revolution V', 'Remate en V', 4200, null, 1),
(17, 'サンダービースト', 'Thunder Beast', 'Bestia del Trueno', 4200, null, 1),
(18, 'たつまきおとし', 'Whirlwind Drop', 'Torbellino Trampolín', 4200, null, 1),
(19, 'イナズマブレイク', 'Inazuma Break', 'Ruptura Relámpago', 10000, null, 1),
(20, 'ウルフレジェンド', 'Legendary Wolf', 'Aullido de Lobo', 10000, null, 1),
(21, 'ノーザンインパクト', 'Northen Impact', 'Balón Iceberg', 10000, null, 1),
(22, 'ゴッドノウズ', 'God Knows', 'Sabiduría Divina', 10000, null, 1),
(23, 'ワイバーンブリザード', 'Wyvern Blizzard', 'Ventisca Guiverno', 10000, null, 1),
(24, 'トライペガサス', 'Tri-Pegasus', 'Tri-Pegaso', 10000, null, 1),
(25, 'グングニル', 'Gungnir', 'Lanza de Odín', 10000, null, 1),
(26, 'エクスカリバー', 'Excalibur', 'Excalibur', 10000, null, 1),
(27, 'ザ・バース', 'The Dawn', 'La Aurora', 12000, null, 1),
(28, 'ザ・ハリケーン', 'The Hurricane', 'El Huracán', 12000, null, 1),
(29, 'イナズマ1ごうおとし', 'Inazuma-1 Drop', 'Supertrampolín Relámpago', 14000, null, 1),
(30, 'スペースペンギン', 'Space Penguins', 'Pingüino Espacial', 14000, null, 1),
(31, 'プライムレジェンド', 'Prime Legened', 'Cometa Legendario', 14000, null, 1),
(32, 'ゴッドブレイク', 'God Break', 'Disparo Sagrado', 16000, null, 1),
(33, 'ファイアブリザード', 'Fire Blizzard', 'Ventisca de Fuego', 16000, null, 1),
(34, 'クロスファイア', 'Cross Fire', 'Fuego Cruzado', 18000, null, 1),
(35, 'サイコショット', 'Psycho Shot', 'Psicorremate', 400, null, 1),
(36, 'ローリングキック', 'Rolling Kick', 'Disparo Rodante', 400, null, 1),
(37, 'ファントムシュート', 'Phantom Shoot', 'Tiro Fantasma', 600, null, 1),
(38, 'ひゃくれつショット', 'Wrath Shot', 'Chut de los 100 toques', 600, null, 1),
(39, 'フリーズショット', 'Freeze Shot', 'Chut Congelante', 800, null, 1),
(40, 'ラン・ボール・ラン', 'Run Ball Run', 'Balón Rodante', 1000, null, 1),
(41, 'ドラゴンクラッシュ', 'Dragon Crash', 'Remate Dragón', 1000, null, 1),
(42, 'クンフーヘッド', 'Kung Fu Header', 'Cabezazo Kung-Fu', 1400, null, 1),
(43, 'ローズスプラッシュ', 'Bed of Roses', 'Lecho de Rosas', 1400, null, 1),
(44, 'トカチェフボンバー', 'Acrobat Bomber', 'Bomba Acrobática', 1800, null, 1),
(45, 'ダークトルネード', 'Dark Tornado', 'Tornado Oscuro', 1800, null, 1),
(46, 'セキュリティショット', 'Security Shot', 'Remate de Seguridad', 2200, null, 1),
(47, 'アストロブレイク', 'Astro Break', 'Astro Remate', 2200, null, 1),
(48, 'ガニメデプロトン', 'Ganymede Ray', 'Rayo de Ganímedes', 2600, null, 1),
(49, 'にひゃくれつショット', 'Double Wrath Shot', 'Chut de los 200 toques', 3200, null, 1),
(50, 'カードバスター', 'Sweet Deal', 'Full Goleador', 3200, null, 1),
(51, 'ミラージュシュート', 'Mirage Shoot', 'Tiro Espejismo', 3200, null, 1),
(52, 'デュアルストライク', 'Dual Strike', 'Zapatazo Dual', 3600, null, 1),
(53, 'ぶんしんシュート', 'Clone Shot', 'Remate Múltiple', 3600, null, 1),
(54, 'デススピアー', 'Doom Spear', 'Lanza Letal', 3600, null, 1),
(55, 'ワイバーンクラッシュ', 'Wyvern Crash', 'Remate Guiverno', 4200, null, 1),
(56, 'アストロゲート', 'Astro Gate', 'Puerta Astral', 4200, null, 1),
(57, 'ペガサスショット', 'Pegasus Shot', 'Remate Pegaso', 4200, null, 1),
(58, 'こうていペンギン２ごう', 'Emperor Penguin No. 2', 'Pingüino Emperador Nº 2', 10000, null, 1),
(59, 'デスゾーン', 'Death Zone', 'Triángulo Letal', 10000, null, 1),
(60, 'ユニバースブラスト', 'Cosmic Blast', 'Disparo Cósmico', 10000, null, 1),
(61, 'ダブルトルネード', 'Double Tornado', 'Tornado Doble', 10000, null, 1),
(62, 'ドラゴンスレイヤー', 'Dragon Slayer', 'Megadragón', 10000, null, 1),
(63, 'こうていペンギン1ごう', 'Emperor Penguin No.1', 'Pingüino Emperador Nº 1', 12000, null, 1),
(64, 'ダークマター', 'Dark Matter', 'Carga Negativa', 12000, null, 1),
(65, 'ぶんしんデスゾーン', 'Clone Death Zone', 'Triángulo Múltiple', 12000, null, 1),
(66, 'ぶんしんペンギン', 'Clone Penguin', 'Pingüino Múltiple', 12000, null, 1),
(67, 'ダークフェニックス', 'Dark Phoenix', 'Fénix Oscuro', 14000, null, 1),
(68, 'デスゾーン２', 'Death Zone 2', 'Triángulo Letal 2', 14000, null, 1),
(69, 'スーパーノヴァ', 'Supernova', 'Supernova', 14000, null, 1),
(70, 'こうていペンギン3ごう', 'Emperor Penguin No. 3', 'Pingüino Emperador Nº 3', 16000, null, 1),
(71, 'グランフェンリル', 'Gran Fenrir', 'Gran Lobo', 16000, null, 1),
(72, 'シャドウ・レイ', 'Shadow Ray', 'Lluvia Oscura', 16000, null, 1),
(73, 'カオスブレイク', 'Chaos Break', 'Remate Caótico', 18000, null, 1),
(74, 'グレネードショット', 'Grenade Shot', 'Chut Granada', 400, null, 1),
(75, 'あびせげり', 'Heel Kick', 'Tiro Pirueta', 600, null, 1),
(76, 'メテオアタック', 'Meteor Attack', 'Ataque Meteorito', 600, null, 1),
(77, 'ファイアトルネード', 'Fire Tornado', 'Tornado de Fuego', 800, null, 1),
(78, 'パトリオットシュート', 'Patriot Shot', 'Remate Misil', 800, null, 1),
(79, 'ダイナマイトシュート', 'Dynamite Shot', 'Tiro Dinamita', 1400, null, 1),
(80, 'ダブルグレネード', 'Double Grenade', 'Granada Doble', 1400, null, 1),
(81, 'シャインドライブ', 'Shine Drive', 'Tiro Cegador', 1800, null, 1),
(82, 'ドこんじょうバット', 'Utter Gutsiness Bat', 'Bateo Total', 1800, null, 1),
(83, 'つうてんかくシュート', 'Steeple Shot', 'Torre de Osaka', 2200, null, 1),
(84, 'ツインブースト', 'Twin Boost', 'Remate Combinado', 2200, null, 1),
(85, 'アサルトシュート', 'Assault Shot', 'Remate Asalto', 2200, null, 1),
(86, 'RCシュート', 'Remote Combustion', 'Tiro Teledirigido', 2600, null, 1),
(87, 'ガンショット', 'Gun Shot', 'Cañonazo', 3200, null, 1),
(88, 'ドラゴンキャノン', 'Dragon Cannon', 'Cañón Dragón', 3600, null, 1),
(89, 'ドラゴントルネード', 'Dragon Tornado', 'Tornado Dragón', 3600, null, 1),
(90, 'ばくねつストーム', 'Fireball Storm', 'Tormenta de Fuego', 10000, null, 1),
(91, 'ヘルファイア', 'Hellfire', 'Llamarada Infernal', 3600, null, 1),
(92, 'りゅうせいブレード', 'Meteor Blade', 'Cañón de Meteoritos', 4200, null, 1),
(93, 'ほのおのかざみどり', 'Fire Rooster', 'Pájaro de Fuego', 10000, null, 1),
(94, 'デスレイン', 'Doom Rain', 'Lluvia Letal', 10000, null, 1),
(95, 'アトミックフレア', 'Atomic Flare', 'Llamarada Atómica', 10000, null, 1),
(96, 'ばくねつスクリュー', 'Fireball Screw', 'Torbellino de Fuego', 10000, null, 1),
(97, 'ザ・フェニックス', 'The Phoenix', 'Fénix', 10000, null, 1),
(98, 'ツインブーストＦ', 'Twin Boost F', 'Empuje Gemelo F', 10000, null, 1),
(99, 'トライアングルＺ', 'Triangle Z', 'Triángulo Z', 10000, null, 1),
(100, 'トリプルブースト', 'Triple Boost', 'Remate Triple', 10000, null, 1),
(101, 'てんくうおとし', 'Celestial Smash', 'Descenso Estelar', 10000, null, 1),
(102, 'タイガーストーム', 'Tiger Storm', 'Tormenta del Tigre', 12000, null, 1),
(103, 'ダブル・ジョー', 'Double Jaw', 'Mandíbulas Dobles', 12000, null, 1),
(104, 'こうていペンギンX', 'Emperor Penguin X', 'Pingüino Emperador X', 12000, null, 1),
(105, 'マキシマムファイア', 'Maximum Fire', 'Fuego Supremo', 12000, null, 1),
(106, 'ザ・ギャラクシー', 'The Galaxy', 'Tiro Galáctico', 16000, null, 1),
(107, 'ネオ・ギャラクシー', 'Neo Galaxy', 'Neo Tiro Galáctico', 16000, null, 1),
(108, 'ファイアブリザード', 'Fire Blizzard', 'Ventisca de Fuego', 16000, null, 1),
(109, 'グランドファイア', 'Grand Fire', 'Fuego Total', 16000, null, 1),
(110, 'Ｘブラスト', 'X-Blast', 'Disparo X', 18000, null, 1),
(111, 'クロスファイア', 'Crossfire', 'Fuego Helado', 18000, null, 1),
(112, 'ビッグバン', 'Big Bang', 'Big Bang', 18000, null, 1),
(113, 'スネークショット', 'Snake Shot', 'Remate Serpiente', 400, null, 1),
(114, 'ターザンキック', 'Tarzan Kick', 'Remate Tarzán', 400, null, 1),
(115, 'かみかくし', 'Teleport Shot', 'Rapto Divino', 600, null, 1),
(116, 'つちだるま', 'Dirt Ball', 'Bola de Fango', 600, null, 1),
(117, 'クルクルヘッド', 'Gyro Head', 'Cabezazo Yoyó', 800, null, 1),
(118, 'メガトンヘッド', 'Megaton Head', 'Cabezazo Megatón', 1000, null, 1),
(119, 'レインボーループ', 'Rainbow Arc', 'Arcoiris Luminoso', 1400, null, 1),
(120, 'ジャンピングサンダー', 'Leaping Thunder', 'Relámpago Saltón', 1800, null, 1),
(121, 'メガネクラッシュ', 'Spectacle Crash', 'Remate Gafas', 2200, null, 1),
(122, 'クンフーアタック', 'Kung Fu Fighting', 'Técnica Kung-fu', 2200, null, 1),
(123, 'リフレクトバスター', 'Reflect Buster', 'Disparo con Rebotes', 2600, null, 1),
(124, 'タイガードライブ', 'Tiger Drive', 'Remate del Tigre', 2600, null, 1),
(125, 'エッフェルドライブ', 'Eiffel Tower', 'Tiro Torre Eiffel', 3200, null, 1),
(126, 'パラディンストライク', 'Paladin Strike', 'Ataque de Paladín', 3200, null, 1),
(127, 'ドラゴングランド', 'Land Dragon', 'Dragón Terrestre', 3600, null, 1),
(128, 'ドこんじょうクラブ', 'Utter Gutsiness Club', 'Golf Total', 3600, null, 1),
(129, 'バタフライドリーム', 'Butterfly Trance', 'Baile de Mariposas', 4200, null, 1),
(130, 'スリングショット', 'Slingshot', 'Tirachinas', 4200, null, 1),
(131, 'イーグルバスター', 'Eagle Buster', 'Remate del Águila', 10000, null, 1),
(132, 'グラディウスアーチ', 'Gladius Arch', 'Círculo de Espadas', 10000, null, 1),
(133, 'オーディンソード', 'Odin Sword', 'Espada de Odín', 10000, null, 1),
(134, 'ゴッドキャノン', 'Almighty Cannon', 'Cañón Celestial', 10000, null, 1),
(135, 'ストライクサンバ', 'Samba Strike', 'Golpe de Samba', 10000, null, 1),
(136, 'ユニコーンブースト', 'Unicorn Boost', 'Remate Unicornio', 12000, null, 1),
(137, 'ヘブンドライブ', 'Heavenly Drive', 'Remate Celestial', 12000, null, 1),
(138, 'ガイアブレイク', 'Gaia Break', 'Remate de Gaia', 14000, null, 1),
(139, 'ジ・アース', 'The Earth', 'La Tierra', 16000, null, 1),
(140, 'ブレイブショット', 'Brave Shot', 'Disparo Valiente', 16000, null, 1),
(141, 'シャドウ・レイ', 'Shadow Ray', 'Lluvia Oscura', 18000, null, 1),
(142, 'ジェットストリーム', 'Jet Stream', 'Tiro a Reacción', 18000, null, 1),
(143, 'デスブレイク', 'Doom Break', 'Mangual Letal', 18000, null, 1),
(144, 'しっぷうダッシュ', 'Flurry Dash', 'Entrada Huracán', 200, null, 1),
(145, 'たまのりピエロ', 'Rodeo Clown', 'Equilibrismo', 200, null, 1),
(146, 'たつまきせんぷう', 'Whirlwind Twister', 'Torbellino Dragón', 200, null, 1),
(147, 'どくぎりのじゅつ', 'Poison Fog', 'Niebla Venenosa', 400, null, 1),
(148, 'ムーンサルト', 'Moonsault', 'Luna Creciente', 600, null, 1),
(149, 'ジグザグスパーク', 'Zigzag Spark', 'Zig Zag Explosivo', 800, null, 1),
(150, 'リボンシャワー', 'Ribbon Shower', 'Regate Rítmico', 1000, null, 1),
(151, 'カマイタチ', 'Whirlwind Cut', 'Remolino Cortante', 1400, null, 1),
(152, 'オーロラドリブル', 'Aurora Dribble', 'Regate Aurora', 1800, null, 1),
(153, 'オオウチワ', 'Big Fan', 'Paipay Gigante', 2200, null, 1),
(154, 'ビッグカード', 'Card Slap', 'Descarte', 2800, null, 1),
(155, 'あいきどう', 'Aikido', 'Aikido', 3200, null, 1),
(156, 'ダッシュストーム', 'Dash Storm', 'Entrada Tormenta', 3200, null, 1),
(157, 'ヘブンズタイム', 'Heaven\'s Time', 'Hora Celestial', 3600, null, 1),
(158, 'ウォーターベール', 'Water Veil', 'Bomba Géiser', 4200, null, 1),
(159, 'ふうじんのまい', 'Wind God\'s Dance', 'Danza del Viento', 4200, null, 1),
(160, 'エンゼルボール', 'Angel Ball', 'Balón Angelical', 10000, null, 1),
(161, 'エアライド', 'Air Ride', 'Patín Aéreo', 10000, null, 1),
(162, 'のろい', 'Black Magic', 'Maldición', 200, null, 1),
(163, 'マジック', 'Magic', 'Truco de Magia', 200, null, 1),
(164, 'スーパースキャン', 'Attack Scan', 'Escáner Ataque', 600, null, 1),
(165, 'イリュージョンボール', 'Illusion Ball', 'Espejismo de Balón', 600, null, 1),
(166, 'ざんぞう', 'Afterimage', 'Espejismo', 1000, null, 1),
(167, 'ワープドライブ', 'Warp Drive', 'Teleportación', 1400, null, 1),
(168, 'たつまきどくぎり', 'Dark Whirlwind', 'Tornado Venenoso', 1600, null, 1),
(169, 'まぼろしドリブル', 'Deceptor Dribble', 'Regate Espejismo', 1800, null, 1),
(170, 'ぶんしんフェイント', 'Clone Faker', 'Regate Múltiple', 2200, null, 1),
(171, 'ウルトラムーン', 'Ultra Moon', 'Ultra Lunar', 2800, null, 1),
(172, 'エコーボール', 'Echo Ball', 'Cúpula Sónica', 2800, null, 1),
(173, 'マタドールフェイント', 'Matador Feint', 'Engaño Torero', 3200, null, 1),
(174, 'サザンクロスカット', 'Southern Cross', 'Cruz del Sur', 3800, null, 1),
(175, 'デュアルパス', 'Dual Pass', 'Tuya-mía Doble', 4200, null, 1),
(176, 'デビルボール', 'Devil Ball', 'Balón Diabólico', 10000, null, 1),
(177, 'キラーフィールズ', 'Field of Force', 'Campo de Fuerza', 10000, null, 1),
(178, 'ひとりワンツー', 'Double Touch', 'Pared Solitaria', 200, null, 1),
(179, 'フーセンガム', 'Bubble Gum', 'Pompa de Chicle', 600, null, 1),
(180, 'ヒートタックル', 'Heat Tackle', 'Corte Flamígero', 800, null, 1),
(181, 'ならくおとし', 'Abaddon Drop', 'Tacón Infernal', 1200, null, 1),
(182, 'ジャッジスルー', 'Breakthrough', 'Coz', 1600, null, 1),
(183, 'ドッグラン', 'Dog Run', 'Balón Galgo', 1200, null, 1),
(184, 'メテオシャワー', 'Meteor Shower', 'Lluvia de Meteoros', 1800, null, 1),
(185, 'れっぷうダッシュ', 'Gale Dash', 'Avance Flamígero', 2200, null, 1),
(186, 'ライアーショット', 'Liar Shot', 'Amago de Tiro', 2800, null, 1),
(187, 'アルマジロサーカス', 'Armadillo Circus', 'Armadillo Circense', 3200, null, 1),
(188, 'ライトニングアクセル', 'Lightning Sprin', 'Acelerrelámpago', 3200, null, 1),
(189, 'フレイムベール', 'Flame Veil', 'Pantalla Ígnea', 4200, null, 1),
(190, 'ジャッジスルー２', 'Breakthrough 2', 'Coz 2', 4400, null, 1),
(191, 'ジ・イカロス', 'The Ikaros', 'Vuelo de Ícaro', 10000, null, 1),
(192, 'ブーストグライダー', 'Boost Glider', 'Potenciación', 10000, null, 1),
(193, 'ジャッジスルー３', 'Breakthrough 3', 'Coz 3', 10000, null, 1),
(194, 'ダッシュアクセル', 'Dash Accelerator', 'Acelerón', 200, null, 1),
(195, 'モンキーターン', 'Monkey Turn', 'Giro de Mono', 200, null, 1),
(196, 'スーパーアルマジロ', 'Super Armadillo', 'Superarmadillo', 600, null, 1),
(197, 'ごりむちゅう', 'Bewildered', 'Confusión', 800, null, 1),
(198, 'カンガルーキック', 'Kangaroo Kick', 'Patada Canguro', 1000, null, 1),
(199, 'モグラフェイント', 'Mole Fake', 'Regate Topo', 1200, null, 1),
(200, 'プリマドンナ', 'Prima Donna', 'Prima Donna', 1800, null, 1),
(201, 'シザース・ボム', 'Bewilder Blast', 'Ignición', 1800, null, 1),
(202, 'とうめいフェイント', 'Invisible Fake', 'Descodificación', 2200, null, 1),
(203, 'モグラシャッフル', 'Mole Shuffle', 'Sorteo de Balón', 2200, null, 1),
(204, 'Ｕ・ボート', 'Sub-Terfuge', 'Inmersión', 3600, null, 1),
(205, 'じごくぐるま', 'Rolling Hell', 'Rueda Infernal', 3200, null, 1),
(206, 'ニニンサンキャク', 'Three-Legged Rush', 'Carrera a tres Piernas', 3200, null, 1),
(207, 'スーパーエラシコ', 'Super Elastico', 'Súper Elástico', 10000, null, 1),
(208, 'トリプルダッシュ', 'Triple Dash', 'Sprint Triple', 10000, null, 1),
(209, 'コイルターン', 'Coil Turn', 'Giro Bobina', 200, null, 1),
(210, 'ブレードアタック', 'Blade Attack', 'Ataque Afilado', 600, null, 1),
(211, 'アイスグランド', 'Land of Ice', 'Paisaje Helado', 600, null, 1),
(212, 'スピニングカット', 'Spinning Cut', 'Corte Giratorio', 1200, null, 1),
(213, 'デザートストーム', 'Desert Blast', 'Tormenta de Arena', 200, null, 1),
(214, 'サイクロン', 'Cyclone', 'Ciclón', 1800, null, 1),
(215, 'プロファイルゾーン', 'Perimeter Zone', 'Zona de Seguridad', 2200, null, 1),
(216, 'ザ・タワー', 'The Tower', 'Torre Inexpugnable', 2200, null, 1),
(217, 'せんぷうじん', 'Whirlwind Force', 'Campo Torbellino', 2600, null, 1),
(218, 'しんくうま', 'Vac Attack', 'Golpe de Vacío', 2600, null, 1),
(219, 'スノーエンジェル', 'Snow Angel', 'Angel de Nieve', 3200, null, 1),
(220, 'ダブルサイクロン', 'Double Cyclone', 'Ciclón Doble', 3200, null, 1),
(221, 'ホエールガード', 'Whale Guard', 'Bloqueo Ballena', 3600, null, 1),
(222, 'フローズンスティール', 'Frozen Steal', 'Rompehielos', 4200, null, 1),
(223, 'ゴー・トゥ・ヘブン', 'Heaven\'s Ascent', 'Subida a los Cielos', 10000, null, 1),
(224, 'パーフェクト・タワー', 'Perfect Tower', 'Torre Perfecta', 10000, null, 1),
(225, 'ハリケーンアロー', 'Hurricane Arrows', 'Flecha Huracán', 10000, null, 1),
(226, 'クイックドロウ', 'Quick Draw', 'Robo Rápido', 200, null, 1),
(227, 'ドッペルゲンガー', 'Doppelganger', 'Doppelgänger', 200, null, 1),
(228, 'おんりょう', 'Ghost Pull', 'Gravedad', 400, null, 1),
(229, 'キラースライド', 'Killer Slide', 'Barrido Defensivo', 600, null, 1),
(230, 'スーパースキャン', 'Defence Scan', 'Escáner Defensa', 600, null, 1),
(231, 'フェイクボール', 'Fake Ball', 'Bola Falsa', 1000, null, 1),
(232, 'くものいと', 'Spider Web', 'Telaraña', 1200, null, 1),
(233, 'ウェルカムバック', 'Yo-Yo Ball', 'Engaño Yoyó', 1400, null, 1),
(234, 'かげぬい', 'Shadow Stitch', 'Ataque Sombrío', 1800, null, 1),
(235, 'グッドスメル', 'Sleeping Dust', 'Olor Embriagador', 1800, null, 1),
(236, 'ぶんしんディフェンス', 'Clone Defence', 'Defensa Múltiple', 2200, null, 1),
(237, 'スニーキングレイド', 'Am-Bush', 'Emboscada', 2800, null, 1),
(238, 'アステロイドベルト', 'Asteroid Belt', 'Cinto Astral', 3200, null, 1),
(239, 'デュアルストーム', 'Dual Storm', 'Dúo Magma', 3200, null, 1),
(240, 'ハーヴェスト', 'Harvest', 'Vendimia', 3800, null, 1),
(241, 'ロックウォールダム', 'Stone Wall', 'Presa', 4200, null, 1),
(242, 'デーモンカット', 'Diabolical Cut', 'Corte Diabólico', 4200, null, 1),
(243, 'ゴー・トゥ・ヘル', 'Caída a los Infiernos', 'Caída a los Infiernos', 10000, null, 1),
(244, 'シグマゾーン', 'Sigma Zone', 'Zona Sigma', 10000, null, 1),
(245, 'ジャイアントスピン', 'Supreme Spin', 'Superpeonza', 400, null, 1),
(246, 'フォトンフラッシュ', 'Photon Crash', 'Flash de Fotones', 600, null, 1),
(247, 'スーパーしこふみ', 'Super Sumo Stomp', 'Super Pisotón de Sumo', 600, null, 1),
(248, 'フェイクボンバー', 'Fake Bomber', 'Bombazo', 1000, null, 1),
(249, 'じばしりかえん', 'Racing Flame', 'Estela Ígnea', 1200, null, 1),
(250, 'ジグザグフレイム', 'Zigzag Flame', 'Zigzag de Fuego', 1400, null, 1),
(251, 'フレイムダンス', 'Flame Dance', 'Baile de Llamas', 1800, null, 1),
(252, 'ボルケイノカット', 'Volcano Cut', 'Corte Volcánico', 2200, null, 1),
(253, 'ローリングスライド', 'Rolling Slide', 'Entrada Rodante', 2200, null, 1),
(254, 'さばきのてっつい', 'Divine Stamp', 'Apisonadora', 2800, null, 1),
(255, 'シューティングスター', 'Shooting Star', 'Cometa', 3200, null, 1),
(256, 'プラネットシールド', 'Planet Shield', 'Robo Planeta', 3600, null, 1),
(257, 'イグナイトスティール', 'Ignite Steal', 'Cortafuegos', 4200, null, 1),
(258, 'マッドエクスプレス', 'Mad Express', 'Tren Loco', 10000, null, 1),
(259, 'しこふみ', 'Sumo Stomp', 'Pisotón de Sumo', 200, null, 1),
(260, 'ホーントレイン', 'Horn Train', 'Embestida', 400, null, 1),
(261, 'うしろのしょうめん', 'About Face', 'Sorpresa', 600, null, 1),
(262, 'ザ・ウォール', 'The Wall', 'El Muro', 1000, null, 1),
(263, 'アースクェイク', 'Earthquake', 'Sismo', 1200, null, 1),
(264, 'グレイブストーン', 'Gravestone', 'Dientes de Roca', 1400, null, 1),
(265, 'グラビテイション', 'Gravitation', 'Gravitación', 1800, null, 1),
(266, 'パワーチャージ', 'Power Charge', 'Placaje Extremo', 1800, null, 1),
(267, 'ヘビーベイビー', 'Heavy Mettle', 'Gravedad Grave', 2200, null, 1),
(268, 'ストーンプリズン', 'Stone Prison', 'Jaula de Piedra', 2200, null, 1),
(269, 'メガクェイク', 'Mega Quake', 'Mega Terremoto', 2600, null, 1),
(270, 'アイアンウォール', 'Iron Wall', 'Muro de Hierro', 2600, null, 1),
(271, 'ブロックサーカス', 'Circus Block', 'Voltereta Circense', 3200, null, 1),
(272, 'メガウォール', 'Mega Wall', 'Gran Sabio', 3600, null, 1),
(273, 'ロードローラタックル', 'Road Roller', 'Aplanadora', 3600, null, 1),
(274, 'バーバリアンのたて', 'Barbarian Shield', 'Escudo Bárbaro', 4200, null, 1),
(275, 'ノーエスケイプ', 'No Escape', 'Emboscada Defensiva', 4400, null, 1),
(276, 'グランドクェイク', 'Ground Quake', 'Gran Seísmo', 10000, null, 1),
(277, 'ザ・マウンテン', 'The Mountain', 'La Montaña', 10000, null, 1),
(278, 'ボディシールド', 'Body Shield', 'Escudo corporal', 10000, null, 1),
(279, 'かごめかごめ', 'Bamboo Pattern', 'Trama', 10000, null, 1),
(280, 'スワンダイブ', 'Swan Dive', 'Salto del Cisne', 200, null, 1),
(281, 'トルネードキャッチ', 'Tornado Catch', 'Atajo Tornado', 400, null, 1),
(282, 'こがらし', 'Mistral', 'Hojarasca', 600, null, 1),
(283, 'はなふぶき', 'Flower Power', 'Tormenta de Pétalos', 1000, null, 1),
(284, 'つむじ', 'Whirlwind', 'Torbellino', 1200, null, 1),
(285, 'オーロラカーテン', 'Aurora Curtain', 'Cortina Aurora', 1400, null, 1),
(286, 'せいぎのてっけん', 'Fist of Justice', 'Super Puño Invencible', 1800, null, 1),
(287, 'ガラティーン', 'Galatyn', 'Espada Defensora', 1800, null, 1),
(288, 'グレートバリアリーフ', 'Barrier Reef', 'Gran Barrera de Coral', 1800, null, 1),
(289, 'セーフティプロテクト', 'Safety First', 'Muralla de Escudos', 2200, null, 1),
(290, 'つなみウォール', 'Tsunami Wall', 'Muralla Tsunami', 2600, null, 1),
(291, 'ストームライダー', 'Storm Rider', 'Simún', 2600, null, 1),
(292, 'ニードルハンマー', 'Needle Hammer', 'Martillo Defensor', 3200, null, 1),
(293, 'エレキトラップ', 'Electrap', 'Malla Eléctrica', 3600, null, 1),
(294, 'アイスブロック', 'Ice Block', 'Bloque de Hielo', 4200, null, 1),
(295, 'プロキオンネット', 'Procyon Net', 'Constelación Estelar', 10000, null, 1),
(296, 'じくうのかべ', 'Temporal Wall', 'Muro Dimensional', 14000, null, 1),
(297, 'ホーリーゾーン', 'Celestial Zone', 'Zona Sagrada', 14000, null, 1),
(298, 'ハイボルテージ', 'High Voltage', 'Voltaje Dual', 14000, null, 1),
(299, 'キラーブレード', 'Killer Blade', 'Cuchilla Asesina', 200, null, 1),
(300, 'ゆがむくうかん', 'Warp Space', 'Espiral de Distorsión', 400, null, 1),
(301, 'ゴッドハンド', 'God Hand', 'Mano Celestial', 0, null, 1),
(302, 'シュートポケット', 'Shot Pocket', 'Campo de Fuerza', 1000, null, 1),
(303, 'スラッシュネイル', 'Claw Slash', 'Uñas Afiladas', 1200, null, 1),
(304, 'マジン・ザ・ハンド', 'Mano Mágica', 'Majin the Hand', 0, null, 1),
(305, 'ブラックホール', 'Black Hole', 'Agujero Negro', 1400, null, 1),
(306, 'スティンガー', 'The Stinger', 'Aguijón', 1800, null, 1),
(307, 'ワームホール', 'Wormhole', 'Agujero de Gusano', 2200, null, 1),
(308, 'ぶんしんブロック', 'Clone Block', 'Parada Múltiple', 3200, null, 1),
(309, 'ビッグスパイダー', 'Giant Spider', 'Araña Gigante', 3600, null, 1),
(310, 'デュアルスマッシュ', 'Dual Smash', 'Bloqueo Doble', 3600, null, 1),
(311, 'ムゲン・ザ・ハンド', 'Mugen The Hand', 'Manos Infinitas', 4200, null, 1),
(312, 'イジゲン・ザ・ハンド', 'Dimensional Hand', 'Mano Ultradimensional', 10000, null, 1),
(313, 'ジ・エンド', 'The End', 'El Olvido', 14000, null, 1),
(314, 'まおう・ザ・ハンド', 'Fiend Hand', 'Mano Diabólica', 14000, null, 1),
(315, 'ねっけつパンチ', 'Fireball Knuckle', 'Despeje de Fuego', 200, null, 1),
(316, 'プレッシャーパンチ', 'Pressure Punch', 'Despeje a Presión', 200, null, 1),
(317, 'パワーシールド', 'Power Shield', 'Escudo de Fuerza', 600, null, 1),
(318, 'ロケットこぶし', 'Rocket Kobushi', 'Despeje Cohete', 600, null, 1),
(319, 'ねっけつヘッド', 'Fireball Head', 'Cabezonería', 1000, null, 1),
(320, 'フルパワーシールド', 'Full Power Shield', 'Escudo de Fuerza Total', 1200, null, 1),
(321, 'ばくれつパンチ', 'Blazing Knuckle', 'Despeje Explosivo', 1400, null, 1),
(322, 'かえんほうしゃ', 'Flame Breath', 'Lanzallamas', 1800, null, 1),
(323, 'カウンターストライク', 'Counter Strike', 'Puño Vengativo', 2200, null, 1),
(324, 'シュートラップ', 'Shot Trap', 'Malla Letal', 2200, null, 1),
(325, 'だいばくはつはりて', 'Nitro Slap', 'Rechace de Fuego', 2600, null, 1),
(326, 'ゴッドハンドX', 'God Hand X', 'Mano Celestial X', 3200, null, 1),
(327, 'ダブルロケット', 'Double Rocket', 'Puños Voladores', 3600, null, 1),
(328, 'ドリルスマッシャー', 'Drill Smasher', 'Destrozataladros', 4200, null, 1),
(329, 'バーンアウト', 'Burnout', 'Combustión', 4200, null, 1),
(330, 'ビーストファング', 'Beast Fang', 'Colmillo de Pantera', 10000, null, 1),
(331, 'ミリオンハンズ', 'Million Hands', 'Millón de Manos', 10000, null, 1),
(332, 'ゴッドハンドトリプル', 'Triple God Hand', 'Trimano Celestial', 12000, null, 1),
(333, 'タマシイ・ザ・ハンド', 'Soul Hand', 'Mano Espiritual', 14000, null, 1),
(334, 'タフネスブロック', 'Toughness Block', 'Bloque Dureza', 200, null, 1),
(335, 'まきわりチョップ', 'Wood Chopper', 'Despeje de Leñador', 200, null, 1),
(336, 'ゴッドハンド', 'God Hand', 'Mano Celestial', 400, null, 1),
(337, 'ワイルドクロー', 'Wild Claw', 'Garra Salvaje', 600, null, 1),
(338, 'ゴールずらし', 'Sliding Goal', 'Deslizamiento', 1200, null, 1),
(339, 'マジン・ザ・ハンド', 'Majin the Hand', 'Mano Mágica', 1200, null, 1),
(340, 'ドこんじょうキャッチ', 'Utter Gutsiness Catch', 'Mandril', 1400, null, 1),
(341, 'ちゃぶだいがえし', 'Table-Turner', 'Escudo Protector', 2200, null, 1),
(342, 'カードプロテクト', 'Card Protector', 'Baraja Fugaz', 2600, null, 1),
(343, 'コロッセオガード', 'Colosseum Guard', 'Guardia del Coliseo', 2600, null, 1),
(344, 'いかりのてっつい', 'Hammer of Fury', 'Puño de Furia', 10000, null, 1),
(345, 'カポエィラスナッチ', 'Capoeira Grab', 'Parada de Capoeira', 3200, null, 1),
(346, 'フラッシュアッパー', 'Flash Upper', 'Golpes de Luz', 3200, null, 1),
(347, 'トリプルディフェンス', 'Triple Defence', 'Defensa Triple', 3600, null, 1),
(348, 'ギガントウォール', 'Gigant Wall', 'Muralla Gigante', 4200, null, 1),
(349, 'むげんのかべ', 'Infinite Wall', 'Muralla Infinita', 10000, null, 1),
(350, 'ゴッドキャッチ', 'God Catch', 'Parada Celestial', 12000, null, 1),
(351, 'オメガ・ザ・ハンド', 'Omega Hand', 'Mano Omega', 14000, null, 1),
(352, 'イカサマ！', 'Trickery!', 'Piscinazo', 0, null, 1),
(353, 'イケイケ！', 'Move It!', '¡Vamos!', 0, null, 1),
(354, 'イケメンUP！', 'Cool Up!', 'Casanova', 0, null, 1),
(355, 'おいろけUP！', 'Charm Up!', 'Femme Fatale', 0, null, 1),
(356, 'オフェンスフォース', 'Offense Force', 'Fuerza Ofensiva', 0, null, 1),
(357, 'オフェンスプラス', 'Offence Plus', 'Ataque +', 0, null, 1),
(358, 'がくしゅう', 'Repaso', 'Study', 0, null, 1),
(359, 'キーパープラス', 'Keeper Plus', 'Portero +', 0, null, 1),
(360, 'クリティカル！', 'Critical!', 'Lance Crítico', 0, null, 1),
(361, 'こんしん！', 'Put Your Back Into It!', 'Mejor Garantía', 0, null, 1),
(362, 'シュートフォース', 'Shot Force', 'Fuerza de Tiro', 0, null, 1),
(363, 'シュートプラス', 'Shoot Plus', 'Tiro +', 0, null, 1),
(364, 'スピードフォース', 'Speed Force', 'Fuerza Veloz', 0, null, 1),
(365, 'スピードプラス', 'Speed Plus', 'Rapidez +', 0, null, 1),
(366, 'セツヤク！', 'Economy!', 'Ahorro', 0, null, 1),
(367, 'ぞくせいきょうか', 'Power Element', 'Carga Elemental', 0, null, 1),
(368, 'ちょうわざ！', 'Big Moves!', 'Ultratécnica', 0, null, 1),
(369, 'ディフェンスフォース', 'Defence Force', 'Fuerza Defensiva', 0, null, 1),
(370, 'ディフェンスプラス', 'Defence Plus', 'Defensa +', 0, null, 1),
(371, 'なまける', 'Slack Off', 'Vagueza', 0, null, 1),
(372, 'ネバーギブアップ', 'Never Give Up!', 'Siempre a Muerte', 0, null, 1),
(373, 'ふっかつ！', 'Comeback Kid!', '¡Que no Decaiga!', 0, null, 1),
(374, 'みんなイケイケ！', 'Everyone Move It!', '¡Vamos Todos!', 0, null, 1),
(375, 'むぞくせい', 'No Element', 'Anti-Afinidades', 0, null, 1),
(376, 'やくびょうがみ', 'Jinx', 'Gafe', 0, null, 1),
(377, 'ラッキー！', 'Lucky!', 'Suerte', 0, null, 1),
(378, 'リカバリー', 'Recovery', 'Recobro', 0, null, 1);
/*装備品*/
/*通貨*/
/*報酬*/
/*マップチケット*/
/*鍵*/
/*対戦チケット*/
/*回復*/
/*さいごのノート*/
/*ウェア*/
/*必殺タクティクス*/
/*フォーメーション*/


/*
(1, '', '', '', null, null, 1)
hissatsu_type
item_hissatsu
tactic_type
tactic_side
item_tactic
equipment_type
item_equipment
item_currency
item_reward_player
item_map
item_key
item_recovery
item_ultimate_note
item_wear

player_found_at_zone
npc
chest
item_sold_at_stor

equipment_strengthens_stat
catch_type
shoot_special_property
hissatsu_shoot
hissatsu_shoot_can_have_shoot_special_property
hissatsu_dribble
hissatsu_block
hissatsu_catch
hissatsu_skill
growth_type
growth_rate
growth_type_can_achieve_growth_rate
hissatsu_evolves
hissatsu_limited_by_genre
hissatsu_constrained_by_body_type
hissatsu_available_for_positi
hissatsu_special_restriction
hissatsu_restricted_by_hissatsu_special_restriction
hissatsu_evokes_attri

player_learns_hissatsu
player_has_recommended_slot_hissatsu
player_has_recommended_gear_equipment
player_has_recommended_routine_tm
player_decrypted_with_passwd

item_formation_type
item_formation
item_formation_organized_as_positi
team
player_is_part_of_team
player_plays_during_story_team

tactic_executed_by_team
extra_battle_route
route_path
practice_game_condition
practice_game
practice_game_dictated_by_pgc
item_vscard
practice_game_can_drop_item

tournament_rank
tournament_name
tournament_rank_requires_player
tournament_rank_disputed_by_team
tournament_rank_may_drop_item

gacha
gacha_yields
old_pin_badge_exchange
utc_session
utc_session_develops_stat
utc_drop_type
utc_session_drops

story
item_gifted_during_story
player_received_during_story

conn_panel
conn_link_type
conn_link
link_player
link_chest
link_lock
*/

