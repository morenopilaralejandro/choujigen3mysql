/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_route_drop.sql
*/
drop table if exists aux_route_drop;
create temporary table aux_route_drop (
    team varchar(32),
    item1 varchar(32),
    rate1 int,
    item2 varchar(32),
    rate2 int,
    item3 varchar(32),
    rate3 int
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/route_drop.csv'
into table aux_route_drop 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(team, item1, rate1, item2, rate2, item3, rate3);

delimiter &&
drop procedure if exists proc_insert_route_drop;
create procedure proc_insert_route_drop()
begin
	declare i int default 1;
    declare idItem1 int default 0;
    declare idItem2 int default 0;
    declare idItem3 int default 0;

    /*cur1 variables*/
    declare vTeam varchar(32) default '';
    declare vItem1 varchar(32) default '';
    declare vRate1 int default 0;
    declare vItem2 varchar(32) default '';
    declare vRate2 int default 0;
    declare vItem3 varchar(32) default '';
    declare vRate3 int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_route_drop;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    delete from practice_game_can_drop_item;    
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vTeam, vItem1, vRate1, vItem2, vRate2, vItem3, vRate3;
        set idItem1 = null;
        set idItem2 = null;
        set idItem3 = null;
        if continueCur1 = 1 then

            if vItem1 = 'クロスファイア1' then
                set idItem1 = 34;
            elseif vItem1 = 'クロスファイア2' then
                set idItem1 = 111;
            elseif vItem1 = 'シャドウ・レイ' then
                set idItem1 = 72;
            else 
                select item_id into idItem1 from item 
                    where item_name_ja = vItem1; 
            end if;   

            if vItem2 = 'クロスファイア1' then
                set idItem2 = 34;
            elseif vItem2 = 'クロスファイア2' then
                set idItem2 = 111;
            elseif vItem2 = 'シャドウ・レイ' then
                set idItem2 = 72;
            else 
                select item_id into idItem2 from item 
                    where item_name_ja = vItem2;
            end if;         

            if vItem3 = 'クロスファイア1' then
                set idItem3 = 34;
            elseif vItem3 = 'クロスファイア2' then
                set idItem3 = 111;
            elseif vItem3 = 'シャドウ・レイ' then
                set idItem3 = 72;
            else 
                select item_id into idItem3 from item 
                    where item_name_ja = vItem3;   
            end if;             


            if idItem1 is null then
                select vItem1;
            end if;
            if idItem2 is null then
                select vItem2;
            end if;
            if idItem3 is null then
                select vItem3;
            end if;

            insert into practice_game_can_drop_item(
                practice_game_id, item_id, drop_rate)
                values (i, idItem1, vRate1);
            insert into practice_game_can_drop_item(
                practice_game_id, item_id, drop_rate)
                values (i, idItem2, vRate2);
            insert into practice_game_can_drop_item(
                practice_game_id, item_id, drop_rate)
                values (i, idItem3, vRate3);

        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_route_drop;
end
&&
delimiter ;
call proc_insert_route_drop();
