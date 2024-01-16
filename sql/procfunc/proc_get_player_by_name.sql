/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_get_player_by_name.sql
*/
delimiter &&
drop procedure if exists proc_get_player_by_name;
create procedure proc_get_player_by_name(in name varchar(32))
begin
	declare i int default 1;

    /*cur1 variables*/
    declare playerIdInt int default 0;
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
    declare genreId int default 0;
    declare bodyTypeId int default 0;
    declare playerObtentionMethodId int default 0;
    declare originalVersion int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from player where 
        player_name_ja = name or
        player_name_hiragana = name or
        player_name_kanji = name or
        player_name_romanji = name or
        player_name_en = name or
        player_name_en_full  = name;
    /*
    declare cur1 cursor for select * from player where 
        player_name_ja like concat(concat('%', name), '%') or
        player_name_hiragana like concat(concat('%', name), '%') or
        player_name_kanji like concat(concat('%', name), '%') or
        player_name_romanji like concat(concat('%', name), '%') or
        player_name_en like concat(concat('%', name), '%') or
        player_name_en_full like concat(concat('%', name), '%');
    */
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    open cur1;
	while continueCur1=1 do
        fetch cur1 into playerIdInt, playerNameJa, playerNameHiragana, 
            playerNameKanji, playerNameRomanji, playerNameEn, playerNameEnFull, 
            playerInitialLv, playerGp99, playerTp99, playerKick99, playerBody99, 
            playerControl99, playerGuard99, playerSpeed99, playerStamina99, 
            playerGuts99, playerFreedom99, attriId, positiId, genreId, 
            bodyTypeId, playerObtentionMethodId, originalVersion;
        if continueCur1 = 1 then
            select playerIdInt, playerNameJa;
        end if;
	end while;
	close cur1;
end
&&
delimiter ;
call proc_get_player_by_name('あいかた');
