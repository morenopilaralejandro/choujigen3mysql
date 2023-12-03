/*database choujigen3ogre*/

/*1-delete*/

/*2-create*/
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
    outer_zone_name_ja varchar(32),
    outer_zone_name_en varchar(32),
    outer_zone_name_es varchar(32),
    constraint outer_zone_pk primary key (outer_zone_id),
    constraint outer_zone_fk_zone foreign key (outer_zone_id) 
        references zone(zone_id) on delete cascade
);

create table inner_zone ( 
    inner_zone_id int not null auto_increment,
    inner_zone_name_ja varchar(32),
    inner_zone_name_en varchar(32),
    inner_zone_name_es varchar(32),
    outer_zone_id int,
    constraint inner_zone_pk primary key (zone_id),
    constraint inner_zone_fk_zone foreign key (inner_zone_id) 
        references zone(zone_id) on delete cascade,
    constraint inner_zone_fk_outer_zone foreign key (outer_zone_id) 
        references outer_zone(outer_zone_id) on delete cascade
);

create table zone_level ( 
    zone_level_id int not null auto_increment,
    zone_level_name_ja varchar(32),
    zone_level_name_en varchar(32),
    zone_level_name_es varchar(32),
    inner_zone_id int,
    constraint zone_level_pk primary key (zone_level_id),
    constraint zone_level_fk_zone foreign key (zone_level_id) 
        references zone(zone_id) on delete cascade,
    constraint zone_level_fk_inner_zone foreign key (inner_zone_id) 
        references inner_zone(inner_zone_id) on delete cascade
);

/*3-insert*/
insert into zone_type (zone_type_id,zone_type_name) values (1,'outer zone');
insert into zone_type (zone_type_id,zone_type_name) values (2,'inner zone');
insert into zone_type (zone_type_id,zone_type_name) values (3,'zone level');
insert into zone_type (zone_type_id,zone_type_name) values (4,'building');


/*4-select*/
