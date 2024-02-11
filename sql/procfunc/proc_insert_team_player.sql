/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_team_player.sql
*/
drop table if exists aux_team_player;
create temporary table aux_team_player (
    team varchar(32),
    player varchar(32),
    off int,
    pla int
); 

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/team_player.csv'
into table aux_team_player 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(team, player, off, pla);

delimiter &&
drop procedure if exists proc_insert_team_player;
create procedure proc_insert_team_player()
begin
	declare i int default 1;
    declare idTeam int default 0;
    declare idPlayer int default 0;

    /*cur1 variables*/
    declare vTeam varchar(32) default '';
    declare vPlayer varchar(32) default '';
    declare vOff int default 0;
    declare vPla int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_team_player;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    delete from player_is_part_of_team;    
    delete from player_plays_during_story_team;
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vTeam, vPlayer, vOff, vPla;
        set idPlayer = null;
        set idTeam = null;
        if continueCur1 = 1 and vPlayer != '' then
            select team_id into idTeam from team 
                where team_name_ja = vTeam;

            /*select player version based on offset*/
            select player_id into idPlayer from player
                where player_name_romanji like trim(vPlayer) 
                limit 1 offset vOff;
            set continueCur1 = 1;            

            if idPlayer is null then
                select vTeam, vPlayer, vOff, vPla;
            end if;

            insert into player_is_part_of_team(player_id, team_id, place) 
                values (idPlayer, idTeam, vPla);

            if idTeam = 51 or idTeam between 32 and 49 then
                /*
                select vTeam, vPlayer, vOff, vPla;
                */
                insert into player_plays_during_story_team
                    (player_id, team_id) values (idPlayer, idTeam);
            end if;
        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_team_player;
end
&&
delimiter ;
call proc_insert_team_player();
