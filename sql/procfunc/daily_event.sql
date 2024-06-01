drop event if exists daily_event;
delimiter $$
create event daily_event
on schedule every 1 day
starts '2024-06-2 00:00:00'
on completion preserve enable
do begin
    declare idPlayer int default 1;
    declare vMin int default 1;    
    declare vMax int default 1;

    select count(*) into vMax from player;
    set idPlayer = ROUND((RAND() * (vMax-vMin))+vMin);

	update daily set id_player = idPlayer where daily_id = 1;
	update daily set views = 0 where daily_id = 1;
end
$$
delimiter ;
