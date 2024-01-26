/*
source /home/alejandro/Desktop/projects/choujigen3mysql/sql/procfunc/proc_insert_hissatsu.sql
*/
drop temporary table if exists aux_hissatsu;
create temporary table aux_hissatsu (
    item_hissatsu_id int,
    name varchar(32),
    base_power int,
    price varchar(32),
    tp int,
    characteristic varchar(32),
    learners varchar(32),
    participant varchar(1000),
    obtention varchar(1000),
    growth_type varchar(32),
    growth_rate varchar(32),
    attri varchar(32),
    type varchar(32),
    foul varchar(32),
    blocks varchar(32),
    catch_type varchar(32),
    effect_ja varchar(1000),
    effect_en varchar(1000),
    effect_es varchar(1000)
);

load data infile '/home/alejandro/Desktop/projects/choujigen3mysql/csv/hissatsu.csv'
into table aux_hissatsu 
fields terminated by ',' 
enclosed by '"'
lines terminated by '\n'
ignore 2 lines
(item_hissatsu_id, name, base_power, price, tp, characteristic, learners, 
    participant, obtention, growth_type, growth_rate, attri, type, foul, blocks,
    catch_type, effect_ja, effect_en, effect_es);

delimiter &&
drop procedure if exists proc_insert_hissatsu;
create procedure proc_insert_hissatsu()
begin
	declare i int default 0;
    declare intIsBlock int default 0;
    declare intParticipant int default 0;
    declare intFoul int default 0;
    declare idGrowthType int default 0;
    declare idGrowthRate int default 0;
    declare idAttri int default 0;
    declare idCatchType int default 0;
    declare idType int default 0;
    declare idCharacteristic int default 0;

    /*cur1 variables*/
    declare vItemHissatsuId int default 0;
    declare vName varchar(32) default '';
    declare vBasePower int default 0;
    declare vPrice varchar(32) default '';
    declare vTp int default 0;
    declare vCharacteristic varchar(32) default '';
    declare vLearners varchar(32) default '';
    declare vParticipant varchar(1000) default '';
    declare vObtention varchar(1000) default '';
    declare vGrowthType varchar(32) default '';
    declare vGrowthRate varchar(32) default '';
    declare vAttri varchar(32) default '';
    declare vType varchar(32) default '';
    declare vFoul varchar(32) default '';
    declare vBlocks varchar(32) default '';
    declare vCatchType varchar(32) default '';
    declare vEffectJa varchar(1000) default '';
    declare vEffectEn varchar(1000) default '';
    declare vEffectEs varchar(1000) default '';

    declare continueCur1 int default 1;
    declare cur1 cursor for select * from aux_hissatsu;
	declare continue handler for SQLSTATE '02000' set continueCur1 = 0;

    delete from item_hissatsu;
    delete from hissatsu_evokes_attri;
    delete from hissatsu_evolves;
    delete from hissatsu_shoot;
    delete from hissatsu_dribble;
    delete from hissatsu_block;
    delete from hissatsu_catch;
    delete from hissatsu_skill;
    open cur1;
	while continueCur1=1 do
        fetch cur1 into vItemHissatsuId, vName, vBasePower, vPrice, vTp,
            vCharacteristic, vLearners, vParticipant, vObtention, vGrowthType,
            vGrowthRate, vAttri, vType, vFoul, vBlocks, vCatchType, vEffectJa,
            vEffectEn, vEffectEs;
        set idGrowthType = null;
        set idGrowthRate = null;
        set idAttri = null;
        set idType = null;
        set idCatchType = null;
        set idCharacteristic = null;
        if continueCur1 = 1 then
            /*general*/
            if vBlocks = 'x' then
                set intIsBlock = 1;
            else
                set intIsBlock = 0;
            end if;
    
            if vFoul = '' then
                set intFoul = 0;
            else
                set intFoul = cast(vFoul as unsigned);
            end if;
            
            if vParticipant = '' then 
                set intParticipant = 1;
            else
                set vParticipant = substring(vParticipant, 1, 1);
                set intParticipant = cast(vParticipant as unsigned);
            end if;
            
            if vGrowthType != '' then
                select growth_type_id into idGrowthType from growth_type
                    where growth_type_name_ja 
                    like concat(concat('%', vGrowthType), '%');
            end if;

            if vGrowthRate != '' then
                select growth_rate_id into idGrowthRate from growth_rate
                    where growth_rate_name_ja 
                    like concat(concat('%', vGrowthRate), '%');
            end if;

            if vAttri != '' then
                select attri_id into idAttri from attri
                    where attri_name_ja 
                    like concat(concat('%', vAttri), '%');
            end if;

            if vCatchType != '' then
                select catch_type_id into idCatchType from catch_type
                    where catch_type_name_ja = vCatchType;
            end if;

            select hissatsu_type_id into idType from hissatsu_type
                where hissatsu_type_name_ja = vType;

            case
                when vCharacteristic like '%SC%' then
                    set idCharacteristic = 1;
                when vCharacteristic like '%ロング%' then
                    set idCharacteristic = 2;
                when vCharacteristic like '%SB%' then
                    set idCharacteristic = 3;
                else
                    set idCharacteristic = null;
            end case;

            /*insert hissatsu*/
            insert into item_hissatsu values (vItemHissatsuId, idType);

            /*insert attri*/
            if idAttri is not null then
                insert into hissatsu_evokes_attri 
                    values (vItemHissatsuId, idAttri);
            end if;

            /*insert evolution*/
            if idGrowthType is not null then
                insert into hissatsu_evolves 
                    values (vItemHissatsuId, idGrowthType, idGrowthRate);
            end if;

            /*insert subtype*/
            case
                when vType = 'シュート' then
                    insert into hissatsu_shoot 
                        values (vItemHissatsuId, vBasePower, vTp, intParticipant);
                    if idCharacteristic is not null then
                        insert into 
                            hissatsu_shoot_can_have_shoot_special_property
                            values (vItemHissatsuId, idCharacteristic);
                    end if;
                when vType = 'ドリブル' then
                    insert into hissatsu_dribble
                        values (vItemHissatsuId, vBasePower, vTp, 
                        intParticipant, vFoul);
                when vType = 'ブロック' then
                    insert into hissatsu_block
                        values (vItemHissatsuId, vBasePower, vTp, 
                        intParticipant, vFoul, intIsBlock);
                when vType = 'キャッチ' then
                    insert into hissatsu_catch
                        values (vItemHissatsuId, vBasePower, vTp, 
                        intParticipant, idCatchType);
                when vType = 'スキル' then
                    insert into hissatsu_skill
                        values (vItemHissatsuId, vEffectJa, vEffectEn, 
                        vEffectEs);
            end case;

            /*insert restriction*/

            /*
            select vItemHissatsuId, idGrowthType, idGrowthRate;
            set statName = substring(vEffect, 1, char_length(vEffect)-3);
            select stat_id into statId from stat 
                where stat_name_ja like statName;
            */
        end if;
	end while;
	close cur1;
    drop temporary table if exists aux_hissatsu;
end
&&
delimiter ;
call proc_insert_hissatsu();
