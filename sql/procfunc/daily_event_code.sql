delimiter &&
drop procedure if exists daily_event_code;
create procedure daily_event_code()
begin
    declare idPlayer int default 1;
    declare vMin int default 1;    
    declare vMax int default 1;

    select count(*) into vMax from player;
    set idPlayer = ROUND((RAND() * (vMax-vMin))+vMin);

	update daily set player_id = idPlayer where daily_id = 1;
	update daily set views = 0 where daily_id = 1;
end
&&
delimiter ;
call daily_event_code();
