
with consumption as (
	select 
		survey_id
		, h.id as household_id
		, ffi.food_vehicle_id
		, sum(fortifiable_portion) as sum 
	from household_consumption hc 
	join household h on h.id = hc.household_id 
	left join fortifiable_food_items ffi on ffi.food_genus_id = hc.food_genus_id 
	where survey_id = 1
	group by survey_id, h.id, ffi.food_vehicle_id
),
fortifiable_extent_json as (
select intervention_id, (baseline_assumptions->>'potentiallyFortified')::jsonb as fortifiable from intervention_baseline_assumptions iba 
),
fortification_implemented as (
select intervention_id, 
	(fortifiable->>'year0')::numeric > 0 as year_0,
	(fortifiable->>'year1')::numeric > 0 as year_1, 
	(fortifiable->>'year2')::numeric > 0 as year_2,
	(fortifiable->>'year3')::numeric > 0 as year_3,
	(fortifiable->>'year4')::numeric > 0 as year_4,
	(fortifiable->>'year5')::numeric > 0 as year_5,
	(fortifiable->>'year6')::numeric > 0 as year_6,
	(fortifiable->>'year7')::numeric > 0 as year_7,
	(fortifiable->>'year8')::numeric > 0 as year_8,
	(fortifiable->>'year9')::numeric > 0 as year_9
from fortifiable_extent_json
),
hh_stats as (
	select 
		survey_id
		, food_vehicle_id
		, count(household_id) as reached
		, (select count(*) from household c2 where c2.survey_id=c.survey_id) as total 
	from consumption c 
	where sum > 0 
	group by survey_id, food_vehicle_id
),
survey_reach as (
	select survey_id, food_vehicle_id, reached, total, (reached::numeric/total::numeric) as household_reach from hh_stats
),
ten_year_households as (
select 
	country_id
	, (population_2021 + population_2022 + population_2023 + population_2024 + population_2025 + population_2026 + population_2027 + population_2028 + population_2029 + population_2030) as ten_year_households
from intervention_projected_households iph where iph.admin_level = 0
),
ten_year_population as (
select 
	country_id
	, (population_2021 + population_2022 + population_2023 + population_2024 + population_2025 + population_2026 + population_2027 + population_2028 + population_2029 + population_2030) as ten_year_population
from intervention_projected_population ipp where ipp.admin_level = 0
),
ten_year_reach as (
	select 
		survey_id
		, tyh.country_id
		, food_vehicle_id
		, ten_year_households
		, ten_year_population
		, household_reach
		, (household_reach*ten_year_households) as ten_year_hh_reach
		, (household_reach*ten_year_population) as ten_year_pop_reach
	from survey_reach, ten_year_households tyh, ten_year_population typ
)


select 
    intervention_id
    , year_0 as ten_year_cost
    , tyr.ten_year_households
    , tyr.ten_year_population
    , tyr.household_reach as household_reach_perc
    , tyr.ten_year_hh_reach
    , tyr.ten_year_pop_reach
    , year_0/ten_year_hh_reach as average_annual_cost_per_hh_consuming
    , year_0/ten_year_pop_reach as average_annual_cost_per_person_consuming
	from intervention_data id 
	join intervention i on i.id = id.intervention_id 
	left join consumption_data_sources cds on cds.country_id = i.country_id and cds.consumption_data_type = 'household'
	join ten_year_reach tyr on tyr.survey_id = cds.consumption_data_id and tyr.country_id = i.country_id and tyr.food_vehicle_id = i.food_vehicle_id 
	where id.row_name = 'summary_10yr_startup_and_recurring_cost';
