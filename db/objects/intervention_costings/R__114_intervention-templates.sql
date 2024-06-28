create or replace view intervention_templates as

with int_mns as (
	select 
		intervention_id
		, unnest(food_vehicle_standard)->>'micronutrient' as micronutrient 
	from intervention_vehicle_standard
),

int_fvs as (
 select country_id, 
	 json_build_object(micronutrient, jsonb_object_aggregate(
	 			jsonb_build_object(food_vehicle_name, id)
	 		)
	 	
	 )
 as interventions
 
 from intervention_list i
 	cross join int_mns m where i.id = m.intervention_id
 and is_premade = true group by country_id, micronutrient
),

int_country as (
	select country_id, jsonb_object_aggregate(interventions::jsonb) as interventions from int_fvs group by country_id
)
  
select 
	1 as id, json_object_agg(country_id, interventions) as templates
from int_country;