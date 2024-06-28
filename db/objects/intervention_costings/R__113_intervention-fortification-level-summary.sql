create or replace view intervention_fortification_level_summary as

with fortificant_targets as (
select 
	intervention_id, 
	((unnest(food_vehicle_standard))->>'micronutrient')::text as micronutrient_id, 
	((json_array_elements((unnest(food_vehicle_standard))->'compounds'))->>'targetVal')::numeric as target_val
from intervention_vehicle_standard ivs
)
,
standards as (
select
	intervention_id,
	micronutrient_id,
	max(target_val) as standard
from fortificant_targets
group by intervention_id, micronutrient_id
),
fortifiable as (
select * 
from intervention_data id 
where header1 = 'Program assumptions' 
	and header2 = 'Performance over time' 
	and row_name = 'fortifiable_vehicle_pct'
),
fortified as (
select * 
from intervention_data id 
where header1 = 'Program assumptions' 
	and header2 = 'Performance over time' 
	and row_name = 'fortified_fortifiable_vehicle_pct'
),
average as (
select * 
from intervention_data id 
where header1 = 'Program assumptions' 
	and header2 = 'Performance over time' 
	and row_name = 'avg_level_fortified_fortifiable_vehicle_pct'
),
baseline as (
select
   fortifiable.intervention_id
   , unnest(array['2021','2022','2023','2024','2025','2026','2027','2028','2029','2030']) AS "Year"
   , intervention.food_vehicle_id as fortification_vehicle_id
   , food_vehicle.vehicle_name as fortification_vehicle_name
   , unnest(array[fortifiable.year_0, fortifiable.year_1, fortifiable.year_2,fortifiable.year_3,fortifiable.year_4,fortifiable.year_5,fortifiable.year_6,fortifiable.year_7,fortifiable.year_8,fortifiable.year_9]) AS "perc_fortifiable"
   , unnest(array[fortified.year_0, fortified.year_1, fortified.year_2,fortified.year_3,fortified.year_4,fortified.year_5,fortified.year_6,fortified.year_7,fortified.year_8,fortified.year_9]) AS "perc_fortified"
   , unnest(array[average.year_0, average.year_1, average.year_2,average.year_3,average.year_4,average.year_5,average.year_6,average.year_7,average.year_8,average.year_9]) AS "perc_average_fortification_level"
from 
	fortifiable 
		join fortified on fortifiable.intervention_id = fortified.intervention_id
		join average on fortifiable.intervention_id = average.intervention_id
		join intervention on intervention.id = fortifiable.intervention_id
		join food_vehicle on food_vehicle.id = intervention.food_vehicle_id 
order by intervention_id, "Year"
)

select 
	b.*
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'A' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "A"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'B12' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "B12"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'B2' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "B2"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'B3' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "B3"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'B9' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "B9"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'Fe' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "Fe"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'Zn' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "Zn"
from baseline b;
