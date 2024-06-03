/*

database choujigen3ogre

drop database choujigen3ogre;
create database choujigen3ogre;
use choujigen3ogre;
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/choujigen3.sql
*/

/*1-drop*/
drop table if exists daily;
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
drop table if exists ultimate_note_increases_free;
drop table if exists tournament_rank_may_drop_item;
drop table if exists tournament_rank_disputed_by_team;
drop table if exists tournament_rank_requires_player;
drop table if exists tournament_name;
drop table if exists tournament_rank;
drop table if exists practice_game_can_drop_item;
drop table if exists practice_game_initiated_by_npc;
drop table if exists item_vscard;
drop table if exists practice_game;
drop table if exists practice_game_condition;
drop table if exists route_path;
drop table if exists extra_battle_route;
drop table if exists tactic_executed_by_team;
drop table if exists player_plays_during_story_team;
drop table if exists player_is_part_of_team;
drop table if exists team;
drop table if exists formation_organized_as_positi;
drop table if exists item_formation;
drop table if exists formation_scheme;
drop table if exists formation_type;
drop table if exists player_decrypted_with_passwd;
drop table if exists player_has_recommended_routine_tm;
drop table if exists player_has_recommended_gear_equipment;
drop table if exists player_has_recommended_slot_hissatsu;
drop table if exists player_learns_hissatsu;
drop table if exists hissatsu_evokes_attri;
drop table if exists hissatsu_designed_for_attri;
drop table if exists hissatsu_combined_with_hissatsu;
drop table if exists hissatsu_helped_by_attri;
drop table if exists hissatsu_restricted_by_hissatsu_special_restriction;
drop table if exists hissatsu_special_restriction;
drop table if exists hissatsu_available_for_positi;
drop table if exists hissatsu_constrained_by_body_type;
drop table if exists hissatsu_limited_by_gender;
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
drop table if exists gender;
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
create table gender (
    gender_id int not null auto_increment,
    gender_name_ja varchar(32),
    gender_name_en varchar(32),
    gender_name_es varchar(32),
    gender_symbol varchar(1),
    constraint gender_pk primary key (gender_id)
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
    gender_id int,
    body_type_id int,
    player_obtention_method_id int,
    original_version int,
    constraint player_pk primary key (player_id),
    constraint player_fk_attri foreign key (attri_id) 
        references attri(attri_id) on delete cascade,
    constraint player_fk_positi foreign key (positi_id) 
        references positi(positi_id) on delete cascade,
    constraint player_fk_gender foreign key (gender_id) 
        references gender(gender_id) on delete cascade,
    constraint player_fk_body_type foreign key (body_type_id) 
        references body_type(body_type_id) on delete cascade,
    constraint player_fk_player_obtention_method 
        foreign key (player_obtention_method_id) 
        references player_obtention_method(player_obtention_method_id) 
        on delete cascade,
    constraint player_fk_player foreign key (original_version) 
        references player(player_id) on delete cascade
);
drop table if exists player;
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
    hissatsu_type_name_ja varchar(32),
    hissatsu_type_name_en varchar(32),
    hissatsu_type_name_es varchar(32),
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
    item_tactic_power int,
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
    constraint equipment_type_pk primary key (item_equipment_id),
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
    zone_id int,
    constraint item_key_pk primary key (item_key_id),
    constraint item_key_fk_item foreign key (item_key_id) 
        references item(item_id) on delete cascade,
    constraint item_key_fk_zone foreign key (zone_id) 
        references zone(zone_id) on delete cascade
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
    npc_name_es varchar(32),
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
    amount int,
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
    constraint hissatsu_shoot_can_have_ssp_fk_hissatsu_shoot 
        foreign key (item_hissatsu_id)
        references hissatsu_shoot(item_hissatsu_id) on delete cascade,
    constraint hissatsu_shoot_can_have_spp_fk_spp 
        foreign key (shoot_special_property_id)
        references shoot_special_property(shoot_special_property_id) 
        on delete cascade
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
    hissatsu_block_is_block int,
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
    constraint hissatsu_evolves_pk 
        primary key (item_hissatsu_id, growth_type_id, growth_rate_id),
    constraint hissatsu_evolves_fk_item_hissatsu foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_evolves_fk_growth_type foreign key (growth_type_id)
        references growth_type(growth_type_id) on delete cascade,
    constraint hissatsu_evolves_fk_growth_rate 
        foreign key (growth_rate_id)
        references growth_rate(growth_rate_id) on delete cascade
);

create table hissatsu_limited_by_gender (
    item_hissatsu_id int not null,
    gender_id int not null,
    constraint hissatsu_limited_by_gender_pk primary key (item_hissatsu_id),
    constraint hissatsu_limited_by_gender_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_limited_by_gender_fk_gender
        foreign key (gender_id)
        references gender(gender_id) on delete cascade
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
    constraint hissatsu_restricted_by_hsp_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_restricted_by_hsp_fk_hsp 
        foreign key (hissatsu_special_restriction_id)
        references hissatsu_special_restriction(hissatsu_special_restriction_id)
        on delete cascade
);

create table hissatsu_designed_for_attri (
    item_hissatsu_id int not null,
    attri_id int not null,
    constraint hissatsu_designed_for_attri_pk primary key (item_hissatsu_id),
    constraint hissatsu_designed_for_attri_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_designed_for_attri_fk_attri foreign key (attri_id)
        references attri(attri_id) on delete cascade
);

create table hissatsu_helped_by_attri (
    item_hissatsu_id int not null,
    attri_id int not null,
    constraint hissatsu_helped_by_attri_pk 
        primary key (item_hissatsu_id, attri_id),
    constraint hissatsu_helped_by_attri_fk_item_hissatsu 
        foreign key (item_hissatsu_id)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_helped_by_attri_fk_attri foreign key (attri_id)
        references attri(attri_id) on delete cascade
);

create table hissatsu_combined_with_hissatsu (
    item_hissatsu_id_base int not null,
    item_hissatsu_id_combined int not null,
    constraint hissatsu_combined_with_hissatsu_pk 
        primary key (item_hissatsu_id_base),
    constraint hissatsu_combined_with_hissatsu_fk_item_hissatsu1 
        foreign key (item_hissatsu_id_base)
        references item_hissatsu(item_hissatsu_id) on delete cascade,
    constraint hissatsu_combined_with_hissatsu_fk_item_hissatsu2
        foreign key (item_hissatsu_id_combined)
        references item_hissatsu(item_hissatsu_id) on delete cascade
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
    constraint player_has_recommended_slot_hissatsu_fk_player 
        foreign key (player_id)
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
    constraint player_has_recommended_gear_equipment_fk_player 
        foreign key (player_id)
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
    constraint player_has_recommended_routine_tm_fk_player 
        foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_has_recommended_routine_tm_fk_tm 
        foreign key (training_method_id)
        references training_method(training_method_id) on delete cascade
);

create table player_decrypted_with_passwd (
    player_id int not null,
    passwd_id int not null,
    constraint player_decrypted_with_passwd_pk 
        primary key (player_id, passwd_id),
    constraint player_decrypted_with_passwd_fk_player foreign key (player_id)
        references player(player_id) on delete cascade,
    constraint player_decrypted_with_passwd_fk_passwd foreign key (passwd_id)
        references passwd(passwd_id) on delete cascade
);
/*page-team*/
create table formation_type (
    formation_type_id int not null auto_increment,
    formation_type_name_ja varchar(32),
    formation_type_name_en varchar(32),
    formation_type_name_es varchar(32),
    constraint formation_type_pk primary key (formation_type_id)
);

create table formation_scheme (
    formation_scheme_id int not null auto_increment,
    formation_scheme_name varchar(32),
    constraint formation_scheme_pk primary key (formation_scheme_id)
);

create table item_formation (
    item_formation_id int not null auto_increment,
    formation_type_id int,
    formation_scheme_id int,
    original_version int,
    constraint item_formation_pk primary key (item_formation_id),
    constraint item_formation_fk_item_formation  foreign key (original_version)
        references item_formation(item_formation_id) on delete cascade,
    constraint item_formation_fk_formation_type 
        foreign key (formation_type_id)
        references formation_type(formation_type_id) 
        on delete cascade,
    constraint item_formation_fk_formation_scheme
        foreign key (formation_scheme_id)
        references formation_scheme(formation_scheme_id) 
        on delete cascade,
    constraint item_formation_fk_item foreign key (item_formation_id)
        references item(item_id) on delete cascade
);

