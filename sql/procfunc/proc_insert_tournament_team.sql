/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_tournament_team.sql
*/
drop table if exists aux_tournament_team;
create temporary table aux_tournament_team (
    tournament_rank_id int,
    team_id varchar(32),
    team_lv int
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/tournament_team.csv'
into table aux_tournament_team 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(tournament_rank_id, team_id, team_lv);

delimiter &&
drop procedure if exists proc_insert_tournament_team;
create procedure proc_insert_tournament_team()
begin
	declare i int default 1;
    declare idTeam int default 0;

    /*cur1 variables*/
    declare vTournamentRankId int default 0;
    declare vTeamId varchar(32) default '';
    declare vTeamLv int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_tournament_team;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    delete from tournament_rank_disputed_by_team;    
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vTournamentRankId, vTeamId, vTeamLv;
        set idTeam = null;
        if continueCur1 = 1 then
            select team_id into idTeam from team 
                where team_name_es = vTeamId;         

            if idTeam is null then
                select vTeamId;
            end if;

            insert into tournament_rank_disputed_by_team(
                tournament_rank_id, team_id, team_lv)
                values (vTournamentRankId, idTeam, vTeamLv);
        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_tournament_team;
end
&&
delimiter ;
call proc_insert_tournament_team();
