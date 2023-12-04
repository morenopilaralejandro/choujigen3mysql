/*database choujigen3ogre*/

/*1-drop*/
drop table if exists store;
drop table if exists store_type;
drop table if exists building_floor;
drop table if exists building;
drop table if exists zone_level;
drop table if exists inner_zone;
drop table if exists outer_zone;
drop table if exists zone;
drop table if exists zone_type;
drop table if exists region;


/*2-create*/
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

create table outer_zone (
    outer_zone_id int not null,
    region_id int,
    constraint outer_zone_pk primary key (outer_zone_id),
    constraint outer_zone_fk_zone foreign key (outer_zone_id) 
        references zone(zone_id) on delete cascade,
    constraint outer_zone_fk_region foreign key (region_id) 
        references region(region_id) on delete cascade
);

create table inner_zone ( 
    inner_zone_id int not null,
    outer_zone_id int,
    constraint inner_zone_pk primary key (inner_zone_id),
    constraint inner_zone_fk_zone foreign key (inner_zone_id) 
        references zone(zone_id) on delete cascade,
    constraint inner_zone_fk_outer_zone foreign key (outer_zone_id) 
        references outer_zone(outer_zone_id) on delete cascade
);

create table zone_level ( 
    zone_level_id int not null,
    inner_zone_id int,
    constraint zone_level_pk primary key (zone_level_id),
    constraint zone_level_fk_zone foreign key (zone_level_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_level_fk_inner_zone foreign key (inner_zone_id) 
        references inner_zone(inner_zone_id) on delete cascade
);

create table building ( 
    building_id int not null,
    zone_level_id int,
    constraint building_pk primary key (building_id),
    constraint building_fk_zone foreign key (building_id) 
        references zone(zone_id) on delete cascade,
    constraint building_fk_zone_level foreign key (zone_level_id) 
        references zone_level(zone_level_id) on delete cascade
);

create table building_floor ( 
    building_floor_id int not null,
    building_id int,
    constraint building_floor_pk primary key (building_floor_id),
    constraint building_floor_fk_zone foreign key (building_floor_id) 
        references zone(zone_id) on delete cascade,
    constraint building_floor_fk_building foreign key (building_id) 
        references building(building_id) on delete cascade
);

create table store_type ( 
    store_type_id int not null auto_increment,
    store_type_name_ja varchar(32),
    store_type_name_en varchar(32),
    store_type_name_es varchar(32),
    constraint store_type_pk primary key (store_type_id)
);

create table store ( 
    store_id int not null auto_increment,
    store_type_id int,
    zone_id int,
    constraint store_pk primary key (store_id),
    constraint store_fk_store_type foreign key (store_type_id) 
        references store_type(store_type_id) on delete cascade,
    constraint store_fk_zone foreign key (zone_id) 
        references zone(zone_id) on delete cascade
);


/*3-insert*/
insert into region (
    region_id, 
    region_name_ja, 
    region_name_en, 
    region_name_es) 
values 
    (1, '日本', 'Japan', 'Japón'),
    (2, 'ライオコット島', 'Liocott Island', 'Isla Liocott')
    (3, '未来', 'Future', 'Futuro')
    (4, 'イナズマキャラバン', 'Inazuma Caravan', 'Caravana Inazuma');

insert into zone_type (
    zone_type_id,
    zone_type_name) 
values 
    (1, 'outer zone'),
    (2, 'inner zone'),
    (3, 'zone level'),
    (4, 'building'),
    (5, 'building_floor');

insert into zone (
    zone_id, 
    zone_name_ja, 
    zone_name_en, 
    zone_name_es, 
    zone_type_id) 
values
/*zone-outer_zone*/
    (1, '北東京', 'North Tokyo', 'Norte de Tokio', 1),
    (2, '南東京', 'South Tokyo', 'Sur de Tokio', 1),
    (3, '北海道', 'Hokkaido', 'Hokkaido', 1),
   tal (4, '奈良', 'Nara', 'Nara', 1),
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
    (24, 'マグニード山', 'Mt.Magnido', 'Monte Magnitud', 1),
    (25, '未来', 'Future', 'Futuro', 1),
    (26, 'イナズマキャラバン', 'Inazuma Caravan', 'Caravana Inazuma', 1);
/*zone-inner_zone*/
/*north-tokyo*/
    (27, '住宅街', 'Residential Area', 'Zona Residencial', 2),
    (28, '商店街', 'Shopping Street ', 'Barrio de Tiendas', 2),
    (29, '雷門中', 'Raimon Junior High', 'Instituto Raimon', 2),
    (30, '河川敷', 'Stream Bed', 'Rivera del Rio', 2),
    (31, '鉄塔', 'Steel Tower', 'Torre', 2),
    (32, '病院', 'Hospital', 'Hospital', 2),
    (33, '駅前', 'Station', 'Estación', 2),
    (34, '傘美野中', 'Umbrella Junior High', 'Instituto Umbrella', 2),
    (35, '帝国学園', 'Royal Academy', 'Royal Academy', 2),
    (36, '秘儀の丘', 'Arcane Hill', 'Cerro Arcano', 2),
/*south-tokyo*/
    (37, '東京大江戸国際空港', 'Tokyo International Airport', 'Aeropuerto de Tokio', 2),
    (38, 'サッカー協会', 'Football Association', 'Sede de la Asociación de Fútbol', 2),
    (39, 'フロンティアスタジアム', 'Frontier Stadium ', 'Estadio Fútbol Frontier', 2),
    (40, '虎ノ屋', 'Toramaru\'s restaurant', 'Casa Hobbes', 2),
/*hokkaido*/
    (41, '市街地', 'Urban Area', 'Ciudad', 2),
    (42, '大雪原', 'Heavy Snow Field', 'Pico del Norte', 2),
    (43, '白恋中', 'Alpine Junior High', 'Instituto Alpine', 2),
/*nara*/
    (44, '奈良市街地', 'Nara City Area', 'Ciudad', 2),
    (45, 'シカ公園', 'Deer Park', 'Parque Deerfield', 2),
/*osaka*/
    (46, '市街地 ', 'Urban Area', 'Ciudad', 2),
    (47, 'ナニワランド', 'Naniwaland ', 'Osakaland', 2),
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
    (57, '星の使徒研究所', 'Fuji Lab', 'Laboratirio M. de las Estrellas', 2),
/*entrance*/
    (5, 'asd', 'asd', 'asd', 2),
    (5, 'asd', 'asd', 'asd', 2),
    (5, 'asd', 'asd', 'asd', 2),
    (5, 'asd', 'asd', 'asd', 2),
    (5, 'asd', 'asd', 'asd', 2),



    (5, 'asd', 'asd', 'asd', 2),








/*japan-area*/
/*uk-area*/
/*sea-snake-island*/
/*argentina-area*/
/*wildcat-island*/
/*us-area*/
/*peacock-island*/
/*italy-area*/
/*condor-island*/
/*brazil-area*/
/*sea-turtle-island*/
/*cotarl-area*/
/*mount-magnitude*/
/*future*/


    (4, 'asd', 'asd', 'asd', 2),


/*
nara-deer-park
シカ公園市街北側 Deer Park City North Side 
シカ公園巨シカ像側 Deer Park Giant Deer Statue Side 
*/


insert into outer_zone (
    outer_zone_id, 
    region_id) values 
(1, 1), (2, 1), (3, 1), (4, 1), (5, 1), (6, 1), (7, 1), (8, 1), (9, 1), (10, 1), 
(11, 2), (12, 2), (13, 2), (14, 2), (15, 2), (16, 2), (17, 2), (18, 2), (19, 2), 
(20, 2), (21, 2), (22, 2), (23, 2), (24, 2), (25, 3), (26, 4);

insert into store_type (
    store_type_id, 
    store_type_name_ja, 
    store_type_name_en, 
    store_type_name_es) 
values
    (1, 'ごくらくマーケット', 'Market', 'Mercazuma'),
    (2, 'ペンギーゴ', 'Sport Shop', 'Balón Bazar'),
    (3, '秘宝堂', 'Tech Shop', 'Todotécnicas'),
    (4, '万屋', 'Salesman', 'Vendedor'),
    (5, '最強ショップ', 'Strongest shop', 'Supertienda'),
    (6, '真・最強ショップ', 'True Strongest shop', 'Supertienda Redux'),
    (7, '駄菓子屋', 'Sweet Shop', 'Tienda de Chuches');

/*4-select*/




