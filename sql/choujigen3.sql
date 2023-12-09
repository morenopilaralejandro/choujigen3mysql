/*database choujigen3ogre*/

/*1-drop*/
drop table if exists store;
drop table if exists store_type;
drop table if exists zone_building_floor;
drop table if exists zone_building;
drop table if exists zone_level;
drop table if exists zone_inner;
drop table if exists zone_outer;
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
    (24, 'マグニード山', 'Mt.Magnido', 'Monte Magnitud', 1),
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
    (40, '虎ノ屋', 'Toramaru\'s restaurant', 'Casa Hobbes', 2),
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
    (67, 'ウミヘビ港', 'Sea snake port', 'Puerto Hidra', 2),
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
    (82, 'イタリア街', 'Main Street', 'Calle Principal', 2),
    (83, '公園', 'Park', 'Parque', 2),
    (84, 'サッカー場', 'Football Court', 'Campo de Fútbol', 2),
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
    (145, '虎ノ屋周辺', 'Around Toramaru\'s Restaurant', 'Alrededores C.Hobbes', 3),
    (146, '虎ノ屋前', 'Toramaru\'s Restaurant Area', 'Casa Hobbes', 3),
        (147, '虎ノ屋', 'Toramaru\'s Restaurant', 'Casa Hobbes', 4),
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
    (157, '大阪市街地 商店街側', 'Osaka City Area Shopping Street Side', 'Barrio de Tiendas', 3),
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
    (181, 'asd', 'asd', 'Aeropuerto de Liocott', 3),
        (182, 'asd', 'asd', 'Aeropuerto de Liocott', 4),
/*entrance-central-park*/
    (183, 'asd', 'asd', 'Parque Central', 3),
        (184, 'asd', 'asd', 'Nuevo C.E. Recepción', 4),
/*entrance-titanic-stadium*/
    (185, 'asd', 'asd', 'Estadio Monumental', 3),
        (186, 'asd', 'asd', 'Estadio Monumental', 4),
            (187, 'asd', 'asd', 'Vestíbulo', 5),
            (188, 'asd', 'asd', 'Vestuario 1', 5),
            (189, 'asd', 'asd', 'Vestuario 2', 5),
            (190, 'asd', 'asd', 'Vestuario 3', 5),
            (191, 'asd', 'asd', 'Estadio Monumental', 5),
/*entrance-liocott-port*/
    (192, 'asd', 'asd', 'Puerto de Liocott', 3),
/*entrance-hospital*/
    (193, 'asd', 'asd', 'Hospital de Liocott', 3),
        (194, 'asd', 'asd', 'Hospital de Liocott', 4),
            (195, 'asd', 'asd', 'Hospital de Liocott', 5),
            (196, 'asd', 'asd', 'Hospital de Liocott', 5),
/*japan-area-shopping-street*/
    (197, 'asd', 'asd', 'Zona de Tiendas', 3),
        (198, 'asd', 'asd', 'Recepción C.E.', 4),
/*japan-area-hostel*/
    (199, 'asd', 'asd', 'Albergue', 3),
        (200, 'asd', 'asd', 'Albergue', 4),
            (201, 'asd', 'asd', 'PB', 5),
            (202, 'asd', 'asd', 'P1', 5),
/*uk-area-fountain-street*/
    (203, 'asd', 'asd', 'Calle de la Fuente', 3),
/*uk-area-empty-lot*/
    (204, 'asd', 'asd', 'Solar Vacío', 3),
/*sea-snake-island-sea-snake-port*/
    (205, 'asd', 'asd', 'Puerto Hidra', 3),
/*sea-snake-island-road-to-the-stadium*/
    (206, 'asd', 'asd', 'Camino del Estadio', 3),
/*sea-snake-island-sea-snake-stadium*/
    (207, 'asd', 'asd', 'Estadio Hidra - Entrada', 3),
        (208, 'asd', 'asd', 'Estadio Hidra', 4),
/*argentina-area-main-street*/
    (209, 'asd', 'asd', 'Calle Principal', 3),
/*argentina-area-statue-square*/
    (210, 'asd', 'asd', 'Plaza de la Estatua', 3),
/*argentina-area-y-intersection*/
    (211, 'asd', 'asd', 'Intersección en Y', 3),
/*wildcat-island-wildcat-port*/
    (212, 'asd', 'asd', 'Puerto Gato Montés', 3),
/*wildcat-island-road-to-the-stadium*/
    (213, 'asd', 'asd', 'Camino del Estadio', 3),
/*wildcat-island-wildcat-stadium*/
    (214, 'asd', 'asd', 'E. Gato Montés - Entrada', 3),
        (215, 'asd', 'asd', 'Estadio Gato Montés', 4),
/*us-area-urban-area*/
    (216, 'asd', 'asd', 'Ciudad', 3),
/*us-area-scrapping*/
    (217, 'asd', 'asd', 'Desguace', 3),
/*us-area-station*/
    (218, 'asd', 'asd', 'Estación', 3),
/*peacock-island-peacock-port*/
    (219, 'asd', 'asd', 'asd', 3),
/*peacock-island-road-to-the-stadium*/
    (220, 'asd', 'asd', 'Camino del Estadio', 3),
/*peacock-island-peacock-stadium*/
    (221, 'asd', 'asd', 'E. Pavo Real - Entrada', 3),
        (222, 'asd', 'asd', 'Estadio Pavo Real', 4),
/*italy-area-main-street*/
    (223, 'asd', 'asd', 'Calle Principal', 3),
/*italy-area-park*/
    (224, 'asd', 'asd', 'Parque', 3),
/*italy-area-football-court*/
    (225, 'asd', 'asd', 'Campo de Fútbol', 3),
