/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_stor_item.sql
*/
drop table if exists aux_stor;
create temporary table aux_stor (
    item_id varchar(32),
    stor_id int
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/stor.csv'
into table aux_stor 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(item_id, stor_id);

delimiter &&
drop procedure if exists proc_insert_stor_item;
create procedure proc_insert_stor_item()
begin
	declare i int default 1;
    declare idItem int default 0;

    /*cur1 variables*/
    declare vItemId varchar(32) default '';
    declare vStorId int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_stor;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    delete from item_sold_at_stor;    
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vItemId, vStorId;
        set idItem = null;
        if continueCur1 = 1 then
            /*
            select vItemId, vStorId; 
            select item_id from item where item_name_es = vItemId; 
            */

            if vItemId = 'Lluvia oscura montaña' then
                set idItem = 141;
            elseif vItemId = 'Mano mágica montaña' then
                set idItem = 339;
            elseif vItemId = 'Mano celestial montaña' then
                set idItem = 336;
            else 
                select item_id into idItem from item 
                    where item_name_es = vItemId;      
            end if;         

            if idItem is null then
                select vItemId;
            end if;

            insert into item_sold_at_stor(
                stor_id, item_id)
                values (vStorId, idItem);
        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_stor;
end
&&
delimiter ;
call proc_insert_stor_item();
