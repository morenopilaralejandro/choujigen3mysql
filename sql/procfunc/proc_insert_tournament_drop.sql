/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_tournament_drop.sql
*/
drop table if exists aux_tournament_drop;
create temporary table aux_tournament_drop (
    tournament_rank_id int,
    item_id varchar(32),
    amount int,
    selection_rate int, 
    drop_rate int,
    no_recover_rate int
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/tournament_drop.csv'
into table aux_tournament_drop 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(tournament_rank_id, item_id, selection_rate, 
drop_rate, no_recover_rate, amount);

delimiter &&
drop procedure if exists proc_insert_tournament_drop;
create procedure proc_insert_tournament_drop()
begin
	declare i int default 1;
    declare idItem int default 0;

    /*cur1 variables*/
    declare vTournamentRankId int default 0;
    declare vItemId varchar(32) default '';
    declare vAmount int default 0;
    declare vSelectionRate int default 0;
    declare vDropRate int default 0;
    declare vNoRecoverRate int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_tournament_drop;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    delete from tournament_rank_may_drop_item;    
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vTournamentRankId, vItemId, vAmount, 
            vSelectionRate, vDropRate, vNoRecoverRate;
        set idItem = null;
        if continueCur1 = 1 then
            if vItemId = 'ゴッドハンド' then
                set idItem = 336;
            elseif vItemId = 'ファイアブリザード1' then
                set idItem = 33;
            elseif vItemId = 'ファイアブリザード2' then
                set idItem = 108;
            elseif vItemId = 'クロスファイア1' then
                set idItem = 34;
            elseif vItemId = 'クロスファイア2' then
                set idItem = 111;
            else 
                select item_id into idItem from item 
                    where item_name_ja = vItemId;      
            end if;         

            if idItem is null then
                select vItemId;
            end if;

            insert into tournament_rank_may_drop_item(
                tournament_rank_id, item_id, amount,
                selection_rate, drop_rate, no_recover_rate)
                values (vTournamentRankId, idItem, vAmount, 
                vSelectionRate, vDropRate, vNoRecoverRate);
        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_tournament_drop;
end
&&
delimiter ;
call proc_insert_tournament_drop();
