/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_get_hissatsu_by_name.sql

SELECT count(h.item_hissatsu_id), i.item_name_ja 
FROM `item_hissatsu` h 
JOIN item i on i.item_id = h.item_hissatsu_id
group BY i.item_name_ja HAVING count(h.item_hissatsu_id) > 1;

SELECT plh.player_id, COUNT(plh.player_id) 
FROM `player_learns_hissatsu` plh 
GROUP by plh.player_id HAVING COUNT(plh.player_id)<4;

SELECT `player_name_ja` FROM `player` where `player_id` = 1072

call proc_get_player_by_name('asd');

hissatsu_type
1 シュート
2 ドリブル
3 ブロック
4 キャッチ
5 スキル

*/
delimiter &&
drop procedure if exists proc_get_hissatsu_by_name;
create procedure proc_get_hissatsu_by_name(in name varchar(32))
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
    declare hissatsuTypeNameJa varchar(32) default '';
    declare attriNameJa varchar(32) default '';
    declare basePower int default 0;
    declare tp int default 0;
    declare participants int default 0;
    declare additionalPower int default 0;
    declare maxPower int default 0;
    declare growthTypeNameJa varchar(32) default '';
    declare growthRateNameJa varchar(32) default '';
    declare foul int default 0;
    declare isBlock int default 0;
    declare shootPropertyJa varchar(32) default '';
    declare catchTypeJa varchar(32) default '';
    declare skillEffectJa varchar(400) default '';
    declare skillEffectEn varchar(400) default '';
    declare skillEffectEs varchar(400) default '';

    /*cur1 variables*/
    declare itemId int default 0;
    declare itemNameJa varchar(32) default '';
    declare itemNameEn varchar(32) default '';
    declare itemNameEs varchar(32) default '';
    declare hissatsuTypeId int default 0;

    declare continueCur1 int default 1;
    declare cur1 cursor for 
        select
            i.item_id,
            i.item_name_ja,
            i.item_name_en,
            i.item_name_es,
            h.hissatsu_type_id
        from
            item i
        join item_hissatsu h on
            i.item_id = h.item_hissatsu_id
        where
            i.item_name_ja = name or 
            i.item_name_en = name or 
            i.item_name_es = name;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    open cur1;
	while continueCur1=1 do
        fetch cur1 into itemId, itemNameJa, itemNameEn, 
            itemNameEs, hissatsuTypeId;

        set hissatsuTypeNameJa = null;
        set attriNameJa = null;
        set basePower = null;
        set tp = null;
        set participants = null;
        set additionalPower = null;
        set maxPower = null;
        set growthTypeNameJa = null;
        set growthRateNameJa = null;
        set foul = null;
        set isBlock = null;
        set shootPropertyJa = null;
        set catchTypeJa = null;
        set skillEffectJa = null;
        set skillEffectEn = null;
        set skillEffectEs = null;

        if continueCur1 = 1 then
            if i > 0 then
                select '------------------------------------------------------' 
                    as '------------------------------------------------------';
            else
                select asciiStart as 'start';
            end if;

            /*type*/
            select hissatsu_type_name_ja into hissatsuTypeNameJa 
                from hissatsu_type
                where hissatsu_type_id = hissatsuTypeId;
            /*attri*/
            select a.attri_name_ja into attriNameJa 
                from hissatsu_evokes_attri het
                join attri a on het.attri_id = a.attri_id
                where het.item_hissatsu_id = itemId;
            set continueCur1 = 1;

            


            /*basic*/
            select itemId 'id', attriNameJa 'at', hissatsuTypeNameJa 'type', 
                itemNameJa 'NameJa';

            /*
            hissatsu_type
                1 シュート
                2 ドリブル
                3 ブロック
                4 キャッチ
                5 スキル
            */
            case 
                when hissatsuTypeId = 1 then
                    select h.hissatsu_shoot_power, h.hissatsu_shoot_tp, 
                        h.hissatsu_shoot_participants, achive.additional_power,
                        gt.growth_type_name_ja, gr.growth_rate_name_ja
                        into basePower, tp, participants, additionalPower,
                        growthTypeNameJa, growthRateNameJa
                        from hissatsu_shoot h
                        join hissatsu_evolves he 
                        on h.item_hissatsu_id = he.item_hissatsu_id
                        join growth_type gt 
                        on gt.growth_type_id = he.growth_type_id
                        join growth_rate gr 
                        on gr.growth_rate_id = he.growth_rate_id
                        join growth_type_can_achieve_growth_rate achive 
                        on achive.growth_type_id = gt.growth_type_id 
                        and achive.growth_rate_id = gr.growth_rate_id
                        where h.item_hissatsu_id = itemId;

                    select p.shoot_special_property_name_ja
                        into shootPropertyJa
                        from hissatsu_shoot h
                        join hissatsu_shoot_can_have_shoot_special_property can 
                        on h.item_hissatsu_id = can.item_hissatsu_id
                        join shoot_special_property p 
                        on p.shoot_special_property_id = 
                        can.shoot_special_property_id
                        where h.item_hissatsu_id = itemId;
                    set continueCur1 = 1;

                    set maxPower = basePower + additionalPower;

                    select basePower 'bs', maxPower 'mx', tp, participants 'pa',
                        shootPropertyJa;
                    select growthTypeNameJa 'ty', growthRateNameJa 'ra', 
                        additionalPower 'ad';

                when hissatsuTypeId = 2 then        
                    select h.hissatsu_dribble_power, h.hissatsu_dribble_tp, 
                        h.hissatsu_dribble_participants, achive.additional_power,
                        gt.growth_type_name_ja, gr.growth_rate_name_ja
                        into basePower, tp, participants, additionalPower,
                        growthTypeNameJa, growthRateNameJa
                        from hissatsu_dribble h
                        join hissatsu_evolves he 
                        on h.item_hissatsu_id = he.item_hissatsu_id
                        join growth_type gt 
                        on gt.growth_type_id = he.growth_type_id
                        join growth_rate gr 
                        on gr.growth_rate_id = he.growth_rate_id
                        join growth_type_can_achieve_growth_rate achive 
                        on achive.growth_type_id = gt.growth_type_id 
                        and achive.growth_rate_id = gr.growth_rate_id
                        where h.item_hissatsu_id = itemId; 

                    select hissatsu_dribble_foul 
                        into foul
                        from hissatsu_dribble h 
                        where h.item_hissatsu_id = itemId; 

                    set maxPower = basePower + additionalPower;
                    select basePower 'bs', maxPower 'mx', tp, participants 'pa',
                        foul 'fo';
                    select growthTypeNameJa 'ty', growthRateNameJa 'ra', 
                        additionalPower 'ad';

                when hissatsuTypeId = 3 then   
                    select h.hissatsu_block_power, h.hissatsu_block_tp, 
                        h.hissatsu_block_participants, achive.additional_power,
                        gt.growth_type_name_ja, gr.growth_rate_name_ja
                        into basePower, tp, participants, additionalPower,
                        growthTypeNameJa, growthRateNameJa
                        from hissatsu_block h
                        join hissatsu_evolves he 
                        on h.item_hissatsu_id = he.item_hissatsu_id
                        join growth_type gt 
                        on gt.growth_type_id = he.growth_type_id
                        join growth_rate gr 
                        on gr.growth_rate_id = he.growth_rate_id
                        join growth_type_can_achieve_growth_rate achive 
                        on achive.growth_type_id = gt.growth_type_id 
                        and achive.growth_rate_id = gr.growth_rate_id
                        where h.item_hissatsu_id = itemId;

                    select hissatsu_block_foul, hissatsu_block_is_block
                        into foul, isBlock
                        from hissatsu_block h
                        where h.item_hissatsu_id = itemId;

                    set maxPower = basePower + additionalPower;
                    select basePower 'bs', maxPower 'mx', tp, participants 'pa',
                        foul 'fo', isBlock 'bo';
                    select growthTypeNameJa 'ty', growthRateNameJa 'ra', 
                        additionalPower 'ad';

                when hissatsuTypeId = 4 then    
                    select h.hissatsu_catch_power, h.hissatsu_catch_tp, 
                        h.hissatsu_catch_participants, achive.additional_power,
                        gt.growth_type_name_ja, gr.growth_rate_name_ja
                        into basePower, tp, participants, additionalPower,
                        growthTypeNameJa, growthRateNameJa
                        from hissatsu_catch h
                        join hissatsu_evolves he 
                        on h.item_hissatsu_id = he.item_hissatsu_id
                        join growth_type gt 
                        on gt.growth_type_id = he.growth_type_id
                        join growth_rate gr 
                        on gr.growth_rate_id = he.growth_rate_id
                        join growth_type_can_achieve_growth_rate achive 
                        on achive.growth_type_id = gt.growth_type_id 
                        and achive.growth_rate_id = gr.growth_rate_id
                        where h.item_hissatsu_id = itemId;

                    select ct.catch_type_name_ja
                        into catchTypeJa
                        from hissatsu_catch h 
                        join catch_type ct on h.catch_type_id = ct.catch_type_id
                        where h.item_hissatsu_id = itemId;

                    set maxPower = basePower + additionalPower;
                    select basePower 'bs', maxPower 'mx', tp, participants 'pa',
                        catchTypeJa;
                    select growthTypeNameJa 'ty', growthRateNameJa 'ra', 
                        additionalPower 'ad';

                when hissatsuTypeId = 5 then  
                    select h.hissatsu_skill_effect_ja, 
                        h.hissatsu_skill_effect_en, h.hissatsu_skill_effect_es
                        into skillEffectJa, skillEffectEn, skillEffectEs
                        from hissatsu_skill h 
                        where h.item_hissatsu_id = itemId;

                    select skillEffectJa;
                    select skillEffectEn;
                    select skillEffectEs;
            end case;
            set i = i + 1;
        end if;
	end while;
	close cur1;
    select asciiEnd as 'end';
    select i as 'Total Rows'; 
end
&&
delimiter ;
call proc_get_hissatsu_by_name('スーパースキャン');
call proc_get_hissatsu_by_name('マキシマムファイア');
call proc_get_hissatsu_by_name('Heaven\'s Time');
call proc_get_hissatsu_by_name('ザ・マウンテン');
call proc_get_hissatsu_by_name('まおう・ザ・ハンド');
call proc_get_hissatsu_by_name('ちょうわざ！');
