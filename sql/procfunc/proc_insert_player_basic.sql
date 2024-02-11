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
    declare vFanFound int default 0;
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
    delete from player_learns_hissatsu;
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

            /*genre 
                こうこ (first one is not female)
                ファン (first one is female)
            */
            if vNameJa = 'こうこ' then
                if vKoukoFound = 0 then
                    set vGenreId = 1;
                    set vKoukoFound = 1;
                else
                    set vGenreId = 2;
                end if;
            elseif vNameJa = 'ファン' then
                if vFanFound = 0 then
                    set vGenreId = 2;
                    set vFanFound = 1;
                else
                    set vGenreId = 1;
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
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, ' ', '');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '･', '・');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'Ｖ', 'V');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '―', 'ー');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '－', 'ー');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, '!', '！');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'Ｕ', 'U');
            update aux_hissatsu set hissatsu_name = replace(hissatsu_name, 'Ｐ', 'P');





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
                    when upper(vHissatsuNameAux) like '%LV.__' then
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
                                char_length(vHissatsuNameAux) - 4
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
                                char_length(vHissatsuNameAux) - 3
                            );    
                    when upper(vHissatsuNameAux) like '%LV' then
                        set vHissatsuLvAux = null;
                        set vHissatsuNameAux = 
                            substring(
                                vHissatsuNameAux, 
                                1, 
                                char_length(vHissatsuNameAux) - 2
                            );    
                     when upper(vHissatsuNameAux) like '%L_' then
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
                                char_length(vHissatsuNameAux) - 2
                            );   
                     when upper(vHissatsuNameAux) like '%P' then
                        set vHissatsuLvAux = null;
                        set vHissatsuNameAux = 
                            substring(
                                vHissatsuNameAux, 
                                1, 
                                char_length(vHissatsuNameAux) - 1
                            );  
                    else
                        set vHissatsuLvAux = null;
                end case;

                /*insert hissatsu*/
                set vHissatsuIdAux = 0;
                case
                    /*hissatsu with the same name*/ 
                    when vHissatsuNameAux like '%クロスファイア%' then
                        if vAttri = '火' then
                            set vHissatsuIdAux = 111;
                        else
                            set vHissatsuIdAux = 34;
                        end if;
                    when vHissatsuNameAux like '%ファイアブリザード%' then
                        if vAttri = '火' then
                            set vHissatsuIdAux = 108;
                        else
                            set vHissatsuIdAux = 33;
                        end if;
                    when vHissatsuNameAux like '%シャドウ・レイ%' then
                        if vAttri = '山' then
                            set vHissatsuIdAux = 141;
                        else
                            set vHissatsuIdAux = 72;
                        end if;
                    when vHissatsuNameAux like 'ゴッドハンド' then
                        if vAttri = '林' then
                            set vHissatsuIdAux = 301;
                        else
                            set vHissatsuIdAux = 336;
                        end if;
                    when vHissatsuNameAux like '%マジン・ザ・ハンド%' then
                        if vAttri = '林' then
                            set vHissatsuIdAux = 304;
                        else
                            set vHissatsuIdAux = 339;
                        end if;
                    /*Typos or different characters*/ 
                    when vHissatsuNameAux like 'ゴッドハンドX' then
                        set vHissatsuIdAux = 326;
                    when vHissatsuNameAux like 'しこふみ' then
                        set vHissatsuIdAux = 259;
                    when vHissatsuNameAux like 'パワーシールド' then
                        set vHissatsuIdAux = 317;
                    when vHissatsuNameAux like 'サイクロ' then
                        set vHissatsuIdAux = 214;
                    when vHissatsuNameAux like 'サイクロン' then
                        set vHissatsuIdAux = 214;
                    when vHissatsuNameAux like 'ジャッジスルー' then
                        set vHissatsuIdAux = 182;
                    when vHissatsuNameAux like 'ジャッジスルー' then
                        set vHissatsuIdAux = 182;
                    when vHissatsuNameAux like 'ジャッジスルー２' then
                        set vHissatsuIdAux = 190;
                    when vHissatsuNameAux like 'ジャッジスルー2' then
                        set vHissatsuIdAux = 190;
                    when vHissatsuNameAux like 'ジャッジスルー3' then
                        set vHissatsuIdAux = 193;
                    when vHissatsuNameAux like 'デスゾーン' then
                        set vHissatsuIdAux = 59;
                    when vHissatsuNameAux like 'デスゾーン2' then
                        set vHissatsuIdAux = 68;
                    when vHissatsuNameAux like 'イケイケ！' then
                        set vHissatsuIdAux = 353;
                    when vHissatsuNameAux like 'ツインブースト' then
                        set vHissatsuIdAux = 84;
                    when vHissatsuNameAux like 'イナズマ1ごう' then
                        set vHissatsuIdAux = 12;
                    when vHissatsuNameAux like 'イナズマ1号' then
                        set vHissatsuIdAux = 12;
                    when vHissatsuNameAux like 'つなみブースト' then
                        set vHissatsuIdAux = 9;
                    when vHissatsuNameAux like 'ひゃくれつショット' then
                        set vHissatsuIdAux = 38;
                    when vHissatsuNameAux like 'ツインブース' then
                        set vHissatsuIdAux = 84;
                    when vHissatsuNameAux like 'ツインブースト' then
                        set vHissatsuIdAux = 84;
                    when vHissatsuNameAux like 'パーフェクトタワー' then
                        set vHissatsuIdAux = 224;
                    when vHissatsuNameAux like 'U・ボート' then
                        set vHissatsuIdAux = 204;
                    when vHissatsuNameAux like 'U・ボード' then
                        set vHissatsuIdAux = 204;
                    when vHissatsuNameAux like 'U・ポート' then
                        set vHissatsuIdAux = 204;
                    when vHissatsuNameAux like 'シザーズ・ボム' then
                        set vHissatsuIdAux = 201;
                    when vHissatsuNameAux like 'イリュージンボール' then
                        set vHissatsuIdAux = 165;
                    when vHissatsuNameAux like 'グットスメル' then
                        set vHissatsuIdAux = 235;
                    when vHissatsuNameAux like 'イナズマ１ごう' then
                        set vHissatsuIdAux = 12;
                    when vHissatsuNameAux like 'トライアングルZ' then
                        set vHissatsuIdAux = 99;
                    when vHissatsuNameAux like 'こうていペンギン2ごう' then
                        set vHissatsuIdAux = 58;
                    when vHissatsuNameAux like 'こうていペンギン３ごう' then
                        set vHissatsuIdAux = 70;
                    when vHissatsuNameAux like 'こうていペンギンＸ' then
                        set vHissatsuIdAux = 104;
                    when vHissatsuNameAux like 'イナズマ１ごうおとし' then
                        set vHissatsuIdAux = 29;
                    when vHissatsuNameAux like 'Xブラスト' then
                        set vHissatsuIdAux = 110;
                    when vHissatsuNameAux like 'ツインブーストF' then
                        set vHissatsuIdAux = 98;
                    when vHissatsuNameAux like 'ユニコーンブースト ' then
                        set vHissatsuIdAux = 136;
                    when vHissatsuNameAux like 'ドッベルゲンガー' then
                        set vHissatsuIdAux = 227;
                    when vHissatsuNameAux like 'アースクエイク' then
                        set vHissatsuIdAux = 263;
                    when vHissatsuNameAux like 'キトルネードキャッチ' then
                        set vHissatsuIdAux = 281;
                    when vHissatsuNameAux like 'カポエイラスナッチ' then
                        set vHissatsuIdAux = 345;
                    when vHissatsuNameAux like 'サンダービーストE' then
                        set vHissatsuIdAux = 17;
                    when vHissatsuNameAux like 'ビックスパイダー' then
                        set vHissatsuIdAux = 309;
                    when vHissatsuNameAux like 'グラビティション' then
                        set vHissatsuIdAux = 265;
                    when vHissatsuNameAux like 'プロファイゾーン' then
                        set vHissatsuIdAux = 215;
                    when vHissatsuNameAux like 'どこんじょうバット' then
                        set vHissatsuIdAux = 82;
                    when vHissatsuNameAux like 'クリテイカル！' then
                        set vHissatsuIdAux = 360;
                    when vHissatsuNameAux like 'デモンズカット' then
                        set vHissatsuIdAux = 242;
                    when vHissatsuNameAux like 'ゴットハンド' then
                        set vHissatsuIdAux = 336;
                    when vHissatsuNameAux like 'ブレイブショット（L' then
                        set vHissatsuIdAux = 140;
                    when vHissatsuNameAux like 'ゴットノウズ' then
                        set vHissatsuIdAux = 22;
                    when vHissatsuNameAux like 'ガニメデプトロン' then
                        set vHissatsuIdAux = 48;
                    else
                        if vHissatsuNameAux != 'スーパースキャン' then
                            select h.item_hissatsu_id into vHissatsuIdAux
                                from item_hissatsu h join item i 
                                on h.item_hissatsu_id = i.item_id 
                                where i.item_name_ja 
                                like concat(concat('%', vHissatsuNameAux), '%');
                        end if;
                end case;
                set continueCur1 = 1;
                if vHissatsuIdAux > 0 then
                    insert into player_learns_hissatsu(
                        player_id, item_hissatsu_id, learn_lv, learn_order) 
                    values (
                        i, vHissatsuIdAux, vHissatsuLvAux, vHissatsuCounter);
