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
),
lsff_levels as (
select 
	b.*
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'Ca' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "Ca"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'I' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "I"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'Fe' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "Fe"
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
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'D' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "D"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'E' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "E"
	, (select standard from standards s where s.intervention_id=b.intervention_id and s.micronutrient_id = 'Zn' ) 
		* b.perc_fortifiable * b.perc_fortified * b.	perc_average_fortification_level as "Zn"
from baseline b
),
---
---
---
bf_state as (
	select 
		intervention_id
		, unnest(array['2021','2022','2023','2024','2025','2026','2027','2028','2029','2030']) AS "Year"
		, i.food_vehicle_id as fortification_vehicle_id
		, i.focus_micronutrient
		, fv.vehicle_name as fortification_vehicle_name
		, unnest(array[year_0
		, year_1
		, year_2
		, year_3
		, year_4
		, year_5
		, year_6
		, year_7
		, year_8
		, year_9]) as perc_replaced_with_bf
		, bmc.bf_add_mn_content 
	from intervention_data id 
	join intervention i on i.id = id.intervention_id and i.intervention_nature = id.intervention_nature and i.intervention_status = id.intervention_status 
	join food_vehicle fv on fv.id = i.food_vehicle_id 
	join biofortification_mn_content bmc on 
		bmc.micronutrient_id = i.focus_micronutrient 
		and bmc.food_vehicle_id = i.food_vehicle_id 
	where fortification_type_id = 'BF'
	and id.row_name = 'farmer_adoption_rate_total'
),
af_state as (
	select 
		intervention_id
		, unnest(array['2021','2022','2023','2024','2025','2026','2027','2028','2029','2030']) AS "Year"
		, i.food_vehicle_id as fortification_vehicle_id
		, i.focus_micronutrient
		, fv.vehicle_name as fortification_vehicle_name
		, unnest(array[year_0
		, year_1
		, year_2
		, year_3
		, year_4
		, year_5
		, year_6
		, year_7
		, year_8
		, year_9]) as perc_replaced_with_af
		, coalesce(amc.af_add_mn_content,0) as af_add_mn_content
	from intervention_data id 
	join intervention i on i.id = id.intervention_id and i.intervention_nature = id.intervention_nature and i.intervention_status = id.intervention_status 
	join food_vehicle fv on fv.id = i.food_vehicle_id 
	join agrofortification_mn_content amc on 
		amc.micronutrient_id = i.focus_micronutrient 
		and amc.food_vehicle_id = i.food_vehicle_id 
		and amc.application_type = 'foliar'
	where fortification_type_id = 'AF'
	and id.row_name = 'farmer_adoption_rate_granular'
),
bf_levels as (
	select
		intervention_id
		, "Year"
		, fortification_vehicle_id
		, fortification_vehicle_name
		, 0 as perc_fortifiable
		, 0 as perc_fortified
		, 0 as perc_average_fortification_level
		, case when focus_micronutrient='Ca' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "Ca"
		, case when focus_micronutrient='I' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "I"
		, case when focus_micronutrient='Fe' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "Fe"
		, case when focus_micronutrient='A' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "A"
		, case when focus_micronutrient='B12' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "B12"
		, case when focus_micronutrient='B2' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "B2"
		, case when focus_micronutrient='B3' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "B3"
		, case when focus_micronutrient='B9' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "B9"
		, case when focus_micronutrient='D' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "D"
		, case when focus_micronutrient='E' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "E"
		, case when focus_micronutrient='Zn' then perc_replaced_with_bf * bf_add_mn_content else 0 end as "Zn"
		from bf_state
),
af_levels as (
	select
		intervention_id
		, "Year"
		, fortification_vehicle_id
		, fortification_vehicle_name
		, 0 as perc_fortifiable
		, 0 as perc_fortified
		, 0 as perc_average_fortification_level
		, case when focus_micronutrient='Ca' then perc_replaced_with_af * af_add_mn_content else 0 end as "Ca"
		, case when focus_micronutrient='I' then perc_replaced_with_af * af_add_mn_content else 0 end as "I"
		, case when focus_micronutrient='Fe' then perc_replaced_with_af * af_add_mn_content else 0 end as "Fe"
		, case when focus_micronutrient='A' then perc_replaced_with_af * af_add_mn_content else 0 end as "A"
		, case when focus_micronutrient='B12' then perc_replaced_with_af * af_add_mn_content else 0 end as "B12"
		, case when focus_micronutrient='B2' then perc_replaced_with_af * af_add_mn_content else 0 end as "B2"
		, case when focus_micronutrient='B3' then perc_replaced_with_af * af_add_mn_content else 0 end as "B3"
		, case when focus_micronutrient='B9' then perc_replaced_with_af * af_add_mn_content else 0 end as "B9"
		, case when focus_micronutrient='D' then perc_replaced_with_af * af_add_mn_content else 0 end as "D"
		, case when focus_micronutrient='E' then perc_replaced_with_af * af_add_mn_content else 0 end as "E"
		, case when focus_micronutrient='Zn' then perc_replaced_with_af * af_add_mn_content else 0 end as "Zn"
		from af_state
)
	
select * from lsff_levels 
union
select * from bf_levels
union
select * from af_levels
order by intervention_id, "Year";