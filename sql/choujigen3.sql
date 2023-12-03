/*database choujigen3ogre*/

/*1-drop*/
drop table if exists store;
drop table if exists store_type;
drop table if exists building_floor;
drop table if exists building;
drop table if exists zone_level;
drop table if exists inner_zone;
drop table if exists outer_zone;
drop table if exists zone_type;
drop table if exists zone;
drop table if exists region;


/*2-create*/
create table region (
    region_id int not null auto_increment,
    region_name_ja varchar(32),
    region_name_en varchar(32),
    region_name_es varchar(32),
    constraint region_pk primary key (region_id)
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

create table zone_type (
    zone_type_id int not null auto_increment,
    zone_type_name varchar(32),
    constraint zone_type_pk primary key (zone_type_id)
);

create table outer_zone (
    outer_zone_id int not null auto_increment,
    region_id int,
    constraint outer_zone_pk primary key (outer_zone_id),
    constraint outer_zone_fk_zone foreign key (outer_zone_id) 
        references zone(zone_id) on delete cascade,
    constraint outer_zone_fk_region foreign key (region_id) 
        references region(region_id) on delete cascade
);

create table inner_zone ( 
    inner_zone_id int not null auto_increment,
    outer_zone_id int,
    constraint inner_zone_pk primary key (zone_id),
    constraint inner_zone_fk_zone foreign key (inner_zone_id) 
        references zone(zone_id) on delete cascade,
    constraint inner_zone_fk_outer_zone foreign key (outer_zone_id) 
        references outer_zone(outer_zone_id) on delete cascade
);

create table zone_level ( 
    zone_level_id int not null auto_increment,
    inner_zone_id int,
    constraint zone_level_pk primary key (zone_level_id),
    constraint zone_level_fk_zone foreign key (zone_level_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_level_fk_inner_zone foreign key (inner_zone_id) 
        references inner_zone(inner_zone_id) on delete cascade
);

create table building ( 
    building_id int not null auto_increment,
    zone_level_id int,
    constraint building_pk primary key (building_id),
    constraint building_fk_zone foreign key (building_id) 
        references zone(zone_id) on delete cascade,
    constraint building_fk_zone_level foreign key (zone_level_id) 
        references zone_level(zone_level_id) on delete cascade
);

create table building_floor ( 
    building_floor_id int not null auto_increment,
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
insert into (region_id, region_name_ja, region_name_en, region_name_es) region values (1, '日本', 'Japan', 'Japón');
insert into (region_id, region_name_ja, region_name_en, region_name_es) region values (2, 'ライオコット島', 'Liocott Island', 'Isla Liocott');

insert into zone_type (zone_type_id,zone_type_name) values (1,'outer zone');
insert into zone_type (zone_type_id,zone_type_name) values (2,'inner zone');
insert into zone_type (zone_type_id,zone_type_name) values (3,'zone level');
insert into zone_type (zone_type_id,zone_type_name) values (4,'building');

insert into store_type (store_type_id, store_type_name_ja, store_type_name_en, store_type_name_es) values (1, 'ごくらくマーケット', 'Gokuraku Market', 'Mercazuma');
insert into store_type (store_type_id, store_type_name_ja, store_type_name_en, store_type_name_es) values (2, 'ペンギーゴ', 'Penguigo', 'Balón Bazar');
insert into store_type (store_type_id, store_type_name_ja, store_type_name_en, store_type_name_es) values (3, '秘宝堂', 'Hihoudou', 'Todotécnicas');
insert into store_type (store_type_id, store_type_name_ja, store_type_name_en, store_type_name_es) values (4, '売り子', 'Salesman', 'Vendedor');
insert into store_type (store_type_id, store_type_name_ja, store_type_name_en, store_type_name_es) values (5, '最強ショップ', 'Strongest shop', 'Supertienda');
insert into store_type (store_type_id, store_type_name_ja, store_type_name_en, store_type_name_es) values (6, '真・最強ショップ', 'True Strongest shop', 'Supertienda Redux');
insert into store_type (store_type_id, store_type_name_ja, store_type_name_en, store_type_name_es) values (7, '駄菓子屋', 'Sweet Shop', 'Tienda de Chuches');


/*4-select*/
