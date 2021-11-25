
create or replace view bad_biomarker_vals
as
select 
filename,
survey_name, 
household_id, 
person_id,
case when ferritin::numeric > 999 then ferritin::text || ' GREATER THAN 999' else ferritin::text end as ferritin 
,case when  stfr::numeric > 99 then stfr::text || ' GREATER THAN 999' else stfr::text end as stfr
,case when  rbp::numeric > 99 then rbp::text || ' GREATER THAN 999' else rbp::text end as rbp
,case when  retinol::numeric > 99 then retinol::text || ' GREATER THAN 999' else retinol::text end as retinol
,case when  rbc_folate::numeric > 1999 then rbc_folate::text || ' GREATER THAN 1999' else rbc_folate::text end as rbc_folate
,case when  ps_folate::numeric > 999 then ps_folate::text || ' GREATER THAN 999' else ps_folate::text end as ps_folate
,case when  vitamin_b12::numeric > 9999 then vitamin_b12::text || ' GREATER THAN 999' else vitamin_b12::text end as vitamin_b12
,case when  zinc::numeric > 999 then zinc::text || ' GREATER THAN 999' else zinc::text end as zinc
,case when  crp::numeric > 999 then crp::text || ' GREATER THAN 999' else crp::text end as crp
,case when  agp::numeric > 999 then agp::text || ' GREATER THAN 999' else agp::text end as agp
,case when  iodine::numeric > 999 then iodine::text || ' GREATER THAN 999' else iodine::text end as iodine
,case when  height_in_cm::numeric > 300 or height_in_cm::numeric < 30 then height_in_cm || 'UNLIKELY VALUE' else height_in_cm end as height_in_cm
,case when  weight_in_kg::numeric > 200 or weight_in_kg::numeric < 3 then weight_in_kg || 'UNLIKELY VALUE' else weight_in_kg end as weight_in_kg
,case when  selenium::numeric > 9999 then selenium || 'UNLIKELY VALUE' else selenium end as selenium
/*
 , ferritin                numeric(5,2)
    , stfr                    numeric(4,2)
    , rbp                     numeric(4,2)
    , retinol                 numeric(4,2)
    , rbc_folate              numeric(5,1)
    , ps_folate               numeric(3,1)
    , vitamin_b12             numeric(5,1)
    , zinc                    numeric(4,1)
    , crp                     numeric(5,2)
    , agp                     numeric(5,2)
    , iodine                  numeric(5,2)
*/
from biomarker_import_vol
where 
ferritin::numeric > 999 or
stfr::numeric > 99 or
rbp::numeric > 99 or
retinol::numeric > 99 or
rbc_folate::numeric > 1999 or
ps_folate::numeric > 999 or
vitamin_b12::numeric > 9999 or
zinc::numeric > 999 or
crp::numeric > 999 or
agp::numeric > 999 or
iodine::numeric > 999 or
(height_in_cm::numeric > 300 or height_in_cm::numeric < 30) or
(weight_in_kg::numeric > 200 or weight_in_kg::numeric < 3) or
(selenium::numeric > 9999)
;