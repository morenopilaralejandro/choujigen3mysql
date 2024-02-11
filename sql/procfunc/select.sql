/*select*/
/*select-zone*/
select z.zone_id from `zone` z where z.zone_name_es like 'barrio de tiendas' and z.zone_type = 3\G

/*select-zone-level*/
/*----------------------------------------------------------------------------*/
SET @var_zone_level_id := 220;
select 
lvl.zone_level_id,
inn.zone_inner_id,
oute.zone_outer_id,
zlvl.zone_name_es,
zinn.zone_name_es,
zoute.zone_name_es

from zone_level lvl

join zone_inner inn 
on lvl.zone_inner_id = inn.zone_inner_id

join zone_outer oute 
on oute.zone_outer_id = inn.zone_outer_id

join zone zlvl
on zlvl.zone_id = lvl.zone_level_id

join zone zinn
on zinn.zone_id = inn.zone_inner_id

join zone zoute
on zoute.zone_id = oute.zone_outer_id

where lvl.zone_level_id = @var_zone_level_id\G
/*select-zone-level-by-zone_id*/
/*----------------------------------------------------------------------------*/
select 
lvl.zone_level_id,
inn.zone_inner_id,
oute.zone_outer_id,
zlvl.zone_name_es,
zinn.zone_name_es,
zoute.zone_name_es

from zone_level lvl

join zone_inner inn 
on lvl.zone_inner_id = inn.zone_inner_id

join zone_outer oute 
on oute.zone_outer_id = inn.zone_outer_id

join zone zlvl
on zlvl.zone_id = lvl.zone_level_id

join zone zinn
on zinn.zone_id = inn.zone_inner_id

join zone zoute
on zoute.zone_id = oute.zone_outer_id

where lvl.zone_level_id in ( 
    select z.zone_id from zone z 
    where z.zone_name_es like 'barrio de tiendas' and z.zone_type_id = 3
)\G

/*select-zone-building*/
/*----------------------------------------------------------------------------*/
SET @var_zone_building_id := 107;
select 
bld.zone_building_id,
lvl.zone_level_id,
inn.zone_inner_id,
oute.zone_outer_id,
zbld.zone_name_es,
zlvl.zone_name_es,
zinn.zone_name_es,
zoute.zone_name_es

from zone_building bld

join zone_level lvl
on bld.zone_level_id = lvl.zone_level_id

join zone_inner inn 
on lvl.zone_inner_id = inn.zone_inner_id

join zone_outer oute 
on oute.zone_outer_id = inn.zone_outer_id

join zone zbld
on zbld.zone_id = bld.zone_building_id

join zone zlvl
on zlvl.zone_id = lvl.zone_level_id

join zone zinn
on zinn.zone_id = inn.zone_inner_id

join zone zoute
on zoute.zone_id = oute.zone_outer_id

where bld.zone_building_id = @var_zone_building_id\G

/*select-zone-building-floor*/
/*----------------------------------------------------------------------------*/
select 
flr.zone_building_floor_id,
zfld.zone_name_es

from zone_building_floor flr

join zone zfld
on zfld.zone_id = flr.zone_building_floor_id

where flr.zone_building_id = @var_zone_building_id\G
