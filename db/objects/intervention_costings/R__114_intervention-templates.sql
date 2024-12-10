create or replace view intervention_templates as

with lsff_mns as (
	select 
		intervention_id
		, 'LSFF' as fortification_type_id
		, unnest(food_vehicle_standard)->>'micronutrient' as micronutrient 
	from intervention_vehicle_standard
),
bf_mns as (
	select 
		id as intervention_id
		, fortification_type_id 
		, focus_micronutrient as micronutrient
	from intervention i 
	where i.is_premade = true and i.fortification_type_id = 'BF'
),
int_mns as (
	select * from lsff_mns
	union
	select * from bf_mns
),
food_vehicle_agg as (
 select country_id, 
 	micronutrient,
	 json_build_object(m.fortification_type_id, jsonb_object_aggregate(
	 			jsonb_build_object(food_vehicle_name, id)
	 		)
	 	
	 )
 as interventions
 
 from intervention_list i
 	cross join int_mns m where i.id = m.intervention_id
 and is_premade = true group by country_id, m.fortification_type_id, micronutrient
),
fortification_type_agg as (
	select country_id, micronutrient, json_build_object(micronutrient, jsonb_object_aggregate(interventions::jsonb)) as interventions from food_vehicle_agg
	group by country_id, micronutrient
),
int_country as (
	select country_id, jsonb_object_aggregate(interventions::jsonb) as interventions from fortification_type_agg group by country_id
)
  
select 
	1 as id, json_object_agg(country_id, interventions) as templates
from int_country;