create table formation_organized_as_positi (
    item_formation_id int not null,
    positi_id int not null,
    place int not null,
    constraint formation_organized_as_positi_pk 
        primary key (item_formation_id, positi_id, place),
    constraint formation_organized_as_positi_fk_item_formation 
        foreign key (item_formation_id)
        references item_formation(item_formation_id) on delete cascade,
    constraint formation_organized_as_positi_fk_positi 
        foreign key (positi_id)
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
    extra_battle_route_name_ja varchar(48),
    extra_battle_route_name_en varchar(48),
    extra_battle_route_name_es varchar(48),
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
    practice_game_condition_id int,
    constraint practice_game_pk primary key (practice_game_id),
    constraint practice_game_fk_route_path foreign key (route_path_id)
        references route_path(route_path_id) on delete cascade,
    constraint practice_game_fk_team foreign key (team_id)
        references team(team_id) on delete cascade,
    constraint practice_game_fk_condition 
        foreign key (practice_game_condition_id)
        references practice_game_condition(practice_game_condition_id) 
        on delete cascade
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

create table practice_game_initiated_by_npc (
    practice_game_id int not null,
    npc_id int not null,
    constraint practice_game_initiated_by_npc_pk 
        primary key (practice_game_id, npc_id),
    constraint practice_game_initiated_by_npc_fk_practice_game 
        foreign key (practice_game_id)
        references practice_game(practice_game_id) on delete cascade,
    constraint practice_game_initiated_by_npc_fk_npc foreign key (npc_id)
        references npc(npc_id) on delete cascade
);

create table practice_game_can_drop_item (
    practice_game_id int not null,
    item_id int not null,
    drop_rate int,
    constraint practice_game_can_drop_item_pk 
        primary key (practice_game_id, item_id),
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
    team_lv int,
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
        primary key (tournament_rank_id, item_id, amount),
    constraint tournament_rank_may_drop_item_fk_tournament_rank 
        foreign key (tournament_rank_id)
        references tournament_rank(tournament_rank_id) on delete cascade,
    constraint tournament_rank_may_drop_item_fk_item
        foreign key (item_id)
        references item(item_id) on delete cascade  
);
/*page-item*/
create table ultimate_note_increases_free (
    item_ultimate_note_id int not null,
    positi_id int not null,
    attri_id int not null,
    constraint ultimate_note_increases_free_pk 
        primary key (item_ultimate_note_id, positi_id, attri_id),
    constraint ultimate_note_increases_free_fk_item_ultimate_note
        foreign key (item_ultimate_note_id) 
        references item_ultimate_note(item_ultimate_note_id) on delete cascade,
    constraint ultimate_note_increases_free_fk_positi
        foreign key (positi_id) references positi(positi_id) on delete cascade,
    constraint ultimate_note_increases_free_fk_attri
        foreign key (attri_id) references attri(attri_id) on delete cascade  
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

create table daily (
    daily_id int not null,
    player_id int,
    views int,
    constraint daily_pk primary key (daily_id),
    constraint daily_pk_player foreign key (player_id)
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
    (135, '東京大江戸国際空港', 'Tokyo International Airport', 'Aeropuerto de Tokio', 3),
        (136, '東京大江戸国際空港', 'Tokyo International Airport', 'Aeropuerto de Tokio', 4),
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
(5, 'コントロール', 'Control', 'Control'),
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

insert into gender (    
    gender_id,
    gender_name_ja,
    gender_name_en,
    gender_name_es,
    gender_symbol) values
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
(4, 'コンドルダイブ', 'Condor Dive', 'Ataque Cóndor', 600, null, 1),
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
(16, 'レボリューションV', 'Revolution V', 'Remate en V', 4200, null, 1),
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
(83, 'つうてんかくシュート', 'Steeple Shot', 'Tiro Torre de Osaka', 2200, null, 1),
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
(94, 'デスレイン', 'Doom Rain', 'Diluvio Letal', 10000, null, 1),
(95, 'アトミックフレア', 'Atomic Flare', 'Llamarada Atómica', 10000, null, 1),
(96, 'ばくねつスクリュー', 'Fireball Screw', 'Torbellino de Fuego', 10000, null, 1),
(97, 'ザ・フェニックス', 'The Phoenix', 'Fénix', 10000, null, 1),
(98, 'ツインブーストＦ', 'Twin Boost F', 'Empuje Gemelo F', 10000, null, 1),
(99, 'トライアングルＺ', 'Triangle Z', 'Triángulo Z', 10000, null, 1),
(100, 'トリプルブースト', 'Triple Boost', 'Empuje Trillizo', 10000, null, 1),
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
(111, 'クロスファイア', 'Crossfire', 'Fuego Cruzado', 18000, null, 1),
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
(149, 'ジグザグスパーク', 'Zigzag Spark', 'Zigzag Chispeante', 800, null, 1),
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
(243, 'ゴー・トゥ・ヘル', 'Hell\'s Descent', 'Caída a los Infiernos', 10000, null, 1),
(244, 'シグマゾーン', 'Sigma Zone', 'Zona Sigma', 10000, null, 1),
(245, 'ジャイアントスピン', 'Supreme Spin', 'Superpeonza', 400, null, 1),
(246, 'フォトンフラッシュ', 'Photon Crash', 'Flash de Fotones', 600, null, 1),
(247, 'スーパーしこふみ', 'Super Sumo Stomp', 'Superpisotón de sumo', 600, null, 1),
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
(286, 'せいぎのてっけん', 'Fist of Justice', 'Superpuño Invencible', 1800, null, 1),
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
(302, 'シュートポケット', 'Shot Pocket', 'Campo de Fuerza Defensivo', 1000, null, 1),
(303, 'スラッシュネイル', 'Claw Slash', 'Uñas Afiladas', 1200, null, 1),
(304, 'マジン・ザ・ハンド', 'Majin the Hand', 'Mano Mágica', 0, null, 1),
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
(358, 'がくしゅう', 'Study', 'Repaso', 30000, null, 1),
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
(371, 'なまける', 'Slack Off', 'Vagueza', 30000, null, 1),
(372, 'ネバーギブアップ', 'Never Give Up!', 'Siempre a Muerte', 0, null, 1),
(373, 'ふっかつ！', 'Comeback Kid!', '¡Que no Decaiga!', 0, null, 1),
(374, 'みんなイケイケ！', 'Everyone Move It!', '¡Vamos Todos!', 0, null, 1),
(375, 'むぞくせい', 'No Element', 'Antiafinidades', 0, null, 1),
(376, 'やくびょうがみ', 'Jinx', 'Gafe', 0, null, 1),
(377, 'ラッキー！', 'Lucky!', 'Suerte', 0, null, 1),
(378, 'リカバリー', 'Recovery', 'Recobro', 0, null, 1),
/*装備品*/
(379, 'イナズマＪスパイク', 'Inazuma J Spike', 'Botas Inazuma Japón', 0, null, 2),
(380, 'さわやかスパイク', 'Sawayaka Spike', 'Botas frescas', 100, null, 2),
(381, '傘美野スパイク', 'Kasamino Spike', 'Botas Umbrella', 120, null, 2),
(382, '青春スパイク', 'Seishun Spike', 'Botas juveniles', 180, null, 2),
(383, '御影専農スパイク', 'Mikage Sennou Spike', 'Botas mentales', 180, null, 2),
(384, 'ほしくずのシューズ', 'Hoshikuzu no Shoes', 'Calzado estelar', 250, null, 2),
(385, 'ホワイトスパイク', 'White Spike', 'Botas blancas', 250, null, 2),
(386, 'そよかぜスパイク', 'Soyokaze Spike', 'Botas vendaval', 400, null, 2),
(387, 'マーシャルシューズ', 'Marshall Shoes', 'Calzado mariscal', 400, null, 2),
(388, 'しっこくのスパイク', 'Shikkoku no Spike', 'Botas azabache', 0, null, 2),
(389, 'Ｄライオンシューズ', 'D Lion Shoes', 'Botas leoninas', 0, null, 2),
(390, 'ニンジャスパイク', 'Ninja Spike', 'Botas ninja', 600, null, 2),
(391, 'フェザースパイク', 'Feather Spike', 'Botas ligeras', 600, null, 2),
(392, 'ウイングスパイク', 'Wing Spike', 'Botas de Pegaso', 800, null, 2),
(393, '勝利のスパイク', 'Shouri no Spike', 'Botas exitosas', 800, null, 2),
(394, 'わくせいのシューズ', 'Wakusei no Shoes', 'Calzado astral', 0, null, 2),
(395, 'ネオジャパンスパイク', 'Neo Japan Spike', 'Botas Neo Japón', 0, null, 2),
(396, 'ハヤブサシューズ', 'Hayabusa Shoes', 'Botas de halcón', 1200, null, 2),
(397, '木戸川スパイク', 'Kidokawa Spike', 'Botas Kirkwood', 0, null, 2),
(398, 'しんせだいシューズ', 'Shinsedai Shoes', 'Botas mecánicas', 0, null, 2),
(399, 'ライダースシューズ', 'Riders Shoes', 'Calzado motero', 1600, null, 2),
(400, 'うちゅうのスパイク', 'Uchuu no Spike', 'Calzado espacial', 0, null, 2),
(401, 'グロウスパイク', 'Glow Spike', 'Botas hipersónicas', 0, null, 2),
(402, 'サンダースパイク', 'Thunder Spike', 'Botas relámpago', 0, null, 2),
(403, 'しんくうスパイク', 'Shinkuu Spike', 'Botas vacuas', 0, null, 2),
(404, 'ナイツスパイク', 'Knights Spike', 'Botas de caballero', 0, null, 2),
(405, 'ひょうけつスパイク', 'Hyouketsu Spike', 'Botas congelantes', 2000, null, 2),
(406, 'ブレインスパイク', 'Brain Spike', 'Botas de genio', 0, null, 2),
(407, 'バファナシューズ', 'Bafana Shoes', 'Botas bafana', 0, null, 2),
(408, 'シャンパンシューズ', 'Champagne Shoes', 'Zapatos champán', 0, null, 2),
(409, 'ユニコーンスパイク', 'Unicorn Spike', 'Botas Unicorn', 0, null, 2),
(410, 'コトアールシューズ', 'Cotarl Shoes', 'Botas costaleñas', 0, null, 2),
(411, 'オルフェウスシューズ', 'Orpheus Shoes', 'Botas Orfeo', 0, null, 2),
(412, 'てんくうのシューズ', 'Tenkuu no Shoes', 'Botas Sky Team', 0, null, 2),
(413, 'やみのシューズ', 'Yami no Shoes', 'Botas sombrías', 10000, null, 2),
(414, 'でんせつのスパイク', 'Densetsu no Spike', 'Botas legendarias', 20000, null, 2),
(415, '秋葉名戸スパイク', 'Shuuyou Meito Spike', 'Botas Otaku', 100, null, 2),
(416, 'のろいのスパイク', 'Noroi no Spike', 'Botas malditas', 0, null, 2),
(417, '稲妻ＫＦＣスパイク', 'Inazuma KFC Spike', 'Botas infantiles', 0, null, 2),
(418, 'チェッカーシューズ', 'Checker Shoes', 'Calzado a cuadros', 120, null, 2),
(419, 'ワイルドスパイク', 'Wild Spike', 'Botas salvajes', 0, null, 2),
(420, 'サーモスパイク', 'Thermo Spike', 'Botas térmicas', 180, null, 2),
(421, 'サリーズシューズ', 'Sally\'s Shoes', 'Botas Sallys', 180, null, 2),
(422, 'セキュリティシューズ', 'Security Shoes', 'Calzado seguro', 180, null, 2),
(423, 'せつげんのスパイク', 'Setsugen no Spike', 'Botas frías', 250, null, 2),
(424, 'どりょくのスパイク', 'Doryouku no Spike', 'Botas de currante', 250, null, 2),
(425, 'アローシューズ', 'Arrow Shoes', 'Botas certeras', 400, null, 2),
(426, 'たんれんスパイク', 'Tanren Spike', 'Botas diestras', 400, null, 2),
(427, 'スマートスパイク', 'Smart Spike', 'Botas elegantes', 600, null, 2),
(428, '帝国スパイク', 'Teikoku Spike', 'Botas Royal', 0, null, 2),
(429, '大津波のスパイク', 'Otsunami no Spike', 'Botas Big Waves', 0, null, 2),
(430, '千羽山スパイク', 'Senbayama Spike', 'Botas campesinas', 0, null, 2),
(431, 'ナニワのスパイク', 'Naniwa no Spike', 'Botas Osakaland', 800, null, 2),
(432, 'ブレットスパイク', 'Bullet Spike', 'Botas perforadoras', 800, null, 2),
(433, '熱血スパイク', 'Nekketsu Spike', 'Botas ardientes', 1200, null, 2),
(434, 'ゆうぐれシューズ', 'Yuugure Shoes', 'Calzado penumbra', 1200, null, 2),
(435, 'あらぶるスパイク', 'Araburu Spike', 'Botas viles', 1600, null, 2),
(436, 'ディバインスパイク', 'Divine Spike', 'Botas divinas', 0, null, 2),
(437, 'マリンスパイク', 'Marine Spike', 'Botas marinas', 0, null, 2),
(438, 'ウエイクスパイク', 'Wake Spike', 'Botas motivadoras', 0, null, 2),
(439, '火竜のスパイク', 'Hiryuu no Spike', 'Botas dragontinas', 0, null, 2),
(440, 'しゃくねつスパイク', 'Shakunetsu Spike', 'Botas flamígeras', 2000, null, 2),
(441, 'スピリットシューズ', 'Spirit Shoes', 'Botas distinguidas', 0, null, 2),
(442, 'ソウルシューズ', 'Soul Shoes', 'Botas precisión', 0, null, 2),
(443, 'ふくつのスパイク', 'Fukutsu no Spike', 'Botas de poder', 0, null, 2),
(444, 'アルマダスパイク', 'Armada Spike', 'Botas ibéricas', 0, null, 2),
(445, 'ふくしゅうのスパイク', 'Fukushuu no Spike', 'Botas de represalia', 0, null, 2),
(446, 'エンパイアシューズ', 'Empire Shoes', 'Botas Emperadores', 0, null, 2),
(447, 'キングダムスパイク', 'Kingdom Spike', 'Botas Os Reis', 0, null, 2),
(448, 'こんとんのスパイク', 'Konton no Spike', 'Botas del orden', 0, null, 2),
(449, 'やぼうのスパイク', 'Yabou no Spike', 'Botas de anhelo', 0, null, 2),
(450, 'まかいのスパイク', 'Makai no Spike', 'Botas Dark Team', 0, null, 2),
(451, 'てんまのスパイク', 'Tenma no Spike', 'Botas de Dédalo', 10000, null, 2),
(452, 'メイズスパイク', 'Maze Spike', 'Botas Ángel Oscuro', 10000, null, 2),
(453, 'イナズマスパイク', 'Inazuma Spike', 'Botas Inazuma', 20000, null, 2),
(454, 'オーガスパイク', 'Ogre Spike', 'Botas Ogro', 0, null, 2),
(455, 'イナズマＪグローブ', 'Inazuma J Glove', 'Guantes Inazuma Japón', 0, null, 2),
(456, '秋葉名戸グローブ', 'Shuuyou Meito Glove', 'Guantes Otaku', 100, null, 2),
(457, 'れんしゅうグローブ', 'Renshuu Glove', 'Guantes reusados', 100, null, 2),
(458, '稲妻ＫＦＣグローブ', 'Inazuma KFC Glove', 'Guantes infantiles', 0, null, 2),
(459, 'エアーハンド', 'Air Hand', 'Manoplas aéreas', 120, null, 2),
(460, '傘美野グローブ', 'Kasamino Glove', 'Guantes Umbrella', 120, null, 2),
(461, '青春グローブ', 'Seishun Glove', 'Guantes juveniles', 120, null, 2),
(462, 'のろいのグローブ', 'Noroi No Glove', 'Guantes malditos', 0, null, 2),
(463, 'ワイルドグラブ', 'Wild Grab', 'Guantes salvajes', 0, null, 2),
(464, 'サリーズグローブ', 'Sally\'s Glove', 'Guantes Sallys', 180, null, 2),
(465, 'さわやかグローブ', 'Sawayaka Glove', 'Guantes frescos', 180, null, 2),
(466, '勝利のグローブ', 'Shouri no Glove', 'Guantes exitosos', 180, null, 2),
(467, 'てっぺきのグローブ', 'Teppeki no Glove', 'Guantes telón de acero', 0, null, 2),
(468, '御影専農グローブ', 'Mikage Sennou Glove', 'Guantes Brain', 180, null, 2),
(469, 'きたぐにのグローブ', 'Kitaguni no Glove', 'Guantes norteños', 250, null, 2),
(470, 'じょうねつグローブ', 'Jounetsu Glove', 'Guantes en llamas', 250, null, 2),
(471, 'ミクログローブ', 'Micro Glove', 'Microguantes', 250, null, 2),
(472, 'かたみのグローブ', 'Katami no Glove', 'Guantes mecánicos', 0, null, 2),
(473, 'クンフーグローブ', 'Kung Fu Glove', 'Guantes kung-fu', 400, null, 2),
(474, 'じせだいグローブ', 'Jisedai Glove', 'Guantes legados', 0, null, 2),
(475, 'はがねのグローブ', 'Hagane no Glove', 'Guantes de acero', 400, null, 2),
(476, 'プリティハンド2', 'Pretty Hand 2', 'Guantes cucos 2', 400, null, 2),
(477, 'つわもののグローブ', 'Tsunemo no Glove', 'Guantes de poder', 600, null, 2),
(478, '帝国グローブ', 'Teikoku Glove', 'Guantes Royal', 0, null, 2),
(479, 'ニンジャグローブ', 'Ninja Glove', 'Guantes ninja', 0, null, 2),
(480, 'ひっしょうグローブ', 'Hisshou Glove', 'Guantes triunfo', 600, null, 2),
(481, 'オーロラハンド', 'Aurora Hand', 'Manoplas aurora', 0, null, 2),
(482, 'おとめのグローブ', 'Otome Glove', 'Guantes de dama', 800, null, 2),
(483, 'コロナハンド', 'Corona Hand', 'Manoplas reales', 0, null, 2),
(484, '千羽山グローブ', 'Senbayama Glove', 'Guantes Farm', 0, null, 2),
(485, 'だいしぜんグローブ', 'Daishizen Glove', 'Guantes naturales', 800, null, 2),
(486, 'マクログローブ', 'Macro Glove', 'Macroguantes', 0, null, 2),
(487, '大津波のグローブ', 'Otsunami no Glove', 'Guantes Big Waves', 0, null, 2),
(488, 'サンセットグローブ', 'Sunset Glove', 'Guantes del ocaso', 1200, null, 2),
(489, '熱血グローブ', 'Nekketsu Glove', 'Guantes ardientes', 1200, null, 2),
(490, 'はかいのグローブ', 'Hakai no Glove', 'Guantes del fin', 1200, null, 2),
(491, '木戸川グローブ', 'Kidokawa Glove', 'Guantes Kirkwood', 0, null, 2),
(492, 'ディバイングローブ', 'Divine Glove', 'Guantes divinos', 0, null, 2),
(493, 'リゾートハンド', 'Resort Hand', 'Manoplas de estío', 1600, null, 2),
(494, '時空のグローブ', 'Jikuu no Glove', 'Cronoguantes', 0, null, 2),
(495, 'Ｄライオングローブ', 'D Lion Glove', 'Guantes leoninos', 0, null, 2),
(496, 'ビッグバンハンド', 'Big Bang Hand', 'Manoplas Big Bang', 2000, null, 2),
(497, 'ネオジャパングローブ', 'Neo Japan Glove', 'Guantes Neo Japón', 0, null, 2),
(498, 'うらぎりのグローブ', 'Uragiri no Glove', 'Guantes rebeldes', 2800, null, 2),
(499, '火竜のグローブ', 'Hiryuu no Glove', 'Guantes dragontinos', 0, null, 2),
(500, 'シャンパングローブ', 'Champagne Glove', 'Guantes champán', 0, null, 2),
(501, 'アルマダグローブ', 'Armada Glove', 'Guantes ibéricos', 0, null, 2),
(502, 'ふくつのグローブ', 'Fukutsu no Glove', 'Guantes dobles', 0, null, 2),
(503, 'しんりんのグローブ', 'Shinrin No Glove', 'Guantes boscosos', 3800, null, 2),
(504, 'ナイツグローブ', 'Knights Glove', 'Guantes de caballero', 0, null, 2),
(505, 'バファナグローブ', 'Bafana Glove', 'Guantes bafana', 0, null, 2),
(506, 'イナズマグローブ', 'Inazuma Glove', 'Guantes Inazuma', 0, null, 2),
(507, 'エンパイアグローブ', 'Empire Glove', 'Guantes Emperadores', 0, null, 2),
(508, 'カードチームグローブ', 'Card Team Glove', 'Guantes Tarjeteros', 0, null, 2),
(509, 'てんくうのグローブ', 'Tenkuu no Glove', 'Guantes Sky Team', 0, null, 2),
(510, 'ふくしゅうのグローブ', 'Fukushuu no Glove', 'Guantes de represalia', 0, null, 2),
(511, 'まかいのグローブ', 'Makai no Glove', 'Guantes Dark Team', 0, null, 2),
(512, 'オルフェウスグローブ', 'Orpheus Glove', 'Guantes Orfeo', 0, null, 2),
(513, 'ユニコーングローブ', 'Unicorn Glove', 'Guantes Unicorn', 0, null, 2),
(514, 'キングダムグローブ', 'Kingdom Glove', 'Guantes Os Reis', 0, null, 2),
(515, 'コトアールグローブ', 'Cotarl Glove', 'Guantes costaleños', 0, null, 2),
(516, 'てんまのグローブ', 'Tenma no Glove', 'Guantes Ángel Oscuro', 0, null, 2),
(517, 'やぼうのグローブ', 'Yabou no Glove', 'Guantes de anhelo', 0, null, 2),
(518, 'オーガグローブ', 'Ogre Glove', 'Guantes Ogro', 0, null, 2),
(519, 'でんせつのグローブ', 'Densetsu no Glove', 'Guantes míticos', 0, null, 2),
(520, 'よごれたミサンガ', 'Yogoreta Misanga', 'Pulsera gastada', 100, null, 2),
(521, '青春ミサンガ', 'Seishun Misanga', 'Pulsera juvenil', 200, null, 2),
(522, 'チタンミサンガ', 'Titan Misanga', 'Pulsera de titanio', 350, null, 2),
(523, 'じょうねつミサンガ', 'Jounetsu Misanga', 'Pulsera pasión', 500, null, 2),
(524, '炎のミサンガ', 'Honoo no Misanga', 'Pulsera ígnea', 650, null, 2),
(525, 'ももいろミサンガ', 'Momoiro Misanga', 'Pulsera melocotón', 850, null, 2),
(526, '勝利のミサンガ', 'Shouri no Misanga', 'Pulsera exitosa', 1200, null, 2),
(527, 'だいちのミサンガ', 'Daichi no Misanga', 'Pulsera telúrica', 1600, null, 2),
(528, '熱血ミサンガ', 'Nekketsu Misanga', 'Pulsera ardiente', 2200, null, 2),
(529, 'イナズマミサンガ', 'Inazuma Misanga', 'Pulsera Inazuma', 3000, null, 2),
(530, 'コスモミサンガ', 'Cosmo Misanga', 'Cosmopulsera', 8000, null, 2),
(531, 'さいきょうミサンガ', 'Saikyou Misanga', 'Pulsera genial', 30000, null, 2),
(532, 'ジミなミサンガ', 'Jimina Misanga', 'Pulsera sobria', 0, null, 2),
(533, 'ハデなミサンガ', 'Hadena Misanga', 'Pulsera chillona', 0, null, 2),
(534, 'どハデなミサンガ', 'Dohadena Misanga', 'Pulsera llamativa', 0, null, 2),
(535, '丈夫なミサンガ', 'Joubuna Misanga', 'Pulsera recia', 200, null, 2),
(536, 'ゆうじょうミサンガ', 'Yuujou Misanga', 'Pulsera amistad', 350, null, 2),
(537, 'おしゃれミサンガ', 'Oshare Misanga', 'Pulsera elegante', 500, null, 2),
(538, 'マッスルミサンガ', 'Muscle Misanga', 'Pulsera de cachas', 650, null, 2),
(539, 'きぼうのミサンガ', 'Kibou Misanga', 'Pulsera de fe', 850, null, 2),
(540, '幸せのミサンガ', 'Shiawase no Misanga', 'Pulsera jubilosa', 1600, null, 2),
(541, 'いこくのミサンガ', 'Ikoku no Misanga', 'Pulsera exótica', 2200, null, 2),
(542, 'ちかいのペンダント', 'Chikai no Pendant', 'Colgante fraterno', 0, null, 2),
(543, 'きずなのペンダント', 'Kizuna no Pendant', 'Colgante noble', 0, null, 2),
(544, 'ごうかなペンダント', 'Goukana Pendant', 'Colgante sincero', 0, null, 2),
(545, 'まよけのペンダント', 'Mayoke no Pendant', 'Colgante puro', 0, null, 2),
(546, 'いのりのペンダント', 'Inori no Pendant', 'Colgante leal', 0, null, 2),
(547, '守りのペンダント銅', 'Mamori no Pendant Dou', 'Amuleto bronce', 0, null, 2),
(548, '守りのペンダント銀', 'Mamori no Pendant Gin', 'Amuleto plata', 0, null, 2),
(549, '守りのペンダント金', 'Mamori no Pendant Kin', 'Amuleto oro', 0, null, 2),
(550, '力のペンダント銅', 'Chikara no Pendant Dou', 'Colgante poder bronce', 0, null, 2),
(551, '力のペンダント銀', 'Chikara no Pendant Gin', 'Colgante poder plata', 0, null, 2),
(552, '力のペンダント金', 'Chikara no Pendant Kin', 'Colgante poder oro', 0, null, 2),
/*通貨*/
(553, 'ねっけつＰ', 'Nekketsu points', 'Puntos de pasión', null, null, 3),
(554, 'ゆうじょうＰ', 'Yuujou points', 'Puntos de amistad', null, null, 3),
(555, 'けいけんち', 'Experience points', 'Puntos de experiencia', null, null, 3),
(556, '赤いコイン', 'Red Coin', 'Ficha Roja', null, 10, 3),
(557, '青いコイン', 'Blue Coin', 'Ficha Azul', null, 10, 3),
(558, '黄色いコイン', 'Yellow Coin', 'Ficha Amarilla', 10, null, 3),
(559, '古びたピンバッチ', 'Old Pin Badge', 'Chapa Vieja', null, null, 3),
/*
報酬
866
1348
1027
1269
282
416
*/
(560, 'たまごろう', 'Peabody', 'Peabody', null, null, 4),
(561, 'マックス', 'Max', 'Max', null, null, 4),
(562, 'なつみ', 'Nelly', 'Nelly', null, null, 4),
(563, 'ふゆか', 'Cammy', 'Cammy', null, null, 4),
(564, 'おとなし', 'Celia', 'Celia', null, null, 4),
(565, 'きの', 'Silvia', 'Silvia', null, null, 4),
/*マップチケット*/
(566, '福岡のチケット', 'Fukuoka Map', 'Mapa de Fukuoka', 700, null, 5),
(567, '奈良のチケット', 'Nara Map', 'Mapa de Nara', null, null, 5),
(568, 'フェリーのチケット', 'Okinawa Map', 'Mapa de Okinawa', null, null, 5),
(569, '阪のチケット', 'Osaka Map', 'Mapa de Osaka', null, null, 5),
(570, '遊園地のチケット', 'Osakaland Map', 'Mapa de Osakaland', 300, null, 5),
/*鍵*/
(571, 'サッカー部室の鍵', 'Soccer Club Key', 'Llave club', 6000, null, 6),
(572, '体育館の鍵', 'Gym Key', 'Llave del gimnasio', null, null, 6),
(573, '研究室の鍵', 'Laboratory Key', 'Llave del laboratorio', null, null, 6),
(574, 'カノンの家の鍵', 'Canon\'s house Key', 'Llave de la casa de Canon', null, null, 6),
(575, 'でんしょうの鍵', 'Legendary Key', 'Llave legendaria', null, null, 6),
(576, '駄菓子屋の鍵', 'Sweet Shop Key', 'Llave tienda chuches', 6000, null, 6),
(577, '地下道路の鍵', 'Underground Tunnel Key', 'Llave túnel', null, null, 6),
(578, 'カノンの通信機', 'Canon\'s Phone', 'Comunicador de Canon', null, null, 6),
/*対戦チケット*/
(579, '戦士たちのほこり', 'Warrior pride', 'Orgullo guerrero', null, null, 7),
(580, 'アジア予選の思い出', 'Asian Qualifying Memories', 'Recuerdos de Asia', null, null, 7),
(581, 'カオスチケット', 'Chaos Card', 'Tarjeta del futuro', null, null, 7),
(582, 'イプシロンチケット', 'Epsilon Card', 'Tarjeta Épsilon', null, null, 7),
(583, 'イプシロン改チケット', 'Epsilon Plus Card', 'Tarjeta Épsilon Plus', null, null, 7),
(584, 'ジェミニチケット', 'Gemini Card', 'Tarjeta Géminis', null, null, 7),
(585, 'ジェネシスチケット', 'Genesis Card', 'Tarjeta Génesis', 7500, null, 7),
(586, 'イナズマチケット', 'Inazuma Card', 'Tarjeta Inazuma', null, null, 7),
(587, 'ワールドチケット', 'World Card', 'Tarjeta mundial', 10000, null, 7),
(588, 'コンサートチケット', 'Musical Card', 'Tarjeta musical', null, null, 7),
(589, '真・帝国学園チケット', 'R. A. Redux Card', 'Tarjeta R. A. Redux', null, null, 7),
(590, 'カードチケット', 'Card VS Card', 'Tarjeta tarjetera', null, null, 7),
(591, '闇のチケット', 'Dark Card', 'Tarjeta tenebrosa', 3000, null, 7),
(592, 'ウラゼウスチケット', 'Ultra Zeus Card', 'Tarjeta Ultra Zeus', 6000, null, 7),
(593, 'ゼウスチケット', 'Zeus Card', 'Tarjeta Zeus', 3500, null, 7),
/*回復*/
(594, 'ぎゅうにゅう', 'Milk', 'Leche', 10, null, 8),
(595, 'ミネラルウォーター', 'Mineral water', 'Agua mineral', 20, null, 8),
(596, 'スポーツウォーター', 'Sports water', 'Agua isotónica', 45, null, 8),
(597, 'スーパーウォーター', 'Super water', 'Agua medicinal', 100, null, 8),
(598, 'スペシャルドリンク', 'Special drink', 'Bebida especial', 200, null, 8),
(599, 'おにぎり', 'Rice ball', 'Bola de arroz', 10, null, 8),
(600, 'クッキーフレーバー', 'Cookie', 'Galleta', 35, null, 8),
(601, 'スタミナフレーバー', 'Bar', 'Barrita', 95, null, 8),
(602, 'ハイパーフレーバー', 'Chocolate', 'Chocolate', 190, null, 8),
(603, 'スペシャルフレーバー', 'Special Bar', 'Barrita especial', 380, null, 8),
(604, 'ラーメン', 'Ramen', 'Fideos', 250, null, 8),
(605, 'ごくじょうのおでん', 'Youth Oden', 'Pinchito supremo', 500, null, 8),
/*さいごのノート*/
(606, 'さいごのノート一', 'Ultimate Note 1', 'Cuaderno definitivo Extracto 1', 
    null, null, 9),
(607, 'さいごのノート二', 'Ultimate Note 2', 'Cuaderno definitivo Extracto 2', 
    null, null, 9),
(608, 'さいごのノート三', 'Ultimate Note 3', 'Cuaderno definitivo Extracto 3', 
    null, null, 9),
(609, 'さいごのノート四', 'Ultimate Note 4', 'Cuaderno definitivo Extracto 4', 
    null, null, 9),
(610, 'さいごのノート五', 'Ultimate Note 5', 'Cuaderno definitivo Extracto 5', 
    null, null, 9),
(611, 'さいごのノート六', 'Ultimate Note 6', 'Cuaderno definitivo Extracto 6', 
    null, null, 9),
(612, 'さいごのノート七', 'Ultimate Note 7', 'Cuaderno definitivo Extracto 7', 
    null, null, 9),
(613, 'さいごのノート八', 'Ultimate Note 8', 'Cuaderno definitivo Extracto 8', 
    null, null, 9),
(614, 'さいごのノート九', 'Ultimate Note 9', 'Cuaderno definitivo Extracto 9', 
    null, null, 9),
(615, 'さいごのノート十', 'Ultimate Note 10', 'Cuaderno definitivo Extracto 10', 
    null, null, 9),
(616, 'さいごのノート十一', 'Ultimate Note 11', 'Cuaderno definitivo Extracto 11', 
    null, null, 9),
/*ウェア*/
(617, '雷門中ウェア', 'Raimon Kit', 'Equipo Raimon', null, null, 10),
(618, '帝国ウェア', 'Royal Kit', 'Equipo Royal', null, null, 10),
(619, '尾刈斗ウェア', 'Occult Kit', 'Equipo Occult', null, null, 10),
(620, '野生中ウェア', 'Wild Kit', 'Equipo Wild', null, null, 10),
(621, '御影ウェア', 'Brain Kit', 'Equipo Brain', null, null, 10),
(622, '秋葉ウェア', 'Otaku Kit', 'Equipo Otaku', null, null, 10),
(623, '戦国ウェア', 'Shuriken Kit', 'Equipo Shuriken', null, null, 10),
(624, '千羽山ウェア', 'Farm Kit', 'Equipo Farm', null, null, 10),
(625, '木戸川ウェア', 'Kirkwood Kit', 'Equipo Kirkwood', null, null, 10),
(626, '世宇子ウェア', 'Zeus Kit', 'Equipo Zeus', null, null, 10),
(627, 'KFCウェア', 'Kids Kit', 'Equipo Kids FC', null, null, 10),
(628, '傘美野ウェア', 'Umbrella Kit', 'Equipo Umbrella', null, null, 10),
(629, 'れきせんのウェア', 'Old School', 'Vieja Escuela', null, null, 10),
(630, 'サリーズウェア', 'Sallys Kit', 'Equipo Sallys', null, null, 10),
(631, 'ジェミニウェア', 'Gemini Kit', 'Equipo Géminis', 1000, null, 10),
(632, 'イプシロンウェア', 'Epsilon Kit', 'Equipo Épsilon', 1200, null, 10),
(633, 'ジェネシスウェア', 'Genesis Kit', 'Equipo Génesis', 1500, null, 10),
(634, 'SPウェア', 'Secret Service Kit', 'Equipo Servicio Secreto', null, null, 10),
(635, '白恋ウェア', 'Alpine Kit', 'Equipo Alpino', null, null, 10),
(636, '漫遊寺ウェア', 'Cloister Kit', 'Equipo Claustro', null, null, 10),
(637, '真・帝国学園ウェア', 'Royal Academy Redux Kit', 'Equipo Royal Academy Redux', null, null, 10),
(638, '陽花戸ウェア', 'Fauxshore Kit', 'Equipo Fauxshore', null, null, 10),
(639, '大海原中ウェア', 'Mary Times Kit', 'Equipo Mary Times', null, null, 10),
(640, 'ダークEウェア', 'Dark Emperors Kit', 'Equipo Emperadores Oscuros', null, null, 10),
(641, '大阪ギャルズウェア', 'Triple C Kit', 'Equipo Triple C', null, null, 10),
(642, '警備マシンズウェア', 'Robot Guards Kit', 'Equipo Robots Guardias', null, null, 10),
(643, 'プロミネンスウェア', 'Prominence Kit', 'Equipo Prominence', null, null, 10),
(644, 'D･ダストウェア', 'Diamond Dust Kit', 'Equipo Polvo de Diamantes', null, null, 10),
(645, 'カオスウェア', 'Chaos Kit', 'Equipo Caos', 2000, null, 10),
(646, 'イナズマJウェア', 'Inazuma Japan Kit', 'Equipo Inazuma Japón', null, null, 10),
(647, 'Ｂウェイブスウェア', 'Big Waves Kit', 'Equipo Big Waves', null, null, 10),
(648, 'Ｄライオンウェア', 'Desert Lions Kit', 'Equipo Leones del Desierto', null, null, 10),
(649, 'ネオジャパンウェア', 'Neo Japan Kit', 'Equipo Neo Japón', null, null, 10),
(650, 'Fドラゴンウェア', 'Fire Dragon Kit', 'Equipo Dragones de Fuego', null, null, 10),
(651, 'K・O・Qウェア', 'Knights of Queen Kit', 'Equipo Knights of Queen', null, null, 10),
(652, 'チームKsウェア', 'Team D Kit', 'Equipo D', null, null, 10),
(653, 'エンパイアウェア', 'The Empire Kit', 'Equipo Emperadores', null, null, 10),
(654, 'ユニコーンウェア', 'Unicorn Kit', 'Equipo Unicorn', null, null, 10),
(655, 'オルフェウスウェア', 'Orpheus Kit', 'Equipo Orfeo', null, null, 10),
(656, 'ガルシルドウェア', 'Zoolan Kit', 'Equipo Zoolan', null, null, 10),
(657, 'キングダムウェア', 'The Kingdom Kit', 'Equipo Os Reis', null, null, 10),
(658, 'Lギガントウェア', 'Little Gigant Kit', 'Equipo Pequeños Gigantes', null, null, 10),
(659, 'Rグリフォンウェア', 'Rose Griffons Kit', 'Equipo Grifos de la Rosa', null, null, 10),
(660, 'マタドールウェア', 'Red Matador Kit', 'Equipo Los Rojos', null, null, 10),
(661, 'ブロッケンウェア', 'Brocken Brigade Kit', 'Equipo Brocken Brigade', null, null, 10),
(662, 'Gホーンウェア', 'The Cape Crusaders Kit', 'Equipo Caimanes del Cabo', null, null, 10),
(663, 'てんくうのウェア', 'Sky Team Kit', 'Equipo Sky Team', null, null, 10),
(664, '魔界軍団ウェア', 'Dark Team Kit', 'Equipo Dark Team', null, null, 10),
(665, 'てんまのウェア', 'Dark Angels Kit', 'Equipo Ángel Oscuro', null, null, 10),
(666, 'オーガウェア', 'Ogre Kit', 'Equipo Ogro', null, null, 10),
(667, 'アトランチクウェア', 'Atlantica', 'Mar Adentro', null, null, 10),
(668, 'あめのウェア', 'Rain', 'Estelas Blancas', null, null, 10),
(669, 'いちばんぼしウェア', 'First Star', 'Estrella Temprana', null, null, 10),
(670, 'カームウェア', 'Calm', 'Serenidad', null, null, 10),
(671, 'カミナリウェア', 'Thunder', 'Relámpago', null, null, 10),
(672, 'がんじょうウェア', 'Firm', 'Resistente', null, null, 10),
(673, 'カンフーウェア', 'Kung-Fu', 'Kung-Fu', null, null, 10),
(674, 'きこうしのウェア', 'Prince', 'Principito', null, null, 10),
(675, 'きぞくのウェア', 'Relined', 'Burgués', null, null, 10),
(676, 'げっこうのウェア', 'Moonlight', 'Luz de Luna', null, null, 10),
(677, 'ごくあくウェア', 'Terror', 'Vileza', null, null, 10),
(678, 'こわもてウェア', 'Hard-face', 'Apabullante', null, null, 10),
(679, 'ザ・カードウェア', 'Card Kit', 'Equipo Tarjetero', null, null, 10),
(680, 'シェイパブルウェア', 'Chelly', 'Favorecedor', null, null, 10),
(681, 'じゅんじょうウェア', 'Naive', 'Pureza', null, null, 10),
(682, 'じょうねつのウェア', 'Passion', 'Pura Pasión', null, null, 10),
(683, 'しんしのウェア', 'Gentleman', 'Señorito', null, null, 10),
(684, 'シンメトリウェア', 'Symmetry', 'Simétrico', null, null, 10),
(685, 'スカルウェア', 'Skull', 'Calavera', null, null, 10),
(686, 'ストライプウェア', 'Stripe', 'Barras', null, null, 10),
(687, 'ストライプウェア２', 'Stripe 2', 'Barras 2.0', null, null, 10),
(688, 'ストリームウェア', 'Stream', 'Meteoro', null, null, 10),
(689, 'スペースウェア', 'Space', 'Espacio Exterior', null, null, 10),
(690, 'スポットウェア', 'Spot', 'De Lunares', null, null, 10),
(691, 'スマートウェア', 'Smart', 'Pura Elegancia', null, null, 10),
(692, 'スリースターウェア', 'Tri Star', 'Triestela', null, null, 10),
(693, 'セーラーウェア', 'Sailor', 'Marinero', null, null, 10),
(694, 'ゼブラウェア', 'Zebra', 'Cebreado', null, null, 10),
(695, 'せんしのウェア', 'Soldier', 'Guerrero', null, null, 10),
(696, 'タイトポップウェア', 'Tight-pop', 'Cinturita de Avispa', null, null, 10),
(697, 'テクノウェア', 'Techno', 'Tecnomanía', null, null, 10),
(698, 'でんせつのウェア', 'Legendary', 'Leyenda', null, null, 10),
(699, 'とうこんのウェア', 'Mettle', 'Espíritu Luchador', null, null, 10),
(700, 'トリコロールウェア', 'Tricolor', 'Tricolor', null, null, 10),
(701, 'ハイスリーブウェア', 'High-sleeve', 'Fibra de Carbono', null, null, 10),
(702, 'ひらめきウェア', 'Inspirate', 'Perspicacia', null, null, 10),
(703, 'ファングウェア', 'Fang', 'Incisivo', null, null, 10),
(704, 'ブイサインウェア', 'V-sign', 'Victoria', null, null, 10),
(705, 'フューチャーウェア', 'Future', 'Futurista', null, null, 10),
(706, 'フロッグウェア', 'Frog', 'Rana', null, null, 10),
(707, 'ほのおのウェア', 'Flame', 'La Llama', null, null, 10),
(708, 'ホライゾンウェア', 'Horizon', 'El Horizonte', null, null, 10),
(709, 'マーシャルウェア', 'Martial', 'Mariscal', null, null, 10),
(710, 'マルチユーズウェア', 'Multi-use', 'Multiusos', null, null, 10),
(711, 'ゆうじょうのウェア', 'Friendly', 'Amistad Entrañable', null, null, 10),
(712, 'ゆうやけのウェア', 'Sunset', 'Sol Poniente', null, null, 10),
(713, 'ライジングウェア', 'Rising', 'Aspirante', null, null, 10),
(714, 'ライダースウェア', 'Rider', 'Motero', null, null, 10),
(715, 'レトロウェア', 'Retro', 'Retro', null, null, 10),
/*必殺タクティクス*/
(716, 'ルート・オブ・スカイ', 'Sky\'s the Limit', 'Cielo Infinito', null, null, 11),
(717, 'ダンシングボールエスケープ', 'Trapdance', 'Contradanza Ofensiva', null, null, 11),
(718, 'デュアルタイフーン', 'Dual Typhoon', 'Tifones Gemelos', null, null, 11),
(719, 'えんげつのじん', 'Full Moon Formation', 'Ataque de la Media Luna', null, null, 11),
(720, 'むてきのヤリ', 'Invincible Lance', 'Lanza Invencible', null, null, 11),
(721, 'ローリングサンダー', 'Rolling Thunder', 'Trueno Rodante', null, null, 11),
(722, 'エンペラーロード', 'Royal Road', 'Carretera Imperial', null, null, 11),
(723, 'アマゾンリバーウェーブ', 'Amazon Wave', 'Ola del Amazonas', null, null, 11),
(724, 'バナナシュート', 'Banana Shoot', 'Banana Shoot', null, null, 11),
(725, 'ザ・チューブ', 'The Tube', 'Cañón de Agua', null, null, 11),
(726, 'ボックスロックディフェンス', 'Box Lock ', 'Defensa en Bloque', null, null, 11),
(727, 'アブソリュートナイツ', 'Absolute Knights', 'Caballeros Perfectos', null, null, 11),
(728, 'アンデスのありじごく', 'Andes Antlion', 'Trampa Andina', null, null, 11),
(729, 'パーフェクトゾーンプレス', 'Perfect Zone Press', 'Presión Perfecta', null, null, 11),
(730, 'カテナチオカウンター', 'Catenaccio Counter', 'Contra Ataque Catenacchio', null, null, 11),
(731, 'サークルプレードライブ', 'Circular Drive', 'Impulso Circular', null, null, 11),
(732, 'ゴーストロック', 'Ghost Lock', 'Bloqueo Espectral', null, null, 11),
(733, 'セイントフラッシュ', 'Godspeed', 'Rayo Luminoso ', null, null, 11),
(734, 'ブラックサンダー', 'Dark Thunder', 'Trueno Oscuro', null, null, 11),
(735, 'クイックタイム', 'Fast Forward', 'Aceleración', null, null, 11),
(736, 'スロータイム', 'Slow-Mo', 'Deceleración', null, null, 11),
/*フォーメーション*/
(737, 'F-ベーシック', 'F-Basic', 'Diamante', null, null, 12),
(738, 'F-ブランゼル', 'F-Branzel', 'Ángel Oscuro', null, null, 12),
(739, 'F-Dエンペラー', 'F-D Emperor', 'Emperadores Oscuros', null, null, 12),
(740, 'F-ビッグウェイブ', 'F-Big Wave', 'Big Waves', null, null, 12),
(741, 'F-Dライオン', 'F-D Lion', 'Leones del Desierto', null, null, 12),
(742, 'F-ナイツ', 'F-Knights', 'Knights of Queen', null, null, 12),
(743, 'F-エンパイア', 'F-Empire', 'Emperadores', null, null, 12),
(744, 'F-ユニコーン', 'F-Unicorn', 'Unicorn', null, null, 12),
(745, 'F-アサシン', 'F-Assassin', 'Guadaña', null, null, 12),
(746, 'F-リトルギガント', 'F-Little Gigant', 'Pequeños Gigantes', null, null, 12),
(747, 'F-エッフェル', 'F-Eiffel', 'Grifos de la Rosa', null, null, 12),
(748, 'F-デスゾーン', 'F-Death Zone', 'Zona muerta', null, null, 12),
(749, 'F-デスゾーン２', 'F-Death Zone 2', 'Zona muerta 2', null, null, 12),
(750, 'F-ダブルドッグ', 'F-Double Dog', 'Can doble', null, null, 12),
(751, 'F-イージス', 'F-Aegis', 'Aegis', null, null, 12),
(752, 'F-パンデモニウム', 'F-Pandemonium', 'Pandemonio', null, null, 12),
(753, 'F-ジェミニ', 'F-Gemini', 'Géminis', null, null, 12),
(754, 'F-ジェネシス', 'F-Genesis', 'Génesis', null, null, 12),
(755, 'F-カオス', 'F-Chaos', 'Caos', null, null, 12),
(756, 'F-KAGE', 'F-KAGE', 'Oscuridad', null, null, 12),
(757, 'F-オルフェウス', 'F-Orpheus', 'Orfeo', null, null, 12),
(758, 'F-オーガ', 'F-Ogre', 'Ogro', null, null, 12),
(759, 'F-ゴーストダンス', 'F-Ghost Dance', 'Flecha espectral', null, null, 12),
(760, 'F-ワイルドパーク', 'F-Wild Park', 'Jungla', null, null, 12),
(761, 'F-GRID442', 'F-GRID442', 'Reja', null, null, 12),
(762, 'F-パンテオン', 'F-Pantheon', 'Panteón', null, null, 12),
(763, 'F-ブリッツ', 'F-Blitz', 'Brocken Brigade', null, null, 12),
(764, 'F-かくよくのじん', 'F-Kakuyoku no Jin', 'Alas de grulla', null, null, 12),
(765, 'F-スーパー☆5', 'F-Super☆5', 'Pirámide', null, null, 12),
(766, 'F-むげんのかべ', 'F-Mugen no Kabe', 'Árbol de Navidad', null, null, 12),
(767, 'F-ムカタマーチ', 'F-Mukata March', 'Ataque trillizo', null, null, 12),
(768, 'F-スリートップ', 'F-Three Top', 'Tridente', null, null, 12),
(769, 'F-キングダム', 'F-Kingdom', 'Os Reis', null, null, 12),
(770, 'F-Fドラゴン', 'F-F Dragon', 'Dragones de Fuego', null, null, 12),
(771, 'F-フェニックス', 'F-Phoenix', 'Vuelo del Fénix', null, null, 12),
(772, 'F-バタフライ', 'F-Butterfly', 'Doble W', null, null, 12),
(773, 'F-ヘブンズゲート', 'F-Heaven\'s Gate', 'Puerta al cielo', null, null, 12),
(774, 'F-マタドール', 'F-Matador', 'Los Rojos', null, null, 12),
(775, 'F-ファランクス', 'F-Phalanx', 'Ancla', null, null, 12),
(776, 'F-イプシロン', 'F-Epsilon', 'Épsilon', null, null, 12),
(777, 'F-ドットプリズン', 'F-Dot Prison', 'Doble M', null, null, 12),
(778, 'F-ボー＆アロー', 'F-Bow & Arrow', 'Pala', null, null, 12),
(779, 'F-ミドルブロック', 'F-Middle Block', 'Autobús', null, null, 12),
(780, 'F-NEO', 'F-NEO', 'Neo', null, null, 12),
(781, 'F-ブレッド', 'F-Bread', 'Caimanes del Cabo', null, null, 12),
(782, 'B-ベーシック', 'B-Basic', 'Tirachinas', null, null, 12),
(783, 'B-フラットバック', 'B-Flat Back', 'En línea', null, null, 12),
(784, 'B-アタッカー', 'B-Attacker', 'Incursión', null, null, 12),
(785, 'B-ブレイクスルー', 'B-Breakthrough', 'Kamikaze', null, null, 12),
(786, 'B-プレッシャー', 'B-Pressure', 'Cerrojo', null, null, 12),
(787, 'B-スラッシュ', 'B-Slash', 'Diagonal', null, null, 12),
(788, 'B-ライトウィング', 'B-Right Wing', 'Ala derecha', null, null, 12),
(789, 'B-トレイン', 'B-Train', 'Torre', null, null, 12),
(790, 'B-トライアングル', 'B-Triangle', 'Pachanga total', null, null, 12),
(791, 'B-ランス', 'B-Lance', 'Lanza', null, null, 12),
/*misc*/
(792, 'ロココ', 'Helio', 'Helio', null, null, 4);

insert into tactic_type (
    tactic_type_id,
    tactic_type_name_ja,
    tactic_type_name_en,
    tactic_type_name_es) values 
(1, '攻', 'Att.', 'At.'),
(2, '守', 'Def.', 'Def.'),
(3, '攻守', 'A/D', 'A/D'),
(4, 'キック', 'Kick', 'Tiro');

insert into tactic_side (
    tactic_side_id,
    tactic_side_name_ja,
    tactic_side_name_en,
    tactic_side_name_es) values
(1, '自陣', 'Own half only', 'Solo en campo propio'),
(2, '敵陣', 'Opposition half only', 'Solo en campo contrario'),
(3, 'どこでも', 'Either half', 'Ambos campos'),
(4, 'FKとCK', 'Free kick/corner kick only', 'Saque de falta o de córner');

insert into item_tactic (
    item_tactic_id,
    item_tactic_ttp,
    item_tactic_power,
    item_tactic_effect_ja,
    item_tactic_effect_en,
    item_tactic_effect_es,
    tactic_type_id,
    tactic_side_id) values
(716, 40, 20, '前線までボールをダイレクトパス(相手サイドの左右どちらかに移動する)。', 'A simple tactic using high passing to bring the ball to the centre of the pitch.', 'Alcanza la portería sin dejar caer la pelota.', 1, 1),
(717, 40, 35, 'しばらくの間そばの敵を止める(４人)。', 'Stuns 4 nearby opponents.', 'Deja extenuados a 4 rivales cercanos.', 1, 2),
(718, 45, 28, 'ボールを前に運ぶ。', 'Forms twin twisters to carry the ball forward.', 'Ábrete paso con dos tifones imparables.', 1, 1),
(719, 50, 35, '7人でボールを前へ運ぶ。', 'Seven players carry the ball forward.', 'Genera un taladro de arena imparable.', 1, 1),
(720, 50, 40, '4人でボールを前へ運ぶ。', 'Four players carry the ball forward.', 'Avanza con una formación en punta de lanza.', 1, 1),
(721, 50, 24, '4人でボールを前に運ぶ。', 'Blast forward like a four-man thunderstorm.', 'Tormenta de disparos con cuatro jugadores.', 1, 3),
(722, 50, 28, '敵のフォーメーションを左右に崩す。', 'Clear the way for a red carpet route to goal.', 'Despeja la senda hasta el área del adversario.', 1, 3),
(723, 55, 38, '敵全員を止めつつ前進する。', 'Flood forward in a stunning surge.', 'Ábrete camino con una ola descomunal.', 1, 1),
(724, 40, 60, 'バナナのように反り返るシュート。', 'Bend it like a banana.', 'Chuta el balón con efecto como un plátano.', 4, 4),
(725, 40, 67, '波にのせてカーブするシュート。', 'A gnarly curve shot that rides the waves.', 'Chuta el balón con efecto como una ola.', 4, 4),
(726, 40, 40, '4人で囲んでボールを奪う。', 'Four players mark their opponent in a circle to get the ball in a moment.', 'Cuatro jugadores rodean al rival en forma de cuadrado.', 2, 1),
(727, 40, 25, '次々におそいかかりボールをうばう。', 'Strike in succession to reclaim the ball.', 'Apodérate del esférico en fila india.', 2, 3),
(728, 50, 45, '敵をさそいこんでボールをうばう。', 'Lure the enemy in,  then steal the ball.', 'Recupera el esférico con una trampa de arena.', 2, 1),
(729, 50, 35, '炎のうずをおこしボールをうばう。', 'Steal the ball with a cyclone of fire.', 'Roba ek balón con una espiral incandescente.', 2, 3),
(730, 55, 36, 'ボールをうばいすかさず前へロングパス。', 'This shock move turns a tackle into an attack.', 'Desconcierta al rival con un contraataque.', 2, 1),
(731, 60, 33, '８人で敵をゴール前へ運ぶ。', 'An eight-man cyclone forces the enemy back.', 'Detén al contrario con la fuerza de un ciclón.', 2, 1),
(732, 60, 20, 'しばらくの間敵全員を止める。', 'Supernatural forces stop all enemy movement.', 'Inmoviliza al enemigo con poderes hipnóticos.', 3, 3),
(733, 60, 18, 'しばらくの間味方全員を速くする。', 'Call down a divine light to increase your team\'s speed for ten seconds.', 'La velocidad de todos los jugadores del equipo aumentara temporalmente.', 3, 3),
(734, 60, 18, 'しばらくの間敵全員を遅くする。', 'Slow the enemy with a flash of black lightning.', 'Ralentiza a todos los jugadores contrarios por un tiempo.', 3, 3),
(735, 65, 18, 'しばらくの間時間を早くする。', 'Briefly speeds up match time.', 'Acelera el tiempo durante unos instantes.', 3, 3),
(736, 65, 18, 'しばらくの間時間を遅くする。', 'Briefly slows down match time.', 'Ralentiza el tiempo durante unos instantes.', 3, 3);

insert into equipment_type (
    equipment_type_id,
    equipment_type_name_ja,
    equipment_type_name_en,
    equipment_type_name_es) values
(1, 'シューズ', 'Shoes', 'Botas'),
(2, 'グローブ', 'Gloves', 'Guantes'),
(3, 'アクセサリ', 'Accessories', 'Accesorios');

insert into item_equipment (
    item_equipment_id,
    equipment_type_id) values
(379, 1),
(380, 1),
(381, 1),
(382, 1),
(383, 1),
(384, 1),
(385, 1),
(386, 1),
(387, 1),
(388, 1),
(389, 1),
(390, 1),
(391, 1),
(392, 1),
(393, 1),
(394, 1),
(395, 1),
(396, 1),
(397, 1),
(398, 1),
(399, 1),
(400, 1),
(401, 1),
(402, 1),
(403, 1),
(404, 1),
(405, 1),
(406, 1),
(407, 1),
(408, 1),
(409, 1),
(410, 1),
(411, 1),
(412, 1),
(413, 1),
(414, 1),
(415, 1),
(416, 1),
(417, 1),
(418, 1),
(419, 1),
(420, 1),
(421, 1),
(422, 1),
(423, 1),
(424, 1),
(425, 1),
(426, 1),
(427, 1),
(428, 1),
(429, 1),
(430, 1),
(431, 1),
(432, 1),
(433, 1),
(434, 1),
(435, 1),
(436, 1),
(437, 1),
(438, 1),
(439, 1),
(440, 1),
(441, 1),
(442, 1),
(443, 1),
(444, 1),
(445, 1),
(446, 1),
(447, 1),
(448, 1),
(449, 1),
(450, 1),
(451, 1),
(452, 1),
(453, 1),
(454, 1),
(455, 2),
(456, 2),
(457, 2),
(458, 2),
(459, 2),
(460, 2),
(461, 2),
(462, 2),
(463, 2),
(464, 2),
(465, 2),
(466, 2),
(467, 2),
(468, 2),
(469, 2),
(470, 2),
(471, 2),
(472, 2),
(473, 2),
(474, 2),
(475, 2),
(476, 2),
(477, 2),
(478, 2),
(479, 2),
(480, 2),
(481, 2),
(482, 2),
(483, 2),
(484, 2),
(485, 2),
(486, 2),
(487, 2),
(488, 2),
(489, 2),
(490, 2),
(491, 2),
(492, 2),
(493, 2),
(494, 2),
(495, 2),
(496, 2),
(497, 2),
(498, 2),
(499, 2),
(500, 2),
(501, 2),
(502, 2),
(503, 2),
(504, 2),
(505, 2),
(506, 2),
(507, 2),
(508, 2),
(509, 2),
(510, 2),
(511, 2),
(512, 2),
(513, 2),
(514, 2),
(515, 2),
(516, 2),
(517, 2),
(518, 2),
(519, 2),
(520, 3),
(521, 3),
(522, 3),
(523, 3),
(524, 3),
(525, 3),
(526, 3),
(527, 3),
(528, 3),
(529, 3),
(530, 3),
(531, 3),
(532, 3),
(533, 3),
(534, 3),
(535, 3),
(536, 3),
(537, 3),
(538, 3),
(539, 3),
(540, 3),
(541, 3),
(542, 3),
(543, 3),
(544, 3),
(545, 3),
(546, 3),
(547, 3),
(548, 3),
(549, 3),
(550, 3),
(551, 3),
(552, 3);

insert into item_currency (
    item_currency_id,
    item_currency_carry_limit) values
(553, 999999),
(554, 999999),
(555, null),
(556, 99),
(557, 99),
(558, 99),
(559, 99);

insert into item_reward_player (
    item_reward_player_id,
    player_id) values
(560, 866),
(561, 1348),
(562, 1027),
(563, 1269),
(564, 282),
(565, 416),
(792, 1586);

insert into item_map (
    item_map_id,
    zone_id) values
(566, 8),
(567, 4),
(568, 9),
(569, 5),
(570, 159);

insert into item_key (
    item_key_id,
    zone_id) values
(571, 113),
(572, 117),
(573, 175),
(574, 253),
(575, 24),
(576, 119),
(577, 256),
(578, 251);

insert into item_recovery (
    item_recovery_id,
    item_recovery_gp,
    item_recovery_tp) values
(594, 15, null),
(595, 25, null),
(596, 45, null),
(597, 70, null),
(598, -1, null),
(599, null, 15),
(600, null, 25),
(601, null, 50),
(602, null, 75),
(603, null, -1),
(604, 45, 45),
(605, -1, -1);

insert into item_ultimate_note (
    item_ultimate_note_id,
    item_ultimate_note_order) values
(606, 1),
(607, 2),
(608, 3),
(609, 4),
(610, 5),
(611, 6),
(612, 7),
(613, 8),
(614, 9),
(615, 10),
(616, 11);

insert into item_wear (
    item_wear_id,
    item_wear_hex) values
(617, 'e6c739'),
(618, '204128'),
(619, '43385b'),
(620, '296131'),
(621, 'efd2a3'),
(622, '15617a'),
(623, '5b415a'),
(624, 'a37804'),
(625, 'b20000'),
(626, 'c3c3bb'),
(627, 'd41315'),
(628, 'b3dbdc'),
(629, '42384b'),
(630, 'ffc200'),
(631, '5a4943'),
(632, 'a3000d'),
(633, 'a39abb'),
(634, '0e0c0e'),
(635, 'f7f7d4'),
(636, 'f68b17'),
(637, '314839'),
(638, '159af8'),
(639, '219993'),
(640, '0b2042'),
(641, 'e98fb9'),
(642, 'a4929b'),
(643, 'd92f1e'),
(644, '3168a3'),
(645, '6c484f'),
(646, '188ee4'),
(647, 'f9d27a'),
(648, '680415'),
(649, 'a4a2aa'),
(650, 'd31406'),
(651, 'f0e6dc'),
(652, '48697a'),
(653, '83a2cc'),
(654, 'c5aa9b'),
(655, '4b68a5'),
(656, '4a494a'),
(657, 'fec901'),
(658, '5ab292'),
(659, '153999'),
(660, 'e84014'),
(661, '252d31'),
(662, '208a5a'),
(663, 'e8dbe6'),
(664, '48464a'),
(665, 'e86913'),
(666, 'a30004'),
(667, '28009f'),
(668, '64a283'),
(669, '0d9013'),
(670, '524142'),
(671, 'cb2f0e'),
(672, 'bba900'),
(673, 'b50004'),
(674, '81370c'),
(675, '0d4121'),
(676, '092f73'),
(677, '504f7b'),
(678, '157014'),
(679, 'dc0c06'),
(680, 'e8d321'),
(681, '9c689f'),
(682, '583910'),
(683, '314839'),
(684, '137700'),
(685, 'c2bfb9'),
(686, '0040a8'),
(687, 'e2000d'),
(688, '259a65'),
(689, '8b7ac6'),
(690, 'e70021'),
(691, 'b336d8'),
(692, '394156'),
(693, '8db1a8'),
(694, 'f0f1f2'),
(695, 'ec0306'),
(696, 'b92952'),
(697, '64ad6c'),
(698, '312f31'),
(699, '312f31'),
(700, '013d95'),
(701, '9c1414'),
(702, '9c1414'),
(703, '3159bb'),
(704, 'ddc403'),
(705, '0468fa'),
(706, '9cc64a'),
(707, 'a90c00'),
(708, '063ff3'),
(709, 'f4b205'),
(710, 'ee591e'),
(711, 'a9230a'),
(712, 'dc7021'),
(713, 'dc7021'),
(714, '15121f'),
(715, 'bbb2ac');

insert into npc (
    npc_id,
    npc_name_ja,
    npc_name_en,
    npc_name_es,
    zone_id) values
/*start-route*/
(1, '火来 伸蔵', 'Mr. Firewill', 'Sr. Firewill', 105),
(2, 'ロボット', 'Robot', 'Robot', 111),
(3, 'マシン', 'Machine', 'Robot', 115),
(4, '瞳子', 'Lina', 'Lina', 175),
(5, '雷門', 'Raimon', 'Raimon', 110),
(6, 'ダイスケ', 'David', 'David', 245),
(7, 'ロボット', 'Robot', 'Robot', 108),
(8, '鬼瓦', 'Smith', 'Smith', 114),
(9, '夕香', 'Julia', 'Julia', 118),
(10, 'ルシェ', 'Lizzy', 'Lizzy', 190),
/*start-match*/
(11, '千羽山選手', 'Farm', 'Jugador del Farm', 100),
(12, '真二屋', 'Artic', 'Artic', 159),
(13, '伊賀島', 'Igajima', 'Igajima', 130),
(14, '傘美野選手', 'Umbrella player', 'Jugador del Umbrella', 131),
(15, '監督', 'Coach', 'Entrenador', 171),
(16, '野生選手', 'Wild player', 'Jugador del Wild', 162),
(17, ' 御影専農選手', 'Brain player', 'Jugador del Brain', 137),
(18, '監督', 'Coach', 'Entrenador', 150),
(19, '尾刈斗選手', 'Occult player', 'Jugador del Occult', 155),
(20, '漫遊寺選手', 'Cloister Divinity player', 'Jugador del Claustro Sagrado', 161),
(21, '帝国選手', 'Royal Academy player', 'Jugador de la Royal Academy', 133),
(22, '校長', 'Principal', 'Director', 165),
(23, '木戸川選手', 'Kirkwood player', 'Jugador del Kirkwood', 174),
(24, 'ロボット', 'Robot', 'Robot', 180),
(25, 'ロボット', 'Robot', 'Robot', 134),
(26, 'ロボット', 'Robot', 'Robot', 173),
(27, 'ロボット', 'Robot', 'Robot', 247),
(28, 'ロボット', 'Robot', 'Robot', 258),
(29, 'ロボット', 'Robot', 'Robot', 242),
(30, 'ロボット', 'Robot', 'Robot', 144),
(31, 'ロボット', 'Robot', 'Robot', 213),
(32, 'ロボット', 'Robot', 'Robot', 213),
(33, 'ロボット', 'Robot', 'Robot', 206),
(34, 'ロボット', 'Robot', 'Robot', 206);

/*
chest
*/

/*
item_sold_at_stor
*/
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_stor_item.sql

/*
player_found_at_zone
*/

insert into equipment_strengthens_stat (
    item_equipment_id,
    stat_id,
    amount) values
(381, 7, 2),
(382, 7, 3),
(383, 7, 3),
(384, 7, 4),
(385, 7, 4),
(386, 7, 5),
(387, 7, 5),
(388, 7, 6),
(389, 7, 6),
(390, 7, 6),
(391, 7, 6),
(392, 7, 7),
(393, 7, 7),
(394, 7, 7),
(395, 7, 8),
(396, 7, 8),
(397, 7, 9),
(398, 7, 9),
(399, 7, 9),
(400, 7, 10),
(401, 7, 10),
(402, 7, 10),
(403, 7, 10),
(404, 7, 10),
(405, 7, 10),
(406, 7, 10),
(407, 7, 12),
(408, 7, 13),
(409, 7, 13),
(410, 7, 15),
(411, 7, 16),
(412, 7, 16),
(413, 7, 17),
(414, 7, 18),
(415, 3, 1),
(416, 3, 1),
(417, 3, 2),
(418, 3, 2),
(419, 3, 2),
(420, 3, 3),
(421, 3, 3),
(422, 3, 3),
(423, 3, 4),
(424, 3, 4),
(425, 3, 5),
(426, 3, 5),
(427, 3, 6),
(428, 3, 6),
(429, 3, 7),
(430, 3, 7),
(431, 3, 7),
(432, 3, 7),
(433, 3, 8),
(434, 3, 8),
(435, 3, 9),
(436, 3, 9),
(437, 3, 9),
(438, 3, 10),
(439, 3, 10),
(440, 3, 10),
(441, 3, 10),
(442, 3, 10),
(443, 3, 10),
(444, 3, 11),
(445, 3, 11),
(446, 3, 12),
(447, 3, 13),
(448, 3, 14),
(449, 3, 14),
(450, 3, 16),
(451, 3, 17),
(452, 3, 17),
(453, 3, 18),
(454, 3, 18),
(455, 6, 0),
(456, 6, 1),
(457, 6, 1),
(458, 6, 2),
(459, 6, 2),
(460, 6, 2),
(461, 6, 2),
(462, 6, 2),
(463, 6, 2),
(464, 6, 3),
(465, 6, 3),
(466, 6, 3),
(467, 6, 3),
(468, 6, 3),
(469, 6, 4),
(470, 6, 4),
(471, 6, 4),
(472, 6, 5),
(473, 6, 5),
(474, 6, 5),
(475, 6, 5),
(476, 6, 5),
(477, 6, 6),
(478, 6, 6),
(479, 6, 6),
(480, 6, 6),
(481, 6, 7),
(482, 6, 7),
(483, 6, 7),
(484, 6, 7),
(485, 6, 7),
(486, 6, 7),
(487, 6, 8),
(488, 6, 8),
(489, 6, 8),
(490, 6, 8),
(491, 6, 9),
(492, 6, 9),
(493, 6, 9),
(494, 6, 10),
(495, 6, 10),
(496, 6, 10),
(497, 6, 11),
(498, 6, 12),
(499, 6, 12),
(500, 6, 12),
(501, 6, 13),
(502, 6, 13),
(503, 6, 14),
(504, 6, 14),
(505, 6, 14),
(506, 6, 15),
(507, 6, 15),
(508, 6, 15),
(509, 6, 15),
(510, 6, 15),
(511, 6, 15),
(512, 6, 16),
(513, 6, 16),
(514, 6, 17),
(515, 6, 17),
(516, 6, 17),
(517, 6, 17),
(518, 6, 18),
(519, 6, 18),
(520, 9, 1),
(521, 9, 2),
(522, 9, 3),
(523, 9, 4),
(524, 9, 5),
(525, 9, 6),
(526, 9, 7),
(527, 9, 8),
(528, 9, 9),
(529, 9, 10),
(530, 9, 12),
(531, 9, 20),
(532, 9, 2),
(533, 9, 2),
(534, 9, 2),
(535, 5, 2),
(536, 5, 3),
(537, 5, 4),
(538, 5, 5),
(539, 5, 6),
(540, 5, 8),
(541, 5, 9),
(542, 4, 6),
(542, 2, 10),
(543, 4, 12),
(544, 4, 12),
(545, 8, 12),
(546, 8, 12),
(547, 4, 3),
(548, 4, 7),
(549, 4, 15),
(550, 8, 3),
(551, 8, 7),
(552, 8, 15);

insert into catch_type (
    catch_type_id,
    catch_type_name_ja,
    catch_type_name_en,
    catch_type_name_es) values
(1, 'キャッチ', 'Catch', 'Atajo'),
(2, 'パンチング', 'Punching', 'Despeje'),
(3, 'パンチング2', 'Punching 2', 'Despeje 2');

insert into shoot_special_property (
    shoot_special_property_id,
    shoot_special_property_name_ja,
    shoot_special_property_name_en,
    shoot_special_property_name_es) values
(1, 'シュートチェイン', 'Shoot Chain', 'Tiro Encadenado'),
(2, 'ロングシュート', 'Long Shoot', 'Tiro Largo'),
(3, 'シュートブロック', 'Shoot Block', 'Bloqueo de tiros');

insert into hissatsu_type (
    hissatsu_type_id,
    hissatsu_type_name_ja,
    hissatsu_type_name_en,
    hissatsu_type_name_es) values
(1, 'シュート', 'Shoot', 'Tiro'),
(2, 'ドリブル', 'Dribble', 'Regate'),
(3, 'ブロック', 'Block', 'Bloqueo'),
(4, 'キャッチ', 'Catch', 'Atajo'),
(5, 'スキル', 'Skill', 'Talento');

insert into growth_type (
    growth_type_id,
    growth_type_name_ja,
    growth_type_name_en,
    growth_type_name_es) values
(1, '改 - 真', '+1 → +2', '+ → ++'),
(2, 'V2 - V3', 'V2 → V3', 'N2 → N3'),
(3, 'グレート (G)', 'Levels (L)', 'Grados (G)');

insert into growth_rate (
    growth_rate_id,
    growth_rate_name_ja,
    growth_rate_name_en,
    growth_rate_name_es) values
(1, '早熟', 'Precocious', 'Precoz'),
(2, '普通', 'Average', 'Normal'),
(3, '晩成', 'Late Bloomer', 'Tardío');

insert into growth_type_can_achieve_growth_rate (
    growth_type_id,
    growth_rate_id,
    additional_power,
    number_of_uses) values 
/*真*/
(1, 1, 8, 21),
(1, 2, 10, 27),
(1, 3, 12, 33),
/*V3*/
(2, 1, 8, 21),
(2, 2, 10, 27),
(2, 3, 12, 33),
/*グレート 5*/
(3, 1, 14, 80),
(3, 2, 16, 90),
(3, 3, 18, 100);

source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_hissatsu.sql

/*
item_hissatsu
hissatsu_shoot
hissatsu_shoot_can_have_shoot_special_property
hissatsu_dribble
hissatsu_block
hissatsu_catch
hissatsu_skill
hissatsu_evolves
hissatsu_designed_for_attri
hissatsu_evokes_attri
hissatsu_limited_by_gender
hissatsu_constrained_by_body_type
hissatsu_available_for_positi
*/

insert into hissatsu_helped_by_attri (
    item_hissatsu_id,
    attri_id) values
(33, 3),
(34, 3),
(72, 4),
(73, 1),
(73, 3),
(108, 1),
(111, 1),
(141, 2),
(241, 4);

insert into hissatsu_combined_with_hissatsu (
    item_hissatsu_id_base,
    item_hissatsu_id_combined) values
(23, 11),
(28, 11),
(61, 7),
(89, 77),
(98, 77),
(102, 90),
(187, 196),
(193, 165),
(241, 301);

/*
hissatsu_special_restriction
hissatsu_restricted_by_hissatsu_special_restriction

insert into hissatsu_special_restriction (
    hissatsu_special_restriction_id,
    hissatsu_special_restriction_desc_ja,
    hissatsu_special_restriction_desc_en,
    hissatsu_special_restriction_desc_es
) values
(1, 
    'パートナーは火属性', 
    'Partner is fire element', 
    'El compañero es de afinidad fuego'),
(2, 
    'パートナーは風属性', 
    'Partner is wind element', 
    'El compañero es de afinidad aire'),
(3, 
    'パートナーは山属性', 
    'Partner is mountain element', 
    'El compañero es de afinidad montaña'),
(4, 
    'パートナーは林属性', 
    'Partner is forest element', 
    'El compañero es de afinidad bosque'),
(5, 
    'パートナーは火と風属性', 
    'The other partners are fire and wind element', 
    'Los otros compañeros son de afinidad fuego y bosque'),
(6, 
    'ファイアトルネード習得者', 
    'Partner knows Fire Tornado', 
    'El compañero sabe Tornado de Fuego'),
(7, 
    'バックトルネード習得者', 
    'Partner knows Back Tornado', 
    'El compañero sabe Tornado Inverso'),
(8, 
    'エターナルブリザード習得者', 
    'Partner knows Eternal Blizzard', 
    'El compañero sabe Ventisca Eterna'),
(9, 
    'ばくねつストーム習得者', 
    'Partner knows Fireball Storm', 
    'El compañero sabe Tormenta de Fuego'),
(1, 
    'スーパーアルマジロ習得者', 
    'Partner knows Super Armadillo', 
    'El compañero sabe Superarmadillo'),
(1, 
    'イリュージョンボール習得者', 
    'Partner knows Illusion Ball', 
    'El compañero sabe Espejismo de Balón'),
(1, 
    'ゴッドハンド（山）習得者', 
    'Partner knows God Hand and is mountain element', 
    'El compañero sabe Mano Celestial y es de afinidad montaña');
*/

drop table if exists player_learns_hissatsu;
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/player_learns_hissatsu.sql

/*
player_has_recommended_slot_hissatsu
player_has_recommended_gear_equipment
player_has_recommended_routine_tm
*/

insert into player_decrypted_with_passwd (
    player_id, 
    passwd_id ) values
(234, 1),
(1550, 2),
(1364, 3),
(482, 4),
(784, 5),
(1085, 5),
(963, 5),
(652, 5),
(1478, 6),
(740, 6),
(431, 6),
(752, 6),
(1127, 7),
(290, 7),
(1222, 7),
(653, 7),
(882, 8),
(281, 8),
(1284, 8),
(107, 8),
(917, 9),
(1428, 10),
(1396, 11),
(1396, 12),
(1396, 13),
(1396, 14),
(2077, 15),
(2077, 16),
(2077, 17),
(2077, 18),
(2077, 19),
(44, 20),
(1405, 20),
(1354, 20),
(242, 21),
(1405, 21),
(1354, 21);

insert into formation_type (
    formation_type_id,
    formation_type_name_ja,
    formation_type_name_en,
    formation_type_name_es
) values
(1, '対戦', 'Match', 'Partido'),
(2, 'ミニバトル', 'Random Battle', 'Pachanga');

insert into formation_scheme (
    formation_scheme_id,
    formation_scheme_name
) values
(1, '4-4-2'),
(2, '5-3-2'),
(3, '4-5-1'),
(4, '3-4-3'),
(5, '2-3-5'),
(6, '4-3-2-1'),
(7, '4-3-3'),
(8, '5-4-1'),
(9, '3-1-3-3'),
(10, '3-2-2-1-2'),
(11, '1-0-2'),
(12, '3-0-0'),
(13, '0-2-1'),
(14, '0-0-3'),
(15, '0-1-2'),
(16, '1-1-1'),
(17, '0-0-0'),
(18, '2-0-1');

insert into item_formation (
    item_formation_id,
    formation_type_id,
    formation_scheme_id,
    original_version
) values
(737, 1, 1, null), 
(738, 1, 1, 737),  
(739, 1, 1, 737),  
(740, 1, 1, 737),  
(741, 1, 1, 737),  
(742, 1, 1, 737),  
(743, 1, 1, 737),  
(744, 1, 1, 737),  
(745, 1, 1, 737),  
(746, 1, 1, 737),  
(747, 1, 1, 737),  
(748, 1, 2, null), 
(749, 1, 2, 748),  
(750, 1, 2, 748),  
(751, 1, 2, 748),  
(752, 1, 2, 748),  
(753, 1, 2, 748),  
(754, 1, 2, 748),  
(755, 1, 2, 748),  
(756, 1, 2, 748),  
(757, 1, 2, 748),  
(758, 1, 2, 748),  
(759, 1, 3, null), 
(760, 1, 4, null), 
(761, 1, 1, null), 
(762, 1, 1, 761),  
(763, 1, 1, 761),  
(764, 1, 1, null), 
(765, 1, 5, null), 
(766, 1, 6, null), 
(767, 1, 7, null), 
(768, 1, 7, 767),  
(769, 1, 7, 767),  
(770, 1, 7, 767),  
(771, 1, 7, null), 
(772, 1, 7, null),  
(773, 1, 1, null), 
(774, 1, 1, 773),  
(775, 1, 8, null), 
(776, 1, 8, 775),  
(777, 1, 4, null), 
(778, 1, 9, null), 
(779, 1, 10, null),
(780, 1, 7, null), 
(781, 1, 7, 780),  
(782, 2, 11, null),
(783, 2, 12, null),
(784, 2, 13, null),
(785, 2, 14, null),
(786, 2, 15, null),
(787, 2, 16, null),
(788, 2, 17, null),
(789, 2, 17, null),
(790, 2, 15, null),
(791, 2, 18, null);

insert into formation_organized_as_positi (
    item_formation_id,
    positi_id,
    place
) values
/*F-ベーシック*/
(737, 4, 1),
(737, 3, 2),
(737, 3, 3),
(737, 3, 4),
(737, 3, 5),
(737, 1, 6),
(737, 2, 7),
(737, 2, 8),
(737, 2, 9),
(737, 1, 10),
(737, 1, 11),
/*F-デスゾーン*/
(748, 4, 1),
(748, 3, 2),
(748, 3, 3),
(748, 2, 4),
(748, 3, 5),
(748, 2, 6),
(748, 2, 7),
(748, 2, 8),
(748, 1, 9),
(748, 2, 10),
(748, 1, 11),
/*F-ゴーストダンス*/
(759, 4, 1),
(759, 3, 2),
(759, 3, 3),
(759, 3, 4),
(759, 3, 5),
(759, 2, 6),
(759, 1, 7),
(759, 1, 8),
(759, 2, 9),
(759, 2, 10),
(759, 1, 11),
/*ワイルドパーク*/
(760, 4, 1),
(760, 2, 2),
(760, 3, 3),
(760, 3, 4),
(760, 2, 5),
(760, 1, 6),
(760, 2, 7),
(760, 2, 8),
(760, 1, 9),
(760, 1, 10),
(760, 1, 11),
/*F-GRID442*/
(761, 4, 1),
(761, 3, 2),
(761, 3, 3),
(761, 3, 4),
(761, 3, 5),
(761, 2, 6),
(761, 1, 7),
(761, 1, 8),
(761, 1, 9),
(761, 2, 10),
(761, 1, 11),
/*F-かくよくのじん*/
(764, 4, 1),
(764, 3, 2),
(764, 3, 3),
(764, 3, 4),
(764, 3, 5),
(764, 2, 6),
(764, 1, 7),
(764, 1, 8),
(764, 1, 9),
(764, 2, 10),
(764, 1, 11),
/*F-スーパー☆5*/
(765, 4, 1),
(765, 3, 2),
(765, 2, 3),
(765, 2, 4),
(765, 3, 5),
(765, 1, 6),
(765, 1, 7),
(765, 2, 8),
(765, 1, 9),
(765, 1, 10),
(765, 1, 11),
/*F-むげんのかべ*/
(766, 4, 1),
(766, 3, 2),
(766, 3, 3),
(766, 3, 4),
(766, 3, 5),
(766, 2, 6),
(766, 2, 7),
(766, 2, 8),
(766, 1, 9),
(766, 1, 10),
(766, 1, 11),
/*F-ムカタマーチ*/
(767, 4, 1),
(767, 3, 2),
(767, 3, 3),
(767, 3, 4),
(767, 3, 5),
(767, 2, 6),
(767, 2, 7),
(767, 2, 8),
(767, 1, 9),
(767, 1, 10),
(767, 1, 11),
/*F-フェニックス*/
(771, 4, 1),
(771, 3, 2),
(771, 3, 3),
(771, 3, 4),
(771, 3, 5),
(771, 2, 6),
(771, 2, 7),
(771, 2, 8),
(771, 1, 9),
(771, 1, 10),
(771, 1, 11),
/*F-バタフライ*/
(772, 4, 1),
(772, 3, 2),
(772, 3, 3),
(772, 3, 4),
(772, 3, 5),
(772, 2, 6),
(772, 2, 7),
(772, 2, 8),
(772, 1, 9),
(772, 1, 10),
(772, 1, 11),
/*F-ヘブンズゲート*/
(773, 4, 1),
(773, 3, 2),
(773, 3, 3),
(773, 3, 4),
(773, 3, 5),
(773, 1, 6),
(773, 2, 7),
(773, 1, 8),
(773, 1, 9),
(773, 2, 10),
(773, 2, 11),
/*F-ファランクス*/
(775, 4, 1),
(775, 3, 2),
(775, 3, 3),
(775, 3, 4),
(775, 3, 5),
(775, 3, 6),
(775, 1, 7),
(775, 2, 8),
(775, 1, 9),
(775, 2, 10),
(775, 1, 11),
/*F-ドットプリズン*/
(777, 4, 1),
(777, 3, 2),
(777, 3, 3),
(777, 3, 4),
(777, 2, 5),
(777, 2, 6),
(777, 2, 7),
(777, 2, 8),
(777, 1, 9),
(777, 1, 10),
(777, 1, 11),
/*F-ボー＆アロー*/
(778, 4, 1),
(778, 3, 2),
(778, 3, 3),
(778, 3, 4),
(778, 3, 5),
(778, 2, 6),
(778, 2, 7),
(778, 2, 8),
(778, 2, 9),
(778, 1, 10),
(778, 2, 11),
/*F-ミドルブロック*/
(779, 4, 1),
(779, 3, 2),
(779, 3, 3),
(779, 3, 4),
(779, 2, 5),
(779, 2, 6),
(779, 2, 7),
(779, 2, 8),
(779, 1, 9),
(779, 2, 10),
(779, 1, 11),
/*F-NEO*/
(780, 4, 1),
(780, 3, 2),
(780, 3, 3),
(780, 3, 4),
(780, 3, 5),
(780, 2, 6),
(780, 2, 7),
(780, 2, 8),
(780, 1, 9),
(780, 2, 10),
(780, 1, 11);

/*
SELECT
    w.item_wear_id,
    i.item_name_ja,
    i.item_name_en
FROM
    item_wear w
JOIN item i ON
    w.item_wear_id = i.item_id
*/

insert into team (
    team_id,
    team_name_ja,
    team_name_en,
    team_name_es,
    item_formation_id,
    item_wear_id
) values
/*FFチーム*/
(1, '傘美野', 'Umbrella Junior High', 'Instituto Umbrella', 737, 628),
(2, '尾刈斗', 'Occult Junior High', 'Instituto Occult', 759, 619),
(3, '野生', 'Wild Junior High', 'Instituto Wild', 760, 620),
(4, '御影専農', 'Brainwashing Junior High', 'Instituto Brain', 761, 621),
(5, '秋葉名戸', 'Otaku Junior High', 'Instituto Otaku', 765, 622),
(6, '帝国学園', 'Royal Academy', 'Royal Academy', 748, 618),
(7, '戦国伊賀島', 'Shuriken Junior High', 'Instituto Shuriken', 764, 623),
(8, '千羽山', 'Farm Junior High', 'Instituto Farm', 766, 624),
(9, '木戸川清修', 'Kirkwood Junior High', 'Instituto Kirkwood', 767, 625),
(10, '世宇子', 'Zeus Junior High', 'Instituto Zeus', 773, 626),
/*全国チーム*/
(11, '白恋', 'Alpine', 'Alpino', 737, 635),
(12, '漫遊寺', 'Cloister Divinity', 'Claustro Sagrado', 750, 636),
(13, '真・帝国学園', 'Royal Academy Redux', 'Royal Academy Redux', 748, 637),
(14, '大阪ギャルズCCC', 'Triple C', 'CCC de Osaka', 737, 641),
(15, '陽花戸', 'Fauxshore', 'Fauxshore', 751, 638),
(16, '大海原', 'Mary Times', 'Mary Times', 737, 639),
/*エイリア学園チーム*/
(17, 'ジェミニストーム', 'Gemini Storm', 'Tormenta de Géminis', 753, 631),
(18, 'イプシロン', 'Epsilon', 'Épsilon', 776, 632),
(19, 'イプシロン改', 'Advanced Epsilon', 'Épsilon Plus', 776, 632),
(20, 'ザ・ジェネシス', 'Genesis', 'Génesis', 754, 633),
(21, '警備マシンズ', 'Robot Guards', 'Robots Guardias', 737, 642),
(22, 'ダークエンペラーズ', 'Dark Emperors', 'Emperadores Oscuros', 739, 640),
(23, 'プロミネンス', 'Prominence', 'Prominence', 737, 643),
(24, 'ダイヤモンドダスト', 'Diamond Dust', 'Polvo de Diamantes', 737, 644),
(25, 'カオス', 'Chaos', 'Caos', 755, 645),
/*さまざまなチーム*/
(26, '稲妻KFC', 'Inazuma Kids FC', 'Inazuma Kids FC', 748, 627),
(27, '一番街サリーズ', 'Street Sally\'s', 'Sallys', 748, 630),
(28, 'SPフィクサーズ', 'Secret Service', 'Servicio Secreto', 737, 634),
(29, '樹海チーム', 'Forest Team', 'Mar de Árboles', 737, 689),
(30, '雷門OB', 'Veterans', 'Inazuma Eleven', 751, 629),
(31, 'ヤングイナズマイレブン', 'Young Inazuma', 'Jóvenes Inazuma', 751, null),
/*FFIチーム1*/
(32, 'ビッグウェイブス', 'Big Waves', 'Big Waves', 740, 647),
(33, 'デザートライオン', 'Desert Lions', 'Leones del Desierto', 741, 648),
(34, 'ファイアードラゴン', 'Fire Dragon', 'Dragones de Fuego', 770, 650),
(35, 'ネオジャパン', 'Neo National', 'Neo Japón', 780, 649),
(36, 'チームK', 'Team D', 'Equipo D', 756, 652),
(37, 'チーム・ガルシルド', 'Team Zoolan', 'Zoolan Team', 745, 656),
(38, 'ナイツオブクィーン', 'Queen\'s Knights', 'Knights of Queen', 742, 651),
(39, 'ジ・エンパイア', 'The Empire', 'Los Emperadores', 743, 653),
(40, 'ユニコーン', 'Unicorn', 'Unicorn', 744, 654),
(41, 'オルフェウス', 'Orpheus', 'Orfeo', 757, 655),
(42, 'ザ・キングダム', 'The Kingdom', 'Os Reis', 769, 657),
(43, 'リトルギガント', 'Little Gigant', 'Pequeños Gigantes', 746, 658),
/*FFIチーム2*/
(44, 'レッドマタドール', 'Red Matador', 'Los Rojos', 774, 660),
(45, 'ローズグリフォン', 'Rose Griffons', 'Grifos de la Rosa', 747, 659),
(46, 'ブロッケンボーグ', 'Brocken Brigade', 'Brocken Brigade', 763, 661),
(47, 'ザ・グレイトホーン', 'The Cape Crusaders', 'Caimanes del Cabo', 781, 662),
(48, '天空の使徒', 'Apostles from the Sky', 'Sky Team', 762, 663),
(49, '魔界軍団Z', 'Devil Army Z', 'Dark Team', 752, 664),
(50, 'ダークエンジェル', 'Dark Angels', 'Ángel Oscuro', 738, 665),
(51, 'オーガ', 'Team Ogre', 'Equipo Ogro', 758, 666),
/*バインダー非登録チーム*/
(52, '女子選抜チーム', 'The All-Girls Allstars', 'Estrellas Femeninas', 737, 646),
(53, 'アジア代表', 'Asia United', 'Ases Asiáticos', 749, null),
(54, 'ネオジャパン改', 'Advanced Neo National', 'Neo Japón Plus', 780, 649),
(55, 'ウラゼウス', 'Fallen Zeus', 'Ultra Zeus', 773, 626),
(56, 'アジア選抜', 'Asian Allstars', 'Astros Asiáticos', 749, 650),
(57, 'ヨーロッパ選抜', 'European Allstars', 'Astros Europeos', 749, 661),
(58, 'グループA選抜', 'Group A Allstars', 'Astros del Grupo A', 757, 655),
(59, '南米選抜', 'South American Allstars', 'Astros Sudamericanos', 749, 653),
(60, 'アメリカ大陸選抜', 'American Allstars', 'Astros Americanos', 769, 654),
(61, '稲妻KFC改', 'Advanced Kids', 'Inazuma Kids FC Plus', 748, 627),
(62, 'イナズマジャパン', 'Inazuma National', 'Inazuma Japón', 737, 646),
(63, 'ドッペルズ', 'The Doppelgangers', 'Los Impostores', 749, 695),
(64, 'ザ・ウッズ', 'The Woods', 'Guardabosques', 749, 678),
(65, 'ザ・マウンテンズ', 'The Mountains', 'Montañeros', 749, 684),
(66, 'ザ・キーパーズ', 'Canny Keepers', 'Porteros Imbatibles', 749, null),
(67, 'なりきり戦隊', 'Ultrasquad Omega', 'Ultrapatrulla Omega', 749, null),
(68, '南米代表', 'South America United', 'Ases Sudamericanos', 749, 657),
(69, 'ヨーロッパ代表', 'Europe United', 'Ases Europeos', 749, 655),
(70, 'グループB選抜', 'Group B Selection', 'Astros del Grupo B', 769, 658),
(71, 'アフリカ代表', 'Africa United', 'Ases Africanos', 746, 662),
(72, '世界代表', 'International United', 'Ases Internacionales', 748, 704),
(73, 'ザ・フォワーズ', 'Flying Forwards', 'Delanteros Relámpagos', 749, null),
(74, 'スーパー大阪CCC', 'Super Triple C', 'Súper Triple C', 751, 641),
(75, 'チーム・カノン', 'Team Canon', 'Equipo Canon', 748, 705),
(76, 'タカビーズ', 'The Ice Queens', 'Reinas del Hielo', 749, 693),
(77, 'アダルトチーム', 'Grown-Ups', 'Equipo de Adultos', 761, 634),
(78, 'イナズマタウンズ', 'Inazuma Town', 'Ciudad Inazuma', 737, 671),
(79, 'アンダー12', 'Under Twelves', 'Los Alevines', 737, 696),
(80, 'ザ・ウインディーズ', 'The Windies', 'Airosos', 749, 688),
(81, 'ザ・ミッズ', 'Mercurial Midfielders', 'Medios Sorprendentes', 749, 661),
(82, 'ゾディアックス', 'The Blastrologers', 'Astros del Firmamento', 749, 669),
(83, 'ネオ帝国', 'Neo Royal', 'Neo Royal Academy', 748, 637),
(84, 'エイリアA', 'Alius A', 'Alius A', 754, 633),
(85, 'エイリアB', 'Alius B', 'Alius B', 776, 633),
(86, '神と宇宙', 'Gods and Aliens', 'Divinidades y Alienígenas', 773, 685),
(87, 'キャッピキャピＡ', 'Cutesy A', 'Chavalillas A', 737, 681),
(88, 'リトルチーム', 'Little Team', 'Chiquis', 760, 693),
(89, 'スーパーアニマルズ', 'The Zoo Keepers', 'Los Superadorables', 749, null),
(90, 'FF地区選抜Ｂ', 'FF Regional Pick B', 'Fase Previa FF B', 759, 707),
(91, 'FF全国選抜Ｂ', 'FF National Pick B', 'Fase Nacional FF B', 773, 695),
(92, '全国チーム選抜Ｂ', 'National Team B', 'Selección Nacional B', 778, 704),
(93, 'チーム東日本', 'E. Japan Orient', 'Japón Este', 749, 711),
(94, '日本代表候補B', 'FFI Trials Team B', 'Pruebas de Selección - Equipo B', 749, 646),
(95, 'ファースト雷門', 'Raimon I', 'Raimon 1', 737, 617),
(96, 'リアル・エイリア', 'Real Alius', 'Atlético Alius', 754, 633),
(97, '影山オールスター', 'Dark\'s All Stars', 'Ray Dark All Stars', 748, 618),
(98, 'アナザーカオス', 'Chaos Returns', 'Nuevo Caos', 737, 645),
(99, 'ピストンベリーズ', 'Piston Berryz', 'Dorremifagol', 749, 702),
(100, '十二天王', 'The Gangs of Four', 'Los Cuatro Magníficos', 770, 713),
(101, 'ザ・カード', 'The Card', 'Tarjeteros', 749, 640),
(102, 'チャンピオンズ', 'Champions', 'Los Campeones', 777, 705),
(103, 'イナズマ’10', 'Inazuma 10', 'Ases del Inazuma 3', 749, 671),
(104, '世界選抜', 'International Allstars', 'Selección Mundial', 749, 658),
/*rank1*/
(105, 'Ｏ・Ｔ・Ａ・Ｋ・Ｕ', 'Herds of Nerds', 'Horda de Frikis', 765, 697),
(106, '元祖･野球部', 'Baseball All Stars', 'Los Chicos del Bate', 749, 694),
(107, 'スピードスター', 'The Motor Toters', 'Fundidores del Asfalto', 749, 714),
(108, 'FF地区選抜Ａ', 'FF Regional Pick A', 'Fase Previa FF A', 759, 707),
/*rank2*/
(109, 'スーパー秋葉名戸', 'Super Otaku', 'Súper Otaku', 765, 681),
(110, 'オールド木戸川', 'Old Kirkwood', 'Antiguo Kirkwood', 767, 625),
(111, 'ウラ雷門Ａ', 'Raimon Subs A', 'Ultra Raimon A', 737, 617),
(112, 'チーム西日本', 'W. Japan Wednesday', 'Japón Oeste', 749, 638),
(113, 'ベンチーズ1', 'Benchers 1', 'Chupabanquillos 1', 775, 667),
(114, 'ベンチーズ2', 'Benchers 2', 'Chupabanquillos 2', 765, 667),
(115, 'ベンチーズ3', 'Benchers 3', 'Chupabanquillos 3', 778, 667),
/*rank3*/
(116, '〇メガネ〇Ｂ', 'Glasses B', 'Gafitas B', 761, 706),
(117, 'ベンチーズ4', 'Benchers 4', 'Chupabanquillos 4', 737, 667),
(118, 'ベンチーズ5', 'Benchers 5', 'Chupabanquillos 5', 737, 667),
(119, 'ベンチーズ6', 'Benchers 6', 'Chupabanquillos 6', 737, 667),
(120, '◇ＮＩＮＪＡ◇', 'The Ninja Infringers', 'Ninjas a Gogó', 764, 623),
(121, 'セカンド雷門', 'Raimon II', 'Raimon II', 777, 617),
(122, '表と裏の王者Ａ', 'Front And Back Kings A', 'Royal Claustro A', 778, 703),
(123, '留学チーム', 'Foreign Students', 'Alumnos de Intercambio', 765, 712),
/*rank4*/
/*rank5*/
(124, '〇メガネ〇Ａ', 'Glasses A', 'Gafitas A', 761, 706),
(125, 'キャッピキャピＢ', 'Cutesy B', 'Chavalillas B', 737, 681),
(126, 'Ｍ･Ｏ･Ｅ', 'The Fanboy Favourites', 'Mangapichichis', 737, 681),
(127, 'マスクマンＡ', 'Masked Men A', 'Enmascarados A', 737, 697),
(128, 'ピエロチーム', 'The Clown Princes', 'Los Payasetes', 748, 697),
(129, 'タイニーガール', 'The Munchkins', 'Las Peques', 737, 693),
(130, 'スキンヘッズ', 'The Baldboys', 'Los Cabezahuevo', 767, 636),
(131, '中国キッカーズ', 'The Zing Dynasty', 'Estrellas de China', 749, 673),
(132, 'ヘッドプロテクツ', 'The Hard Headers', 'Los Cara Oculta', 761, 651),
(133, 'ラストイナズマ', 'Allstar Supernova', 'El Equipo Definitivo', 768, 671),
/*rank6*/
(134, 'スペースボーイズ', 'The Space Cadets', 'Cadetes Espaciales', 753, 631),
(135, 'ダミーエンペラーズ', 'The Dork Emperors', 'Memos Imperiales', 739, 640),
(136, 'ガイア', 'Gaia', 'Gaia', 775, 633),
(137, 'クリアーゴ', 'The Completionists', 'Equipo de Ensueño', 737, 709),
/*rank7*/
(138, 'FF全国選抜Ａ', 'FF National Pick A', 'Fase Nacional FF A', 764, 695),
(139, 'フドウヘッズ', 'The Stonewall Stylers', 'Los Calebmaníacos', 748, 685),
(140, 'エル・マッチョス', 'Brawn to Be Wild', 'Los Supermachos', 749, 677),
(141, '絶･世路死苦', 'The Wrong Crowd', 'Los Chungoleadores', 749, 678),
(142, 'キュート★スターズ', 'The Cutie-Pies', 'Las Guapetonas', 737, null),
(143, 'マスカレード', 'The Taskmaskers', 'Enmascarados Osados', 760, 675),
/*rank8*/
(144, 'モンスターズ', 'The Ghoul Hangers', 'Los Goles Fantasma', 765, 685),
(145, 'セレブリティーズ', 'La Crème de la Crème', 'Los Caviar', 747, 675),
(146, 'デモンフェイセズ', 'The Ugly Muggers', 'Los Preciosos', 758, 666),
(147, 'ザ･ビッグ', 'The Gentle Giants', 'Gigantes Bondadosos', 764, 672),
(148, 'ライモンアール', 'Côtes du Raimon', 'Raimon Costaleño', 746, 617),
/*rank9*/
(149, 'ザ･ディフェンズ', 'Doughty Defenders', 'Defensas Adamantinos', 749, 711),
(150, 'ファンタジース', 'The Fantasistas', 'Criaturas Legendarias', 752, 700),
(151, 'ハリケーンズ', 'The Belters', 'Las Voces de Oro', 777, 670),
(152, 'アナザーカラーズ', 'The Kaleidoscopes', 'Los Caleidoscopios', 737, 692),
(153, 'ファイアボーイズ', 'Balls of Fire', 'Balones Ardientes', 772, 707),
(154, 'ウォーターボーイズ', 'Liquid Football', 'Fútbol Líquido', 759, 688),
(155, 'イナズマレジェンド', 'The Absolute Legends', 'Leyendas de Antaño', 773, 698),
/*rank10*/
(156, 'ＬＥＶＥＬ—ＧＯ', 'Level Flyve', 'Level Flyve', 771, 649),
(157, 'イナズマ’08', 'Inazuma 08', 'Ases de Inazuma', 737, 680),
(158, '円堂レッズ', 'The Evans Eleven', 'Los Once de Mark', 768, null),
(159, 'クールガイズ', 'The Cool Customers', 'Los Guays', 749,693),
(160, 'ネオ雷門', 'Neo Raimon', 'Neo Raimon', 768, 705),
/*rank11*/
(161, '真･世界選抜', 'True International Allstars', 'Selección Mundial Redux', 769, 704),
(162, 'イナズマ’09', 'Inazuma 09', 'Ases del Inazuma 2', 737, 680),
(163, '鬼道ホワイツ', 'The Sharp Enders', 'La Panda de Jude', 778, null),
/*rank12*/
(164, 'チームマサト', 'Team Syon', 'Equipo Blaze', 767, 705),
/*rank13*/
(165, 'キーパースターズ', 'Solely Goalies', 'Porteros Delanteros', 775, 702),
(166, 'イケメンスパークス', 'The Bolting Beaus', 'Galanes Electrizantes', 742, 655),
(167, 'おいろけボンバーズ', 'The Bombshells', 'Chicas Explosivas', 772, 641),
(168, 'イカサマイレブン', 'The I\'maloser Eleven', 'Calamidad Eleven', 756, 706),
(169, 'バッドボーイズ', 'The Foul Players', 'Los Malcarados', 779, 677),
(170, 'スキルスターズ', 'The Tiki-Taka Troupe', 'Maestros del Tiki-Taka', 778, 669),
(171, 'ジ・エレメンツ', 'The Elementalists', 'Los Elementalistas', 769, 695),
(172, 'ザ・ブロス', 'The Dribbling Sibling', 'Hermanos del Regate', 767, 625),
(173, 'ＰＥＮＧＵＩＮ', 'The Penguin Emperors', 'Pingüinos Emperadores', 748, 703),
(174, 'チャンプ２０１０', 'The 2010 Champs', 'Campeones de 2010', 774, 660),
/*rank14*/
(175, '全国チーム選抜Ａ', 'National Team A', 'Selección Nacional A', 772, 704),
(176, 'リレーションズ', 'Keep it in the Family', 'Chicharros en Familia', 765, 705),
(177, 'スペシャルズ', 'The Specialists', 'Los Especialistas', 772, 634),
(178, 'ザ･サプライズ', 'The Dark Horses', 'Caja de Sorpresas', 748, 664),
/*rank15*/
(179, '真･パイレーツ', 'Rip Curlers Redux', 'Los Surfieras Redux', 749, 685),
/*rank16*/
(180, 'ブリザードボンバー', 'Blizzard Bomber', 'Ventisca Explosiva', 766, 690),
(181, 'ダークエンジェル２', 'Dark Angel 2', 'Ángel Oscuro 2', 738, 665),
(182, 'ゴッドエンジェル', 'The God Squad', 'Equipo Celestial', 760, 663),
(183, 'カオスエンジェルス', 'Chaos Angels', 'Ángeles del Caos', 738, 645),
(184, 'ファイアスパーク', 'The Firestorm Bolts', 'Rayo de Fuego', 765, 691),
(185, 'リアル・イナズマ', 'The Real Inazuma', 'Mega Inazuma Eleven', 779, 646),
/*misc*/
(186, 'あやしいやつら', 'Strange Guys', 'Sospechosos', 777, 712),
(187, 'ザ・ファイアーズ', 'The Fires', 'Ardientes', 749, 707);

source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_team_player.sql

/*
player_is_part_of_team
player_plays_during_story_team
*/

insert into tactic_executed_by_team (
    item_tactic_id,
    team_id
) values
(719, 7), 
(716, 9), 
(717, 10),
(735, 17),
(735, 18),
(735, 19),
(735, 20),
(735, 22),
(720, 23),
(735, 23),
(727, 24),
(735, 24),
(735, 25),
(731, 30),
(731, 31),
(726, 32),
(729, 34),
(719, 35),
(732, 35),
(722, 37),
(727, 38),
(720, 38),
(728, 39),
(721, 40),
(730, 41),
(723, 42),
(731, 43),
(724, 43),
(723, 44),
(724, 44),
(724, 45),
(721, 45),
(731, 46),
(729, 47),
(733, 48),
(734, 49),
(734, 51),
(733, 51),
(729, 53),
(724, 53),
(732, 54),
(717, 55),
(736, 55),
(726, 56),
(729, 56),
(727, 58),
(724, 58),
(716, 58),
(728, 59),
(730, 59),
(721, 60),
(723, 63),
(730, 64),
(728, 65),
(724, 65),
(731, 66),
(720, 67),
(728, 68),
(730, 68),
(723, 69),
(723, 70),
(716, 72),
(716, 75),
(717, 76),
(726, 77),
(716, 78),
(735, 80),
(726, 81),
(722, 83),
(735, 84),
(735, 85),
(717, 86),
(733, 86),
(735, 88),
(728, 89),
(718, 89),
(728, 90),
(730, 91),
(725, 92),
(720, 93),
(716, 95),
(735, 96),
(733, 96),
(722, 97),
(733, 98),
(716, 100), 
(727, 101), 
(726, 101), 
(720, 102), 
(716, 103), 
(721, 104), 
(735, 105), 
(736, 105), 
(731, 106), 
(735, 107), 
(732, 108), 
(731, 109), 
(718, 110), 
(717, 111), 
(724, 116), 
(724, 120), 
(719, 120), 
(718, 122), 
(721, 123), 
(726, 126), 
(722, 126), 
(732, 128), 
(724, 131), 
(732, 132), 
(720, 132), 
(734, 134), 
(726, 135), 
(716, 135), 
(734, 137), 
(719, 138), 
(722, 139), 
(720, 140), 
(732, 142), 
(717, 143), 
(724, 144), 
(732, 144), 
(727, 145), 
(717, 145), 
(728, 147), 
(719, 147), 
(736, 147), 
(730, 149), 
(727, 150), 
(722, 150), 
(723, 151), 
(729, 151), 
(718, 153), 
(729, 153), 
(717, 154), 
(726, 155), 
(716, 155), 
(719, 156), 
(727, 159), 
(722, 159), 
(735, 162), 
(728, 163), 
(730, 163), 
(718, 164), 
(730, 165), 
(717, 166), 
(722, 166), 
(731, 167), 
(716, 167), 
(732, 169), 
(736, 169), 
(724, 170), 
(726, 170), 
(730, 170), 
(727, 171), 
(722, 171), 
(724, 172), 
(718, 172), 
(722, 173), 
(718, 175), 
(735, 177), 
(727, 178), 
(723, 178), 
(726, 178), 
(717, 179), 
(734, 180), 
(721, 180), 
(734, 181), 
(733, 181), 
(724, 182), 
(733, 182), 
(736, 182), 
(734, 183), 
(729, 184), 
(733, 184), 
(723, 185), 
(729, 185),
(736, 186),
(724, 187),
(729, 187);

insert into extra_battle_route (
    extra_battle_route_id,
    extra_battle_route_name_ja,
    extra_battle_route_name_en,
    extra_battle_route_name_es,
    npc_id
) values
(1, '火来校長のエクストラ対戦ルート', 'Mr Firewill\'s competition route', 'Cadena extra de partidos del Sr. Firewill', 1),
(2, 'エキシビション対戦ルート', 'Exhibition route', 'Cadena de amistosos', 2),
(3, 'ナゾのエクストラ対戦ルート', 'Secret competition route', 'Cadena secreta de partidos', 3),
(4, '瞳子の超次元トーナメント ', 'Lina\'s hyperdimensional tournament', 'Torneo especial de Lina', 4),
(5, '総一郎の超次元トーナメント -', 'Sonny\'s hyperdimensional tournament', 'Torneo especial de Sonny', 5),
(6, 'ダイスケの超次元トーナメント', 'David\'s hyperdimensional tournament', 'Torneo especial de David Evans', 6),
(7, 'ドリーム超次元トーナメント', 'Dream hyperdimensional tournament', 'Torneo especial mágico', 7),
(8, '鬼瓦刑事の超次元トーナメント', 'Detective Smith\'s hyperdimensional tournament', 'Torneo especial del detective Smith', 8),
(9, '夕香の超次元トーナメント', 'Jilia\'s hyperdimensional tournament', 'Torneo especial de Julia Blaze', 9),
(10, 'ルシェの超次元トーナメント', 'Lizzy\'s hyperdimensional tournament', 'Torneo especial de Lizzy', 10);

/*route_path_order 3 中 1 上 2 下*/
insert into route_path (
    route_path_id,
    route_path_order,
    extra_battle_route_id,
    reward_n,
    reward_s
) values
(1, 3, 1, 572, 560),
(2, 1, 1, 729, 561),
(3, 2, 1, 723, 731),
(4, 1, 2, 177, 360),
(5, 2, 2, 573, 366),
(6, 1, 3, 361, 373),
(7, 2, 3, 350, 94),
(8, 1, 4, 367, 313),
(9, 2, 4, 375, 17),
(10, 1, 5, 720, 137),
(11, 2, 5, 368, 312),
(12, 1, 6, 356, 364),
(13, 2, 6, 369, 362),
(14, 1, 7, 738, 733),
(15, 2, 7, 314, 792),
(16, 1, 8, 562, 563),
(17, 2, 8, 564, 565),
(18, 1, 9, 124, 607),
(19, 2, 9, 374, 734),
(20, 1, 10, 371, 333);

insert into practice_game_condition (
    practice_game_condition_id,
    practice_game_condition_desc_ja,
    practice_game_condition_desc_en,
    practice_game_condition_desc_es
) values
(1, 'とにかく勝て!', 'Just win, it\'s that simple!', '¡Gana y ya está!'),
(2, '風属性のキャラで勝て!', 'Win with a Wind team!', '¡Gana con un equipo de Aire!'),
(3, '林属性のキャラで勝て!', 'Win with a Wood team!', '¡Gana con un equipo de Bosque!'),
(4, '火属性のキャラで勝て!', 'Win with a Fire team!', '¡Gana con un equipo de Fuego!'),
(5, '山属性のキャラで勝て!', 'Win with an Earth team!', '¡Gana con un equipo de Montaña!'),
(6, 'シュート技をもたないキャラで勝て!', 'Win with a team that doesn\'t possess any shooting special moves!', '¡Gana con jugadores sin supertécnicas de tiro!'),
(7, 'GK技をもたないキャラで勝て!', 'Win with a team that doesn\'t possess any goalkeeping special moves!', '¡Gana con jugadores sin supertécnicas de portero!'),
(8, '男の子のキャラで勝て!', 'Win with a team composed entirely of boys!', '¡Gana con un equipo formado por chicos!'),
(9, '女の子のキャラで勝て!', 'Win with a team composed entirely of girls!', '¡Gana con un equipo formado por chicas!');

insert into practice_game (
    practice_game_id,
    practice_game_order,
    route_path_id,
    team_id,
    practice_game_condition_id
) values
/*1-center*/
(1, 1, 1, 52, 1),
(2, 2, 1, 35, 1),
(3, 3, 1, 54, 1),
/*1-top*/
(4, 1, 2, 32, 1),
(5, 2, 2, 33, 1),
(6, 3, 2, 34, 1),
(7, 4, 2, 53, 1),
/*1-bottom*/
(8, 1, 3, 38, 1),
(9, 2, 3, 39, 1),
(10, 3, 3, 40, 1),
(11, 4, 3, 41, 1),
(12, 5, 3, 42, 1),
(13, 6, 3, 43, 1),
(14, 7, 3, 37, 1),
/*2-top*/
(15, 1, 4, 8, 1),
(16, 2, 4, 5, 1),
(17, 3, 4, 7, 1),
(18, 4, 4, 1, 1),
(19, 5, 4, 16, 1),
(20, 6, 4, 3, 1),
/*2-bottom*/
(21, 1, 5, 4, 1),
(22, 2, 5, 11, 1),
(23, 3, 5, 2, 1),
(24, 4, 5, 12, 1),
(25, 5, 5, 6, 1),
(26, 6, 5, 15, 1),
(27, 7, 5, 9, 1),
/*3-top*/
(28, 1, 6, 36, 1),
(29, 2, 6, 13, 1),
(30, 3, 6, 10, 1),
(31, 4, 6, 55, 1),
/*3-bottom*/
(32, 1, 7, 17, 1),
(33, 2, 7, 18, 1),
(34, 3, 7, 19, 1),
(35, 4, 7, 20, 1),
(36, 5, 7, 25, 1),
/*4-top*/
(37, 1, 8, 136, 1),
(38, 2, 8, 21, 1),
(39, 3, 8, 84, 1),
(40, 4, 8, 85, 1),
(41, 5, 8, 182, 1),
(42, 6, 8, 29, 1),
(43, 7, 8, 87, 8),
(44, 8, 8, 147, 3),
(45, 9, 8, 89, 7),
/*4-bottom*/
(46, 1, 9, 90, 1),
(47, 2, 9, 91, 1),
(48, 3, 9, 28, 1),
(49, 4, 9, 92, 1),
(50, 5, 9, 152, 1),
(51, 6, 9, 74, 1),
(52, 7, 9, 162, 1),
(53, 8, 9, 163, 1),
(54, 9, 9, 95, 1),
/*5-top*/
(55, 1, 10, 68, 1),
(56, 2, 10, 45, 1),
(57, 3, 10, 44, 1),
(58, 4, 10, 69, 1),
(59, 5, 10, 70, 1),
(60, 6, 10, 71, 1),
(61, 7, 10, 72, 1),
/*5-bottom*/
(62, 1, 11, 73, 2),
(63, 2, 11, 129, 6),
(64, 3, 11, 184, 1),
(65, 4, 11, 76, 8),
(66, 5, 11, 126, 1),
(67, 6, 11, 148, 1),
(68, 7, 11, 145, 6),
(69, 8, 11, 80, 5),
(70, 9, 11, 81, 5),
(71, 10, 11, 82, 1),
/*6-top*/
(72, 1, 12, 56, 1),
(73, 2, 12, 46, 1),
(74, 3, 12, 57, 1),
(75, 4, 12, 58, 1),
(76, 5, 12, 47, 1),
(77, 6, 12, 59, 1),
(78, 7, 12, 60, 1),
/*6-bottom*/
(79, 1, 13, 135, 7),
(80, 2, 13, 122, 1),
(81, 3, 13, 63, 5),
(82, 4, 13, 64, 2),
(83, 5, 13, 65, 4),
(84, 6, 13, 66, 6),
(85, 7, 13, 67, 8),
(86, 8, 13, 31, 1),
/*7-top*/
(87, 1, 14, 96, 1),
(88, 2, 14, 151, 1),
(89, 3, 14, 181, 1),
(90, 4, 14, 102, 1),
(91, 5, 14, 183, 8),
/*7-bottom*/
(92, 1, 15, 22, 1),
(93, 2, 15, 99, 1),
(94, 3, 15, 100, 1),
(95, 4, 15, 101, 1),
(96, 5, 15, 103, 1),
(97, 6, 15, 161, 1),
/*8-top*/
(98, 1, 16, 111, 1),
(99, 2, 16, 61, 1),
(100, 3, 16, 108, 1),
(101, 4, 16, 138, 1),
(102, 5, 16, 27, 1),
(103, 6, 16, 175, 1),
(104, 7, 16, 156, 1),
(105, 8, 16, 157, 1),
(106, 9, 16, 158, 1),
(107, 10, 16, 30, 1),
/*8-bottom*/
(108, 1, 17, 113, 6),
(109, 2, 17, 114, 6),
(110, 3, 17, 115, 6),
(111, 4, 17, 117, 6),
(112, 5, 17, 124, 9),
(113, 6, 17, 87, 8),
(114, 7, 17, 144, 7),
(115, 8, 17, 134, 9),
(116, 9, 17, 146, 5),
/*9-top*/
(117, 1, 18, 105, 1),
(118, 2, 18, 180, 1),
(119, 3, 18, 150, 1),
(120, 4, 18, 187, 3),
(121, 5, 18, 159, 1),
(122, 6, 18, 107, 8),
(123, 7, 18, 137, 1),
(124, 8, 18, 176, 4),
(125, 9, 18, 149, 2),
(126, 10, 18, 128, 4),
(127, 11, 18, 179, 1),
/*9-bottom*/
(128, 1, 19, 118, 7),
(129, 2, 19, 119, 7),
(130, 3, 19, 116, 9),
(131, 4, 19, 143, 7),
(132, 5, 19, 139, 3),
(133, 6, 19, 142, 8),
(134, 7, 19, 141, 8),
(135, 8, 19, 140, 9),
(136, 9, 19, 173, 1),
/*10-top*/
(137, 1, 20, 177, 1),
(138, 2, 20, 170, 1),
(139, 3, 20, 166, 9),
(140, 4, 20, 154, 1),
(141, 5, 20, 165, 7),
(142, 6, 20, 155, 1),
(143, 7, 20, 167, 8),
(144, 8, 20, 174, 1),
(145, 9, 20, 160, 1),
(146, 10, 20, 104, 1);

insert into practice_game_initiated_by_npc (
    practice_game_id,
    npc_id) values
(15, 11),
(16, 12),
(17, 13),
(18, 14),
(19, 15),
(20, 16),
(21, 17),
(22, 18),
(23, 19),
(24, 20),
(25, 21),
(26, 22),
(27, 23),
(87, 24),
(88, 25),
(89, 26),
(90, 27),
(91, 28),
(92, 29),
(93, 30),
(94, 31),
(95, 32),
(96, 33),
(97, 34);

insert into item_vscard (
    item_vscard_id,
    practice_game_id
) values
(579 ,3),
(580, 7),

(589, 29),
(593, 30),
(592, 31),
(584, 32),
(582, 33),
(583, 34),
(585, 35),
(581, 36),

(591, 92),
(588, 93),
(590, 95),
(586, 96),
(587, 97);

/*
practice_game_can_drop_item
*/
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_route_drop.sql

/*tournament-page*/
insert into tournament_rank (
    tournament_rank_id,
    tournament_rank_lv_range
) values
(1, '01-15'),
(2, '16-25'),
(3, '26-35'),
(4, '36-45'),
(5, '46-55'),
(6, '56-65'),
(7, '66-75'),
(8, '76-80'),
(9, '81-85'),
(10, '86-90'),
(11, '91-93'),
(12, '94-96'),
(13, '97-99'),
(14, '97-99'),
(15, '97-99'),
(16, '97-99');

insert into tournament_name (
    tournament_name_id,
    tournament_name_ja,
    tournament_name_en,
    tournament_name_es,
    tournament_rank_id
) values
/*rank1*/
(1, 'ライモンタウンカップ', 'Raimon Town Cup', 'Copa Ciudad Inazuma', 1),
(2, 'ファイアトルネードカップ', 'Fire Tornado Cup', 'Copa Tornado de Fuego', 1),
(3, 'ゴッドハンドカップ', 'God Hand Cup', 'Copa Mano Celestial', 1),
/*rank2*/
(4, 'オカルトカップ', 'Occult Cup', 'Copa Occult', 2),
(5, 'トライアングルカップ', 'Triangle Cup', 'Copa Triángulo Z', 2),
(6, 'デスゾーンカップ', 'Death Zone Cup', 'Copa Triángulo Letal', 2),
/*rank3*/
(7, 'エターナルカップ', 'Eternal Cup', 'Copa Ventisca Eterna', 3),
(8, 'ツナミブーストカップ', 'Tsunami Boost Cup', 'Copa Remate Tsunami', 3),
(9, 'ムゲンカップ', 'Mugen Cup', 'Copa Manos Infintas', 3),
/*rank4*/
(10, 'ゴッドノウズカップ', 'God Knows Cup', 'Copa Sabiduría Divina', 4),
(11, 'ザ・タワーカップ', 'The Tower Cup', 'Copa Torre Inexpugnable', 4),
(12, 'デスゾーン２カップ', 'Death Zone 2 Cup', 'Copa Triángulo Letal 2', 4),
/*rank5*/
(13, 'ファイアカップ', 'Fire Cup', 'Copa Fuego', 5),
(14, 'ブリザードカップ', 'Blizzard Cup', 'Copa Ventisca', 5),
(15, 'ＦＦジャパンカップ', 'FF Japan Cup', 'Copa FF Japón', 5),
/*rank6*/		
(16, 'プロミネンスカップ', 'Prominence Cup', 'Copa Prominence', 6),
(17, 'ダイヤモンドカップ', 'Diamond Cup', 'Copa Polvo de Diamantes', 6),
(18, 'ガイアカップ', 'Gaia Cup', 'Copa Gaia', 6),
/*rank7*/
(19, 'ドラゴンカップ', 'Dragon Cup', 'Copa Dragones de Fuego', 7),
(20, 'デザートカップ', 'Desert Cup', 'Copa Leones del Desierto', 7),
(21, 'オーシャンカップ', 'Ocean Cup', 'Copa Big Waves', 7),
/*rank8*/
(22, 'エクスカリバーカップ', 'Excalibur Cup', 'Copa Knights of Queen', 8),
(23, 'オーディーンカップ', 'Gran Fenrir Cup', 'Copa Unicorn', 8),
(24, 'グランフェンリルカップ', 'Odin Cup', 'Copa Orfeo', 8),
/*rank9*/		
(25, 'ローズスプラッシュカップ', 'Rose Splash Cup', 'Copa Grifos de la Rosa', 9),
(26, 'ブロッケンカップ', 'Brocken Cup', 'Copa Brocken Brigade', 9),
(27, 'マタドールカップ', 'Matador Cup', 'Copa Los Rojos', 9),
/*rank10*/	
(28, 'スパークカップ', 'Spark Cup', 'Copa Rayo Celeste', 10),
(29, 'ボンバーカップ', 'Bomber Cup', 'Copa Fuego Explosivo', 10),
(30, 'ハリケーンカップ', 'Hurricane Cup', 'Copa La Amenaza del Ogro', 10),
/*rank11*/
(31, 'ジェットストリームカップ', 'Jet Stream Cup', 'Copa Liocott', 11),
(32, 'ビッグバンカップ', 'Big Bang Cup', 'Copa Monumental', 11),
(33, 'ゴッドブレイクカップ', 'God Break Cup', 'Copa Caimanes del Cabo', 11),
/*rank12*/
(34, 'デスブレイクカップ', 'Death Break Cup', 'Copa Os Reis', 12),
(35, 'ハイボルテージカップ', 'High Voltage Cup', 'Copa Los Emperadores', 12),
(36, 'エレキトラップカップ', 'Electric Trap Cup', 'Copa Pequeños Gigantes', 12),
/*rank13*/
(37, 'ペンギンズカップ', 'Penguins Cup', 'Copa Pingüino Emperador', 13),
(38, 'チャンピオンカップ', 'Champion Cup', 'Copa Campeones', 13),
(39, 'パイレーツカップ', 'Pirates Cup', 'Copa Torneo Especial', 13),
/*rank14*/
(40, 'フェニックスカップ', 'Phoenix Cup', 'Copa Fénix', 14),
(41, 'ギャラクシーカップ', 'Galaxy Cup', 'Copa Tiro Galáctico', 14),
(42, 'ジ・アースカップ', 'The Earth Cup', 'Copa Tierra', 14),
/*rank15*/
(43, 'まおうカップ', 'Maou Cup', 'Copa Mano Diabólica', 15),
(44, 'タマシイカップ', 'Tamashii Cup', 'Copa Mano Espiritual', 15),
(45, 'オメガカップ', 'Omega Cup', 'Copa Mano Omega', 15),
/*rank16*/
(46, 'エンジェルカップ', 'Angel Cup', 'Copa Balón Angelical', 16),
(47, 'カオスカップ', 'Chaos Cup', 'Copa Caos', 16),
(48, 'オーガカップ', 'Ogre Cup', 'Copa Ogro', 16);

insert into tournament_rank_requires_player (
    tournament_rank_id,
    player_id
) values
/*rank14*/
(14, 220),
(14, 361),
(14, 1161),
(14, 501),
(14, 789),
(14, 327),
(14, 2076),
(14, 414),
(14, 585),
(14, 1650),
(14, 1662),
(14, 1704),
(14, 1751),
(14, 1974),
(14, 866),
(14, 673),
/*rank15*/
(15, 1867),
(15, 1893),
(15, 1938),
(15, 1988),
(15, 1765),
(15, 1265),
(15, 1784),
(15, 524),
(15, 1809),
(15, 849),
(15, 1837),
(15, 908),
(15, 1849),
(15, 1913),
/*rank16*/
(16, 242),
(16, 352),
(16, 2169),
(16, 2303),
(16, 1269),
(16, 1217),
(16, 1396 ),
(16, 2077),
(16, 2112),
(16, 2085),
(16, 2132),
(16, 2156),
(16, 2170),
(16, 2190),
(16, 2206),
(16, 1428);

source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_tournament_team.sql

source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_tournament_drop.sql


insert into ultimate_note_increases_free (
    item_ultimate_note_id,
    positi_id,
    attri_id
) values
(606, 3, 2),
(607, 1, 3),
(608, 2, 2),
(609, 3, 1),
(610, 2, 1),
(611, 1, 2),
(612, 1, 1),
(612, 4, 1),
(613, 3, 4),
(613, 4, 2),
(614, 3, 3),
(614, 4, 3),
(615, 2, 4),
(615, 4, 4),
(616, 2, 3),
(616, 1, 4);

/*
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
insert into daily (
    daily_id,
    player_id,
    views
) values
(1, 1, 0);

set global event_scheduler = on;
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/daily_event.sql