/*
                else
                    select vHissatsuNameAux, char_length(vHissatsuNameAux), vHissatsuIdAux, i, vHissatsuLvAux;
*/
                end if;
                set vHissatsuCounter = vHissatsuCounter + 1;
            end while;
        end if;
        set i = i + 1;
	end while;
	close cur1;
    drop table if exists aux_hissatsu;
    /*
    fix super scan
    att 164
    def 230
    */
    insert into player_learns_hissatsu values (20, 230, null, 2);
    insert into player_learns_hissatsu values (21, 230, null, 1);
    insert into player_learns_hissatsu values (21, 164, null, 3);
    insert into player_learns_hissatsu values (35, 164, null, 1);
    insert into player_learns_hissatsu values (93, 164, null, 1);
    insert into player_learns_hissatsu values (136, 164, null, 2);
    insert into player_learns_hissatsu values (168, 230, null, 1);
    insert into player_learns_hissatsu values (187, 230, null, 1);
    insert into player_learns_hissatsu values (203, 230, null, 2);
    insert into player_learns_hissatsu values (203, 164, null, 3);
    insert into player_learns_hissatsu values (208, 164, null, 2);
    insert into player_learns_hissatsu values (291, 164, null, 1);
    insert into player_learns_hissatsu values (294, 230, null, 1);
    insert into player_learns_hissatsu values (347, 230, null, 1);
    insert into player_learns_hissatsu values (351, 230, null, 1);
    insert into player_learns_hissatsu values (357, 230, null, 1);
    insert into player_learns_hissatsu values (357, 164, null, 3);
    insert into player_learns_hissatsu values (373, 230, null, 3);
    insert into player_learns_hissatsu values (386, 164, null, 4);
    insert into player_learns_hissatsu values (464, 230, null, 1);
    insert into player_learns_hissatsu values (488, 164, null, 2);
    insert into player_learns_hissatsu values (490, 164, 22, 2);
    insert into player_learns_hissatsu values (516, 164, null, 3);
    insert into player_learns_hissatsu values (539, 164, null, 1);
    insert into player_learns_hissatsu values (586, 230, null, 1);
    insert into player_learns_hissatsu values (589, 230, null, 4);
    insert into player_learns_hissatsu values (590, 164, null, 1);
    insert into player_learns_hissatsu values (601, 230, null, 2);
    insert into player_learns_hissatsu values (630, 230, null, 1);
    insert into player_learns_hissatsu values (630, 164, null, 2);
    insert into player_learns_hissatsu values (644, 230, null, 1);
    insert into player_learns_hissatsu values (664, 164, null, 1);
    insert into player_learns_hissatsu values (696, 230, null, 1);
    insert into player_learns_hissatsu values (696, 164, null, 4);
    insert into player_learns_hissatsu values (704, 164, null, 3);
    insert into player_learns_hissatsu values (711, 230, null, 1);
    insert into player_learns_hissatsu values (725, 164, null, 2);
    insert into player_learns_hissatsu values (750, 164, null, 1);
    insert into player_learns_hissatsu values (768, 230, null, 2);
    insert into player_learns_hissatsu values (776, 230, null, 1);
    insert into player_learns_hissatsu values (780, 230, null, 1);
    insert into player_learns_hissatsu values (784, 230, null, 1);
    insert into player_learns_hissatsu values (871, 230, null, 3);
    insert into player_learns_hissatsu values (889, 164, null, 1);
    insert into player_learns_hissatsu values (910, 164, null, 1);
    insert into player_learns_hissatsu values (932, 164, null, 1);
    insert into player_learns_hissatsu values (956, 164, null, 2);
    insert into player_learns_hissatsu values (960, 230, null, 2);
    insert into player_learns_hissatsu values (971, 164, null, 2);
    insert into player_learns_hissatsu values (1007, 164, null, 3);
    insert into player_learns_hissatsu values (1010, 164, null, 1);
    insert into player_learns_hissatsu values (1010, 230, null, 2);
    insert into player_learns_hissatsu values (1025, 230, null, 2);
    insert into player_learns_hissatsu values (1067, 230, null, 2);
    insert into player_learns_hissatsu values (1068, 230, null, 2);
    insert into player_learns_hissatsu values (1070, 164, null, 1);
    insert into player_learns_hissatsu values (1164, 230, null, 2);
    insert into player_learns_hissatsu values (1171, 164, null, 2);
    insert into player_learns_hissatsu values (1177, 164, null, 1);
    insert into player_learns_hissatsu values (1177, 230, null, 2);
    insert into player_learns_hissatsu values (1232, 164, null, 1);
    insert into player_learns_hissatsu values (1232, 230, null, 2);
    insert into player_learns_hissatsu values (1239, 230, null, 2);
    insert into player_learns_hissatsu values (1255, 164, null, 2);
    insert into player_learns_hissatsu values (1255, 230, null, 3);
    insert into player_learns_hissatsu values (1277, 164, null, 2);
    insert into player_learns_hissatsu values (1278, 164, null, 1);
    insert into player_learns_hissatsu values (1278, 230, null, 2);
    insert into player_learns_hissatsu values (1282, 164, null, 1);
    insert into player_learns_hissatsu values (1301, 164, null, 2);
    insert into player_learns_hissatsu values (1355, 164, null, 2);
    insert into player_learns_hissatsu values (1365, 230, null, 1);
    insert into player_learns_hissatsu values (1404, 230, null, 1);
    insert into player_learns_hissatsu values (1404, 164, null, 2);
    insert into player_learns_hissatsu values (1441, 164, null, 2);
    insert into player_learns_hissatsu values (1453, 164, null, 1);
    insert into player_learns_hissatsu values (1462, 230, null, 2);
    insert into player_learns_hissatsu values (1490, 164, null, 2);
    insert into player_learns_hissatsu values (1504, 230, null, 2);
    insert into player_learns_hissatsu values (1583, 230, null, 2);
    insert into player_learns_hissatsu values (1590, 164, null, 1);
    insert into player_learns_hissatsu values (1590, 230, null, 2);
    insert into player_learns_hissatsu values (1613, 164, null, 1);
    insert into player_learns_hissatsu values (1621, 164, null, 2);
    insert into player_learns_hissatsu values (1657, 164, null, 3);
    insert into player_learns_hissatsu values (1658, 230, null, 1);
    insert into player_learns_hissatsu values (1658, 164, null, 3);
    insert into player_learns_hissatsu values (1659, 164, null, 1);
    insert into player_learns_hissatsu values (1659, 230, null, 3);
    insert into player_learns_hissatsu values (1660, 230, null, 1);
    insert into player_learns_hissatsu values (1660, 164, null, 3);
    insert into player_learns_hissatsu values (1661, 164, null, 2);
    insert into player_learns_hissatsu values (1661, 230, null, 3);
    insert into player_learns_hissatsu values (1663, 164, null, 1);
    insert into player_learns_hissatsu values (1664, 230, null, 1);
    insert into player_learns_hissatsu values (1664, 164, null, 2);
    insert into player_learns_hissatsu values (1666, 230, null, 1);
    insert into player_learns_hissatsu values (1666, 164, null, 2);
    insert into player_learns_hissatsu values (1667, 164, null, 3);
    insert into player_learns_hissatsu values (1668, 230, null, 3);
    insert into player_learns_hissatsu values (1669, 164, null, 2);
    insert into player_learns_hissatsu values (1669, 230, null, 3);
    insert into player_learns_hissatsu values (1670, 230, null, 2);
    insert into player_learns_hissatsu values (1671, 230, null, 1);
    insert into player_learns_hissatsu values (1671, 164, null, 3);
    insert into player_learns_hissatsu values (1674, 230, null, 2);
    insert into player_learns_hissatsu values (1674, 164, null, 3);
    insert into player_learns_hissatsu values (1679, 230, null, 3);
    insert into player_learns_hissatsu values (1682, 164, null, 1);
    insert into player_learns_hissatsu values (1690, 164, null, 3);
    insert into player_learns_hissatsu values (1803, 230, null, 2);
    insert into player_learns_hissatsu values (1811, 230, null, 2);
    insert into player_learns_hissatsu values (1811, 164, null, 3);
    insert into player_learns_hissatsu values (1902, 230, null, 1);
    insert into player_learns_hissatsu values (1905, 164, null, 1);
    insert into player_learns_hissatsu values (1908, 164, null, 1);
    insert into player_learns_hissatsu values (1912, 164, null, 2);
    insert into player_learns_hissatsu values (1948, 164, null, 2);
    insert into player_learns_hissatsu values (1948, 230, null, 3);
    insert into player_learns_hissatsu values (1981, 230, null, 1);
    insert into player_learns_hissatsu values (1981, 164, null, 2);
    insert into player_learns_hissatsu values (1982, 164, null, 1);
    insert into player_learns_hissatsu values (2012, 164, null, 2);
    insert into player_learns_hissatsu values (2063, 230, null, 3);
    insert into player_learns_hissatsu values (2119, 164, null, 2);
    insert into player_learns_hissatsu values (2175, 230, null, 2);
    insert into player_learns_hissatsu values (2252, 230, null, 3);
    insert into player_learns_hissatsu values (2321, 164, null, 3);
end
&&
delimiter ;
call proc_insert_player_basic();
