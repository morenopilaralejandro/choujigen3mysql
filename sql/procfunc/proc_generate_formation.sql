/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_generate_formation.sql
*/
drop temporary table if exists aux_formation;
create temporary table aux_formation (
    item_formation_id int,
    item_formation_name_ja varchar(32),
    item_formation_name_en varchar(32),
    item_formation_name_es varchar(32),
    item_formation_type varchar(32),
    item_formation_scheme varchar(32),
    original_version varchar(32)
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/formation.csv'
into table aux_formation 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(item_formation_id, item_formation_name_ja, item_formation_name_en,
item_formation_name_es, item_formation_type, item_formation_scheme,
original_version);

delimiter &&
drop procedure if exists proc_generate_formation;
create procedure proc_generate_formation()
begin
	declare i int default 0;
    declare cmd varchar(1000) default '';
    declare intOriginalVersion int default 0;
    declare idType int default 0;
    declare idScheme int default 0;

    /*cur1 variables*/
    declare itemFormationId int default 0;
    declare itemFormationNameJa varchar(32) default '';
    declare itemFormationNameEn varchar(32) default '';
    declare itemFormationNameEs varchar(32) default '';
    declare itemFormationType varchar(32) default '';
    declare itemFormationScheme varchar(32) default '';
    declare originalVersion varchar(32) default '';

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_formation;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    drop temporary table if exists res;
    create temporary table res (
        res_cmd varchar(1000)
    );

    open cur1;
	while continueCur1=1 do
        fetch cur1 into itemFormationId, itemFormationNameJa,
            itemFormationNameEn,itemFormationNameEs, itemFormationType, 
            itemFormationScheme, originalVersion;
        set cmd = '';
        set intOriginalVersion = null;
        if continueCur1 = 1 then
            if originalVersion != 'original' then
                set intOriginalVersion = cast(originalVersion as unsigned);
            end if;

            if itemFormationType = '対戦' then
                set idType = 1;
            else
                set idType = 2;
            end if;

            select item_formation_scheme_id into idScheme from item_formation_scheme
                where item_formation_scheme_name = itemFormationScheme;

            set cmd = concat('(', itemFormationId);
            set cmd = concat(cmd, ', ');
            set cmd = concat(cmd, idType);
            set cmd = concat(cmd, ', ');
            set cmd = concat(cmd, idScheme);
            set cmd = concat(cmd, ', ');
            if intOriginalVersion > 0 then
                set cmd = concat(cmd, intOriginalVersion);
            else
                set cmd = concat(cmd, 'null');
            end if;
            set cmd = concat(cmd, '),');

            insert into res values(cmd);
        end if;
	end while;
	close cur1;
    select * from res;
    drop temporary table if exists res;
    drop temporary table if exists aux_formation;
end
&&
delimiter ;
call proc_generate_formation();
