CREATE OR REPLACE FUNCTION _final_median(numeric[])
   RETURNS numeric AS
$$
   SELECT AVG(val)
   FROM (
     SELECT val
     FROM unnest($1) val
     ORDER BY 1
     LIMIT  2 - MOD(array_upper($1, 1), 2)
     OFFSET CEIL(array_upper($1, 1) / 2.0) - 1
   ) sub;
$$
LANGUAGE 'sql' IMMUTABLE;

CREATE or replace AGGREGATE median(numeric) (
  SFUNC=array_append,
  STYPE=numeric[],
  FINALFUNC=_final_median,
  INITCOND='{}'
);

create or replace view household_intake_sebregion AS
select subregion.country as country_id, household_intake.survey_id, subregion.id as subregion_id, subregion.name as subregion_name, fct_source_id, 
    median(moisture_in_g              )  as moisture_in_g
    , median(energy_in_kcal             )  as energy_in_kcal
    , median(energy_in_kj               )  as energy_in_kj
    , median(nitrogen_in_g              )  as nitrogen_in_g
    , median(totalprotein_in_g          )  as totalprotein_in_g
    , median(totalfats_in_g             )  as totalfats_in_g
    , median(saturatedfa_in_g           )  as saturatedfa_in_g
    , median(monounsaturatedfa_in_g     )  as monounsaturatedfa_in_g
    , median(polyunsaturatedfa_in_g     )  as polyunsaturatedfa_in_g
    , median(cholesterol_in_mg          )  as cholesterol_in_mg
    , median(carbohydrateavailable_in_g )  as carbohydrateavailable_in_g
    , median(fibre_in_g                 )  as fibre_in_g
    , median(ash_in_g                   )  as ash_in_g
    , median(ca_in_mg                   )  as ca_in_mg
    , median(fe_in_mg                   )  as fe_in_mg
    , median(mg_in_mg                   )  as mg_in_mg
    , median(p_in_mg                    )  as p_in_mg
    , median(k_in_mg                    )  as k_in_mg
    , median(na_in_mg                   )  as na_in_mg
    , median(zn_in_mg                   )  as zn_in_mg
    , median(cu_in_mg                   )  as cu_in_mg
    , median(mn_in_mcg                  )  as mn_in_mcg
    , median(i_in_mcg                   )  as i_in_mcg
    , median(se_in_mcg                  )  as se_in_mcg
    , median(vitamina_in_rae_in_mcg     )  as vitamina_in_rae_in_mcg
    , median(thiamin_in_mg              )  as thiamin_in_mg
    , median(riboflavin_in_mg           )  as riboflavin_in_mg
    , median(niacin_in_mg               )  as niacin_in_mg
    , median(vitaminb6_in_mg            )  as vitaminb6_in_mg
    , median(folicacid_in_mcg           )  as folicacid_in_mcg
    , median(folate_in_mcg              )  as folate_in_mcg
    , median(vitaminb12_in_mcg          )  as vitaminb12_in_mcg
    , median(pantothenate_in_mg         )  as pantothenate_in_mg
    , median(biotin_in_mcg              )  as biotin_in_mcg
    , median(vitaminc_in_mg             )  as vitaminc_in_mg
    , median(vitamind_in_mcg            )  as vitamind_in_mcg
    , median(vitamine_in_mg             )  as vitamine_in_mg
    , median(phyticacid_in_mg           )  as phyticacid_in_mg

from 
household_intake 
join household on household.id=household_intake.household_id 
join subregion on ST_CONTAINS(subregion.geometry, household.location)
group by subregion_id, household_intake.survey_id, fct_source_id;


CREATE OR REPLACE FUNCTION get_subregion_intake_geoJSON(_subregion_id text, _fct_id numeric, _survey_id numeric, _micronutrient text)
RETURNS json AS

$BODY$
  declare
  	retval json;
begin
	
	execute '

SELECT row_to_json(fc)
 FROM ( SELECT ''FeatureCollection'' As type, array_to_json(array_agg(f)) As features
 FROM (SELECT ''Feature'' As type
    , public.ST_AsGeoJSON(public.ST_ForcePolygonCCW(c2.geometry))::json As geometry
    , row_to_json(ci) As properties
   FROM household_intake_sebregion
INNER JOIN (SELECT country_id
         					,' || $4 || ' as mn_absolute
         					, micronutrient.unit as mn_absolute_unit
         					, subregion_name as subregion_name
         					, ''District'' as subregion_type
         					FROM household_intake_sebregion 
							JOIN micronutrient on micronutrient.fooditem_column = ''' || $4 || '''
         					where household_intake_sebregion.fct_source_id=' || $2 || ' and household_intake_sebregion.survey_id=' || $3 || '
         					) As ci 
       ON household_intake_sebregion.country_id = ci.country_id 
       join subregion c2 on c2.id = household_intake_sebregion.subregion_id 
       where household_intake_sebregion.subregion_id=''' || $1 || '''
       ) As f )  As fc
       ' INTO retval using _subregion_id, _fct_id, _survey_id, _micronutrient;
    RETURN retval;
    END
$BODY$
LANGUAGE plpgsql;


DROP MATERIALIZED VIEW IF EXISTS subregion_intake_geojson;
CREATE MATERIALIZED VIEW subregion_intake_geojson AS

select hi.country_id, hi.subregion_id, hi.fct_source_id, hi.survey_id, mn.mn_name, mn.mn_value, geojson.* 
from household_intake_sebregion hi
     CROSS JOIN LATERAL (select id, fooditem_column from micronutrient)
		AS mn("mn_name", "mn_value")
		, get_subregion_intake_geoJSON(hi.subregion_id, hi.fct_source_id, hi.survey_id, mn.mn_value) geojson;

