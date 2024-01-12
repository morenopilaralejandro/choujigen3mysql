/*source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/insert_aux_player.sql*/
delimiter &&
drop procedure if exists proc_insert_player_basic;
create procedure proc_insert_player_basic()
begin
	declare vPath varchar(100);

	set vPath = '/home/alejandro/Desktop/projects/choujigen3mysql/csv/';
end
&&
delimiter ;
call proc_insert_player_basic();


/*
こうこ (first one is not female)
*/
