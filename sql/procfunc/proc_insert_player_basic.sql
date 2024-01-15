/*source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/insert_aux_player.sql*/
delimiter &&
drop procedure if exists proc_insert_player_basic;
create procedure proc_insert_player_basic()
begin
	declare i int default 1;
    declare vRomanjiFix varchar(32) default '';
    declare vRomanjiLength int default 0;
    declare vRomanjiCounter int default 0;
    declare vRomanjiCurrentChar varchar(1) default '';
    declare vRomanjiPreviousChar varchar(1) default '';
    declare vAttriId int default 0;
    declare vPositiId int default 0;
    declare vGenreid int default 0;
    declare vBodyId int default 0;
    declare vObtentionId int default 0;
    declare vAuxFemaleName varchar(32) default '';
    declare vKoukoFound int default 0;
    declare vLvInt int default 1;
    declare vBodyTypeInt int default 1;
    declare vHissatsuId1 int default 0;
    declare vHissatsuId2 int default 0;
    declare vHissatsuId3 int default 0;
    declare vHissatsuId4 int default 0;

    /*cur1 variables*/
    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_player;
	declare exit handler for SQLSTATE '02000' set continueCur1=0;

    declare vPageOrder varchar(32) default '';
    declare vNameJa varchar(32) default '';
    declare vZoneName varchar(32) default '';
    declare vObtentionDesc varchar(100) default '';
    declare vAttri varchar(32) default '';
    declare vPositi varchar(32) default '';
    declare vLv varchar(32) default '';
    declare vGp int default 0;
    declare vTp int default 0;
    declare vKick int default 0;
    declare vBody int default 0;
    declare vControl int default 0;
    declare vGuard int default 0;
    declare vSpeed int default 0;
    declare vStamina int default 0;
    declare vGuts int default 0;
    declare vFreedom int default 0;
    declare vH1 varchar(32) default '';
    declare vH2 varchar(32) default '';
    declare vH3 varchar(32) default '';
    declare vH4 varchar(32) default '';
    declare vNameRomanji varchar(32) default '';

    declare vBodyType varchar(32) default '';
	declare VFullJa	varchar(32) default '';
    declare vKanjiJa varchar(32) default '';
    declare vNameEn	varchar(32) default '';
    declare vFullEn varchar(32) default '';
    
    delete from player;
    open cur1;
	while continueCur1=1 do
        set vAuxFemaleName = null;

        fetch cur1 into vPageOrder, vNameJa, vZoneName, vObtentionDesc, 
            vAttri, vPositi, vLv, vGp, vTp, vKick, vBody, vControl, vGuard, 
            vSpeed, vStamina, vGuts, vFreedom, vH1, vH2, vH3, vH4, vNameRomanji;

        /*romanji name*/
        set vRomanjiFix = '';
        set vRomanjiCounter = 1;
        set vRomanjiCurrentChar = '';
        set vRomanjiPreviousChar = '';
        set vRomanjiLength = length(vNameRomanji);
        while vRomanjiCounter <= vRomanjiLength do
            set vRomanjiPreviousChar = vRomanjiCurrentChar;
            set vRomanjiCurrentChar = substring(vNameRomanji, vRomanjiCounter, 1);
            if vRomanjiCurrentChar = 'ー' then
                set vRomanjiFix = concat(vRomanjiFix, vRomanjiPreviousChar);
            else
                set vRomanjiFix = concat(vRomanjiFix, vRomanjiCurrentChar);                
            end if;
            set vRomanjiCounter = vRomanjiCounter +1;
        end while;

        /*zone*/

        /*obtention*/

        /*cast lv*/

        /*body*/

        /*atri*/

        /*posi*/

        /*hissatsu*/
    
        /*
        insert into `player`(`player_id`, `player_name_ja`, `player_name_hiragana`, 
            `player_name_kanji`, `player_name_romanji`, `player_name_en`, 
            `player_name_en_full`, `player_initial_lv`, `player_gp_99`, 
            `player_tp_99`, `player_kick_99`, `player_body_99`, `player_control_99`,
            `player_guard_99`, `player_speed_99`, `player_stamina_99`, 
            `player_guts_99`, `player_freedom_99`, `attri_id`, `positi_id`, 
            `genre_id`, `body_type_id`, `player_obtention_method_id`, 
            `original_version`) values (
            i, vNameJa, null, 
            null, vRomanjiFix, null, 
            null, vLvInt, vGp, 
            vTp, vKick, vBody, vControl,
            vGuard, vSpeed, vStamina, 
            vGuts, vFreedom, `attri_id`, `positi_id`, 
            `genre_id`, `body_type_id`, `player_obtention_method_id`, 
            `original_version`);
        */
        set i = i + 1;
	end while;
	close cur1;
end
&&
delimiter ;
call proc_insert_player_basic();


/*
こうこ (first one is not female)
*/
