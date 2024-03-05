/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_get_player_by_name.sql
*/
delimiter &&
drop procedure if exists proc_get_player_by_name;
create procedure proc_get_player_by_name(in name varchar(32))
begin
    declare asciiStart varchar(200) default '
  ######  
 ##    ## 
##      ##
##########
##      ##
##      ##';
    declare asciiEnd varchar(200) default '
#######  
##     ## 
##     ## 
#######  
##     ## 
##     ## 
#######';
	declare i int default 0;
    declare vAttri varchar(1);
    declare vGender varchar(1);
    declare vBody varchar(2);
    declare vPositi varchar(2);
    declare vObtention varchar(32);
    declare vZoneName varchar(32);
    declare vHissatsu1 varchar(32);
    declare vHissatsu2 varchar(32);
    declare vHissatsu3 varchar(32);
    declare vHissatsu4 varchar(32);

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
        fetch cur1 into playerId, playerNameJa, playerNameHiragana, 
            playerNameKanji, playerNameRomanji, playerNameEn, playerNameEnFull, 
            playerInitialLv, playerGp99, playerTp99, playerKick99, playerBody99, 
            playerControl99, playerGuard99, playerSpeed99, playerStamina99, 
            playerGuts99, playerFreedom99, attriId, positiId, genderId, 
            bodyTypeId, playerObtentionMethodId, originalVersion;

        if continueCur1 = 1 then
            if i > 0 then
                select '------------------------------------------------------' 
                    as '------------------------------------------------------';
            else
                select asciiStart as 'start';
            end if;

            set vZoneName = null;
            select gender_name_ja into vGender from gender 
                where gender_id = genderId;
            select body_type_name_ja into vBody from body_type 
                where body_type_id = bodyTypeId;
            select attri_name_ja into vAttri from attri
                where attri_id = attriId;
            select positi_name_ja into vPositi from positi
                where positi_id = positiId;
            select player_obtention_method_desc_ja into vObtention
                from player_obtention_method
                where player_obtention_method_id = playerObtentionMethodId;
            select z.zone_name_ja into vZoneName from zone z
                join player_found_at_zone pfz on z.zone_id = pfz.zone_id
                where pfz.player_id = playerId;   
            set continueCur1 = 1;

            /*basic*/
            select playerId 'id', originalVersion 've', playerNameJa 'ja',
                vAttri 'at', vPositi 'po', vGender 'ge', vBody 'bo', 
                playerInitialLv 'lv';
            /*stats*/
            select playerGp99 'gp', playerTp99 'tp', playerKick99 'ki', 
                playerBody99 'bo', playerControl99 'co', playerGuard99 'gd', 
                playerSpeed99 'sp', playerStamina99 'st', playerGuts99 'gt', 
                playerFreedom99 'fr';
            /*zone*/
            select vObtention 'ob', vZoneName 'zo';
            /*hissatsu*/
            select i.item_name_ja into vHissatsu1 
                from player_learns_hissatsu plh
                join item i on i.item_id = plh.item_hissatsu_id
                where plh.player_id = playerId and plh.learn_order = 1;
            select i.item_name_ja into vHissatsu2 
                from player_learns_hissatsu plh
                join item i on i.item_id = plh.item_hissatsu_id
                where plh.player_id = playerId and plh.learn_order = 2;
            select i.item_name_ja into vHissatsu3 
                from player_learns_hissatsu plh
                join item i on i.item_id = plh.item_hissatsu_id
                where plh.player_id = playerId and plh.learn_order = 3;
            select i.item_name_ja into vHissatsu4 
                from player_learns_hissatsu plh
                join item i on i.item_id = plh.item_hissatsu_id
                where plh.player_id = playerId and plh.learn_order = 4;
            set continueCur1 = 1;

            select vHissatsu1 'h1', vHissatsu2 'h2', vHissatsu3 'h3', 
                vHissatsu4 'h4';
            set i = i + 1;
        end if;
	end while;
	close cur1;
    select asciiEnd as 'end';
    select i as 'Total Rows'; 
end
&&
delimiter ;
call proc_get_player_by_name('アフロディ');
