drop event if exists daily_event;
delimiter $$
create event daily_event
on schedule every 1 day
starts '2024-06-3 00:00:00'
on completion preserve enable
do begin
    call daily_event_code();
end
$$
delimiter ;
