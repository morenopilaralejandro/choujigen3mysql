/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_set_player_version.sql
select
    p1.player_id,
    p1.player_name_ja,
    p2.player_id,
    p2.player_name_ja
from
    player p1
join player p2 on
    p1.original_version = p2.player_id
where
    p1.original_version is not null;
*/
delimiter &&
drop procedure if exists proc_set_player_version;
create procedure proc_set_player_version()
begin
	declare i int default 0;
    declare vOriginalId int default 0;
    declare vCurrentName varchar(32) default '';
    declare vPreviousName varchar(32) default '';

    /*cur1 variables*/
    declare playerId int default 0;
    declare playerNameJa varchar(32) default '';
    declare playerNameHiragana varchar(32) default '';
    declare playerNameKanji varchar(32) default '';
    declare playerNameRomanji varchar(32) default '';
    declare playerNameEn varchar(32) default '';
    declare playerNameEnFull varchar(32) default '';
    declare playerInitialLv int default 0;
    declare playerGp99 int default 0;
    declare playerTp99 int default 0;
    declare playerKick99 int default 0;
    declare playerBody99 int default 0;
    declare playerControl99 int default 0;
    declare playerGuard99 int default 0;
    declare playerSpeed99 int default 0;
    declare playerStamina99 int default 0;
    declare playerGuts99 int default 0;
    declare playerFreedom99 int default 0;
    declare attriId int default 0;
    declare positiId int default 0;
    declare genderId int default 0;
    declare bodyTypeId int default 0;
    declare playerObtentionMethodId int default 0;
    declare originalVersion int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from player 
        where player_name_ja like '% 2' order by player_name_ja;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    open cur1;
	while continueCur1=1 do
        fetch cur1 into playerId, playerNameJa, playerNameHiragana, 
            playerNameKanji, playerNameRomanji, playerNameEn, playerNameEnFull, 
            playerInitialLv, playerGp99, playerTp99, playerKick99, playerBody99, 
            playerControl99, playerGuard99, playerSpeed99, playerStamina99, 
            playerGuts99, playerFreedom99, attriId, positiId, genderId, 
            bodyTypeId, playerObtentionMethodId, originalVersion;

        if continueCur1 = 1 then
            set vPreviousName = vCurrentName; 
            set vCurrentName = 
                substring(playerNameJa, 1, char_length(playerNameJa) - 2);
            if vCurrentName != vPreviousName then
                select player_id into vOriginalId from player 
                    where player_name_ja = vCurrentName limit 1;
                set continueCur1 = 1;
            end if;
            /*select vCurrentName, playerId, vOriginalId;*/
            update player set 
                player_name_ja = vCurrentName, 
                original_version = vOriginalId
                where player_id = playerId;
            set i = i + 1;
        end if;
	end while;
	close cur1;
    /*midorikawa*/
    update player set original_version = 1396 where player_id = 1896;
    /*gran*/
    update player set original_version = 1217 where player_id = 1868;
end
&&
delimiter ;
call proc_set_player_version();
