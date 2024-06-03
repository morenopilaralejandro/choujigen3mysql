/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_utc_drop.sql
*/
drop table if exists aux_utc;
create temporary table aux_utc (
    utc_session_id int,
    item_id varchar(32),
    utc_drop_type_id int,
    drop_rate int
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/utc.csv'
into table aux_utc 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(utc_session_id, item_id, utc_drop_type_id, drop_rate);

delimiter &&
drop procedure if exists proc_insert_utc_drop;
create procedure proc_insert_utc_drop()
begin
	declare i int default 1;
    declare idItem int default 0;

    /*cur1 variables*/
    declare vUtcSessionId int default 0;
    declare vItemId varchar(32) default '';
    declare vUtcDropTypeId int default 0;
    declare vDropRate int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_utc;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    delete from utc_session_drops;    
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vUtcSessionId, vItemId, vUtcDropTypeId, vDropRate;
        set idItem = null;
        if continueCur1 = 1 then
            /*
            select vUtcSessionId, vItemId, vUtcDropTypeId, vDropRate; 
            select item_id from item where item_name_ja = vItemId; 
            */

            if vItemId = 'placeholder' then
                set idItem = 141;
            else 
                select item_id into idItem from item 
                    where item_name_ja = vItemId;      
            end if;         

            if idItem is null then
                select vItemId;
            end if;

            insert into utc_session_drops(
                utc_session_id, 
                item_id, 
                utc_drop_type_id, 
                drop_rate)
                values (vUtcSessionId, idItem, vUtcDropTypeId, vDropRate);
        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_utc;
end
&&
delimiter ;
call proc_insert_utc_drop();
