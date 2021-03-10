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

create or replace view household_intake_sebregion_pivot as 
select hi.country_id, hi.survey_id, hi.fct_source_id, hi.subregion_id, hi.subregion_name, mn.mn_name, mn.mn_value from household_intake_sebregion hi
		CROSS JOIN LATERAL (
			VALUES
				('A'           , VitaminA_in_RAE_in_mcg     ),
				('B6'          , VitaminB6_in_mg            ),
				('B12'         , VitaminB12_in_mcg          ),
				('C'           , VitaminC_in_mg             ),
				('D'           , VitaminD_in_mcg            ),
				('E'           , VitaminE_in_mg             ),
				('B1'          , Thiamin_in_mg              ),
				('B2'          , Riboflavin_in_mg           ),
				('B3'          , Niacin_in_mg               ),
				('Folic Acid'  , Folicacid_in_mcg           ),
				('B9'          , Folate_in_mcg              ),
				('B5'          , Pantothenate_in_mg         ),
				('B7'          , Biotin_in_mcg              ),
				('IP6'         , PhyticAcid_in_mg           ),
				('Ca'          , Ca_in_mg                   ),
				('Cu'          , Cu_in_mg                   ),
				('Fe'          , Fe_in_mg                   ),
				('Mg'          , Mg_in_mg                   ),
				('Mn'          , Mn_in_mcg                  ),
				('P'           , P_in_mg                    ),
				('K'           , K_in_mg                    ),
				('Na'          , Na_in_mg                   ),
				('Zn'          , Zn_in_mg                   ),
				('I'           , I_in_mcg                   ),
				('N'           , Nitrogen_in_g              ),
				('Se'          , Se_in_mcg                  ),
				('Ash'         , Ash_in_g                   ),
				('Fibre'       , Fibre_in_g                 ),
				('Carbohydrate', Carbohydrateavailable_in_g ),
				('Cholesterol' , Cholesterol_in_mg          ),
				('Protein'     , TotalProtein_in_g          ),
				('Fat'         , TotalFats_in_g             ),
				('Energy'      , Energy_in_kCal             ),
				('Moisture'    , Moisture_in_g              )
		) AS mn("mn_name", "mn_value");
	

--TODO: JOIN this against household_intake_subregion to generate geojson for all 
-- country/survey/fct combinations.

	DROP MATERIALIZED VIEW IF EXISTS subregion_intake_geojson;
create or replace materialized view subregion_intake_geojson as

select hisp.*, (SELECT row_to_json(fc)
 FROM ( SELECT 'FeatureCollection' As type, array_to_json(array_agg(f)) As features
 FROM (SELECT 'Feature' As type
    , ST_AsGeoJSON(ST_ForcePolygonCCW(lg.geometry))::json As geometry
    , row_to_json((SELECT l FROM (
    			SELECT 
    			mn_value as mn_absolute
    			,micronutrient.unit as mn_absolute_unit
    			,'0' as mn_threshold
         		, '%' as mn_threshold_unit
         		, subregion_name as subregion_name
         		, 'District' as subregion_type
    			from household_intake_sebregion_pivot 
    			JOIN micronutrient on micronutrient.id=hisp.mn_name 
    			where 
    				subregion_id=lg.id
    				and survey_id = hisp.survey_id 
    				and fct_source_id = hisp.fct_source_id 
    				and mn_name=hisp.mn_name 
    			) As l)) As properties
   FROM subregion as lg where country = hisp.country_id ) As f )  As fc) as geojson from household_intake_sebregion_pivot hisp;