/*condor-island-condor-port*/
    (226, 'asd', 'asd', 'Puerto Cóndor', 3),
/*condor-island-condor-stadium*/
    (227, 'asd', 'asd', 'Estadio Cóndor - Entrada', 3),
        (228, 'asd', 'asd', 'Estadio Cóndor', 4),
            (229, 'asd', 'asd', 'PB', 5),
            (230, 'asd', 'asd', 'P1', 5),
            (231, 'asd', 'asd', 'P2', 5),
            (232, 'asd', 'asd', 'P3', 5),
            (233, 'asd', 'asd', 'P4', 5),
            (234, 'asd', 'asd', 'P5', 5),
            (235, 'asd', 'asd', 'P6', 5),
            (236, 'asd', 'asd', 'Estadio Cóndor', 5),
/*brazil-area-main-street*/
    (237, 'asd', 'asd', 'Calle Principal', 3),
    (238, 'asd', 'asd', 'Mansión de Zoolan', 3),
/*brazil-area-downtown*/
    (239, 'asd', 'asd', 'Calle Lateral', 3),
/*brazil-area-back-alley*/
    (240, 'asd', 'asd', 'Callejón', 3),
/*sea-turtle-island-sea-turtle-port*/
    (241, 'asd', 'asd', 'Puerto Tortuga Marina', 3),
/*sea-turtle-island-road-to-the-stadium*/
    (242, 'asd', 'asd', 'Camino del Estadio', 3),
/*sea-turtle-island-sea-turtle-stadium*/
    (243, 'asd', 'asd', 'E. Tortuga M. - Entrada', 3),
        (244, 'asd', 'asd', 'Estadio Tortuga Marina', 4),
/*cotarl-area-urban-area*/
    (245, 'asd', 'asd', 'Ciudad', 3),
/*cotarl-area-square*/
    (246, 'asd', 'asd', 'Lugar de Reunión', 3),
/*mount-magnitude-entrance*/
    (247, 'asd', 'asd', 'Laberinto Monte Magnitud', 3),
    (248, 'asd', 'asd', 'Puerta Demoníaca', 3),
    (249, 'asd', 'asd', 'Jardín Celestial', 3),
    (250, 'asd', 'asd', 'Tierra Legendaria', 3),
/*future-future*/
    (251, 'asd', 'asd', 'El Futuro - Calle', 3),
    (252, 'asd', 'asd', 'El Futuro - Z. Residencial', 3),
        (253, 'asd', 'asd', 'Casa de Canon', 4),
    (254, 'asd', 'asd', 'El Futuro - Laboratorio', 3),
        (255, 'asd', 'asd', 'Laboratorio Prof. Killard', 4),
    (256, 'asd', 'asd', 'Túnel Subterráneo', 3),
    (257, 'asd', 'asd', 'Alacantarilla', 3),
    (258, 'asd', 'asd', 'E. Ogro - Entrada', 3),
        (259, 'asd', 'asd', 'Estadio del Ogro', 4);

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
(166, 54), (171, 55), (172, 56), (173, 56), (174, 56), (175, 57), (176, 57), 
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
(244, 243), (253, 252), (255, 254), (259, 258);

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

insert into store_type (
    store_type_id, 
    store_type_name_ja, 
    store_type_name_en, 
    store_type_name_es) values
    (1, 'ごくらくマーケット', 'Market', 'Mercazuma'),
    (2, 'ペンギーゴ', 'Sport Shop', 'Balón Bazar'),
    (3, '秘宝堂', 'Tech Shop', 'Todotécnicas'),
    (4, '万屋', 'Salesman', 'Vendedor'),
    (5, '最強ショップ', 'Strongest shop', 'Supertienda'),
    (6, '真・最強ショップ', 'True Strongest shop', 'Supertienda Redux'),
    (7, '駄菓子屋', 'Sweet Shop', 'Tienda de Chuches');

/*4-select*/
/*select-zone-level*/
SET @var_zone_level_id := 220;
select 
lvl.zone_level_id,
inn.zone_inner_id,
oute.zone_outer_id,
zlvl.zone_name_es,
zinn.zone_name_es,
zoute.zone_name_es

from zone_level lvl

join zone_inner inn 
on lvl.zone_inner_id = inn.zone_inner_id

join zone_outer oute 
on oute.zone_outer_id = inn.zone_outer_id

join zone zlvl
on zlvl.zone_id = lvl.zone_level_id

join zone zinn
on zinn.zone_id = inn.zone_inner_id

join zone zoute
on zoute.zone_id = oute.zone_outer_id

where lvl.zone_level_id = @var_zone_level_id\G

/*select-zone-building*/
SET @var_zone_building_id := 107;
select 
bld.zone_building_id,
lvl.zone_level_id,
inn.zone_inner_id,
oute.zone_outer_id,
zbld.zone_name_es,
zlvl.zone_name_es,
zinn.zone_name_es,
zoute.zone_name_es

from zone_building bld

join zone_level lvl
on bld.zone_level_id = lvl.zone_level_id

join zone_inner inn 
on lvl.zone_inner_id = inn.zone_inner_id

join zone_outer oute 
on oute.zone_outer_id = inn.zone_outer_id

join zone zbld
on zbld.zone_id = bld.zone_building_id

join zone zlvl
on zlvl.zone_id = lvl.zone_level_id

join zone zinn
on zinn.zone_id = inn.zone_inner_id

join zone zoute
on zoute.zone_id = oute.zone_outer_id

where bld.zone_building_id = @var_zone_building_id\G

/*select-zone-building-floor*/
select 
flr.zone_building_floor_id,
zfld.zone_name_es

from zone_building_floor flr

join zone zfld
on zfld.zone_id = flr.zone_building_floor_id

where flr.zone_building_id = @var_zone_building_id\G

