/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_team_tactic.sql
*/
drop temporary table if exists aux_team_tactic;
create temporary table aux_team_tactic (
    team varchar(32),
    tactic varchar(32)
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/team_tactic.csv'
into table aux_team_tactic 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 1 lines
(team, tactic);

delimiter &&
drop procedure if exists proc_insert_team_tactic;
create procedure proc_insert_team_tactic()
begin
	declare i int default 0;
    declare cmd varchar(1000) default '';
    declare idTeam int default 0;
    declare idTactic  int default 0;

    /*cur1 variables*/
    declare vTeam varchar(32) default '';
    declare vTactic varchar(32) default '';

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_team_tactic;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    drop temporary table if exists res;
    create temporary table res (
        res_cmd varchar(1000)
    );

    open cur1;
	while continueCur1=1 do
        fetch cur1 into vTeam, vTactic;
        set cmd = '';
        if continueCur1 = 1 then
            select team_id into idTeam from team 
                where team_name_ja = vTeam;

            case 
                when vTactic = 'Route of Sky' then
                    set idTactic = 716;
                when vTactic = 'Dancing Ball Escape' then
                    set idTactic = 717;
                when vTactic = 'Dual Typhoon' then
                    set idTactic = 718;
                when vTactic = 'Engetsu no Jin' then
                    set idTactic = 719;
                when vTactic = 'Muteki no Yari' then
                    set idTactic = 720;
                when vTactic = 'Rolling Thunder' then
                    set idTactic = 721;
                when vTactic = 'Emperor Road' then
                    set idTactic = 722;
                when vTactic = 'Amazon River Wave' then
                    set idTactic = 723;
                when vTactic = 'Banana Shoot' then
                    set idTactic = 724;
                when vTactic = 'The Tube' then
                    set idTactic = 725;
                when vTactic = 'Box Lock Defense' then
                    set idTactic = 726;
                when vTactic = 'Absolute Knights' then
                    set idTactic = 727;
                when vTactic = 'Andes no Arijigoku' then
                    set idTactic = 728;
                when vTactic = 'Perfect Zone Press' then
                    set idTactic = 729;
                when vTactic = 'Catenaccio Counter' then
                    set idTactic = 730;
                when vTactic = 'Circle Play Drive' then
                    set idTactic = 731;
                when vTactic = 'Ghost Lock' then
                    set idTactic = 732;
                when vTactic = 'Saint Flash' then
                    set idTactic = 733;
                when vTactic = 'Black Thunder' then
                    set idTactic = 734;
                when vTactic = 'Quick Time' then
                    set idTactic = 735;
                when vTactic = 'Slow Time' then
                    set idTactic = 736;
                else
                    set idTactic = null;
            end case;
            set continueCur1 = 1;

            set cmd = concat('(', idTactic);
            set cmd = concat(cmd, ', ');
            set cmd = concat(cmd, idTeam);
            set cmd = concat(cmd, '),');

            insert into res values(cmd);
        end if;
	end while;
	close cur1;
    select * from res;
    drop temporary table if exists res;
    drop temporary table if exists aux_team_tactic;
end
&&
delimiter ;
call proc_insert_team_tactic();
