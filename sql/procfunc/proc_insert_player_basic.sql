/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/insert_aux_player.sql
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_player_basic.sql
*/
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
    declare vGenreId int default 0;
    declare vBodyId int default 0;
    declare vZoneId int default 0;
    declare vObtentionId int default 0;
    declare vAuxFemaleName varchar(32) default '';
    declare vKoukoFound int default 0;
    declare vLvInt int default 1;
    declare vBodyTypeInt int default 1;
    declare vHissatsuCounter int default 0;
    declare vHissatsuNameAux varchar(32) default '';
    declare vHissatsuLvAux int default 0;
    declare vHissatsuIdAux int default 0;

    /*cur1 variables*/
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
    declare vFullJa varchar(32) default '';
    declare vKanjiJa varchar(32) default '';
    declare vNameEn varchar(32) default '';
    declare vFullEn varchar(32) default '';

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_player;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;
    
    delete from player;
    delete from player_found_at_zone;
    drop table if exists aux_hissatsu;
    create temporary table aux_hissatsu (
        hissatsu_name varchar(32),
        learn_order int
    ); 
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vPageOrder, vNameJa, vZoneName, vObtentionDesc, 
            vAttri, vPositi, vLv, vGp, vTp, vKick, vBody, vControl, vGuard, 
            vSpeed, vStamina, vGuts, vFreedom, vH1, vH2, vH3, vH4, vNameRomanji;
        if continueCur1 = 1 then
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
                set vRomanjiCounter = vRomanjiCounter + 1;
            end while;

            /*zone*/
            set vZoneId = 26; /*default is caravan*/
            if vZoneName != '' then
                select z.zone_id into vZoneId from zone z 
                    join zone_outer zo on z.zone_id = zo.zone_outer_id 
                    where z.zone_name_ja like concat(concat('%', vZoneName), '%');
                set continueCur1 = 1;
            end if;

            /*obtention*/
            case
                when vObtentionDesc like '%ストーリー%' then
                    set vObtentionId = 1;
                when vObtentionDesc like '%スカウト%' then
                    set vObtentionId = 2;
                when vObtentionDesc like '%ガチャ%' then
                    set vObtentionId = 3;
                when vObtentionDesc like '%人脈システム%' then
                    set vObtentionId = 4;
                when vObtentionDesc like '%Wi-Fi%' then
                    set vObtentionId = 5;
                when vObtentionDesc like '%パスワード%' then
                    set vObtentionId = 6;
                when vObtentionDesc like '%ミニバトル%' then
                    set vObtentionId = 7;
                when vObtentionDesc like '%プレミアムスカウト%' then
                    set vObtentionId = 11;
                when vObtentionDesc like '%オーガプレミアムリンク%' then
                    set vObtentionId = 12;
                else
                    set vObtentionId = 16; /*default is unknown*/
            end case;

            /*cast lv*/
            set vLv = concat('0', vLv);
            set vLvInt = cast(vLv as unsigned);
            if vLvInt = 0 then
                set vLvInt = null;
            end if;

            /*body*/
            set vBodyType = '';             
            set vBodyType = concat('0', vBodyType);
            set vBodyTypeInt = cast(vBodyType as unsigned);
            if vBodyTypeInt = 0 then
                set vBodyId = 2;
            else
                set vBodyId = vBodyTypeInt;         
            end if;

            /*genre こうこ (first one is not female)*/
            if vNameJa = 'こうこ' then
                if vKoukoFound = 0 then
                    set vGenreId = 2;
                else
                    set vGenreId = 1;
                    set vKoukoFound = 1;
                end if;
            else
                set vAuxFemaleName = null;
                set vGenreId = 1;
                select name_ja into vAuxFemaleName from aux_player_f
                    where name_ja = vNameJa;
                set continueCur1 = 1;
                if vAuxFemaleName is not null then
                    set vGenreId = 2;  
                end if;
            end if;

            /*atri*/
            select attri_id into vAttriId from attri 
                where attri_name_ja = vAttri;            

            /*posi*/
            select positi_id into vPositiId from positi 
                where positi_name_ja = vPositi;       

            /*insert*/ 
            insert into player(player_id, player_name_ja, player_name_hiragana, 
                player_name_kanji, player_name_romanji, player_name_en, 
                player_name_en_full, player_initial_lv, player_gp_99, 
                player_tp_99, player_kick_99, player_body_99, player_control_99,
                player_guard_99, player_speed_99, player_stamina_99, 
                player_guts_99, player_freedom_99, attri_id, positi_id, 
                genre_id, body_type_id, player_obtention_method_id, 
                original_version) values (
                i, vNameJa, null, 
                null, vRomanjiFix, null, 
                null, vLvInt, vGp, 
                vTp, vKick, vBody, vControl,
                vGuard, vSpeed, vStamina, 
                vGuts, vFreedom, vAttriId, vPositiId, 
                vGenreId, vBodyId, vObtentionId, 
                null);

            insert into player_found_at_zone(player_id, zone_id, is_random, 
                hint_ja, hint_en, hint_es) values (
                i, vZoneId, null, null,'null', null);
     
            /*hissatsu*/
            /*replace unwanted char*/
            delete from aux_hissatsu;
            insert into aux_hissatsu values (vH1, 1);
            insert into aux_hissatsu values (vH2, 2);
            insert into aux_hissatsu values (vH3, 3);
            insert into aux_hissatsu values (vH4, 4);

            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '(B)', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '(C)', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '(L)', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '改', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '真', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'V2', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'V3', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'G2', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'G3', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'G4', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'G5', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '(', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, ')', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '\t', '');
            update aux_hissatsu set hissatsu_name = trim(hissatsu_name);

            select hissatsu_name into vH1 from aux_hissatsu where learn_order = 1;
            select hissatsu_name into vH2 from aux_hissatsu where learn_order = 2;
            select hissatsu_name into vH3 from aux_hissatsu where learn_order = 3;
            select hissatsu_name into vH4 from aux_hissatsu where learn_order = 4;

            /*separate name from learn level*/
            set vHissatsuCounter = 1;
            while vHissatsuCounter <= 4 do
                case 
                    when vHissatsuCounter = 1 then
                        set vHissatsuNameAux = vH1;
                    when vHissatsuCounter = 2 then
                        set vHissatsuNameAux = vH2;
                    when vHissatsuCounter = 3 then
                        set vHissatsuNameAux = vH3;
                    when vHissatsuCounter = 4 then
                        set vHissatsuNameAux = vH4;
                end case;
                /*
                char_length counts characters
                length counts bytes
                */
                case
                    when upper(vHissatsuNameAux) like '%LV__' then
                        set vHissatsuLvAux =  
                            cast(substring(
                                vHissatsuNameAux, 
                                char_length(vHissatsuNameAux) - 1, 
                                2
                            ) as unsigned);
                        set vHissatsuNameAux = 
                            substring(
                                vHissatsuNameAux, 
                                1, 
                                char_length(vHissatsuNameAux) - 5
                            );
                    when upper(vHissatsuNameAux) like '%LV_' then
                        set vHissatsuLvAux =  
                            cast(substring(
                                vHissatsuNameAux, 
                                char_length(vHissatsuNameAux), 
                                1
                            ) as unsigned);
                        set vHissatsuNameAux = 
                            substring(
                                vHissatsuNameAux, 
                                1, 
                                char_length(vH1) - 3
                            );      
                    else
                        set vHissatsuLvAux = null;
                end case;

                /*insert hissatsu*/
                /*
                set vHissatsuIdAux = 0;
                select h.item_hissatsu_id into vHissatsuIdAux
                    from item_hissatsu h join item i 
                    on h.item_hissatsu_id = i.item_id 
                    where i.item_name_ja 
                    like concat(concat('%', vHissatsuNameAux), '%');
                set continueCur1 = 1;
                if vHissatsuIdAux > 0 then
                    insert into player_learns_hissatsu(
                        player_id, item_hissatsu_id, learn_lv, learn_order) 
                    values (
                        i, vHissatsuIdAux, vHissatsuLvAux, vHissatsuCounter);
                end if;
                */
                set vHissatsuCounter = vHissatsuCounter + 1;
            end while;
        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_hissatsu;
end
&&
delimiter ;
call proc_insert_player_basic();
