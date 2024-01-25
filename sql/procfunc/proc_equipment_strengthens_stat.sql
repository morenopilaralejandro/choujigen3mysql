/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_equipment_strengthens_stat.sql
*/
drop temporary table if exists aux_equipment;
create temporary table aux_equipment (
    item_id int,
    effect varchar(32)
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/equipment_stat.csv'
into table aux_equipment 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(item_id, effect);

delimiter &&
drop procedure if exists proc_equipment_strengthens_stat;
create procedure proc_equipment_strengthens_stat()
begin
	declare i int default 0;
	declare statId int default 0;
    declare statName varchar(32) default '';
    declare amountVarchar varchar(32) default '';
	declare amountInt int default 0;
    declare cmd varchar(1000) default '';

    /*cur1 variables*/
    declare vItemId int default 0;
    declare vEffect varchar(32) default '';

    declare continueCur1 int default 1;
    declare cur1 cursor for select item_id, effect from aux_equipment;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    drop temporary table if exists res;
    create temporary table res (
        res_cmd varchar(1000)
    );

    open cur1;
	while continueCur1=1 do
        fetch cur1 into vItemId, vEffect;
        set cmd = '';
        if continueCur1 = 1 then
            set amountVarchar = substring(vEffect, char_length(vEffect)-1, 2);
            set amountInt = cast(amountVarchar as unsigned);

            set statName = substring(vEffect, 1, char_length(vEffect)-3);
            select stat_id into statId from stat 
                where stat_name_ja like statName;

            /*
            select vItemId, statName, statId, amountInt;
            */

            set cmd = concat('(', vItemId);
            set cmd = concat(cmd, ', ');
            set cmd = concat(cmd, statId);
            set cmd = concat(cmd, ', ');
            set cmd = concat(cmd, amountInt);
            set cmd = concat(cmd, '),');

            insert into res values(cmd);
        end if;
	end while;
	close cur1;
    select * from res;
    drop temporary table if exists res;
    drop temporary table if exists aux_equipment;
end
&&
delimiter ;
call proc_equipment_strengthens_stat();
