CREATE OR REPLACE view intervention_summary_costs AS 


	
	
with consumption as (
	select 
		survey_id
		, h.id as household_id
		, ffi.food_vehicle_id
		, sum(fortifiable_portion) as sum 
	from household_consumption hc 
	join household h on h.id = hc.household_id 
	left join fortifiable_food_items ffi on ffi.food_genus_id = hc.food_genus_id 
	--where survey_id = 1
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
	from survey_reach
		join consumption_data_sources cds on cds.consumption_data_id = survey_reach.survey_id,
	ten_year_households tyh, 
	ten_year_population typ where typ.country_id = cds.country_id and tyh.country_id = cds.country_id
),
summary as (
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
	where id.row_name = 'summary_10yr_startup_and_recurring_cost' and i.is_premade = false
)
, summary_rows as (
	select intervention_id, max_row, json_array_elements(data) as r from intervention_values_json ivj 
	where header1 = 'Undiscounted costs, US dollars (USD)'
	and header2 = 'Summaries'
),
sum_comb as (
	select sr.*, s.average_annual_cost_per_hh_consuming, s.average_annual_cost_per_person_consuming from summary_rows sr join summary s on s.intervention_id = sr.intervention_id
),
merged_rows as (
	select intervention_id, max_row, r::jsonb || json_build_object('year0', average_annual_cost_per_hh_consuming)::jsonb as data from sum_comb
	where r->>'rowName'::text = 'summary_cost_per_hh'
	union 
	select intervention_id, max_row, r::jsonb || json_build_object('year0', average_annual_cost_per_person_consuming)::jsonb as data from sum_comb
	where r->>'rowName'::text = 'summary_cost_per_person'
	union
	select intervention_id, max_row, r::jsonb as data from summary_rows
	where r->>'rowName'::text != 'summary_cost_per_hh' and r->>'rowName'::text != 'summary_cost_per_person'
),
intervention_values_json_updated_summaries as (
	select intervention_id, 'Undiscounted costs, US dollars (USD)' as header1, max(max_row), 'Summaries' as header2, json_agg(data) as data from merged_rows group by intervention_id
),
totalfields as (
    select
        '{
		"Undiscounted costs, US dollars (USD)": {
			"Summaries": "summary_10yr_startup_and_recurring_cost"
		}
}' :: json as mapping
),
gov_su_agg as (
    select
        intervention_id,
        header1,
        header2,
        json_build_object(
            'section',
            header2,
            'costBreakdown',
            json_agg(data)->0,
            'year0Total',
            (
                select
                    year_0
                from
                    intervention_data id2
                where
                    intervention_id = g.intervention_id
                    and header1 = g.header1
                    and header2 = g.header2
                    and row_name =(
                        select
                            mapping ->(g.header1) ->>(g.header2)
                        from
                            totalfields
                    )
            ),
            'year0TotalFormula',
            (
                select
                    year_0_formula
                from
                    intervention_data id2
                    join intervention on id2.intervention_id = intervention.id
                    left join intervention_cell_formula_deps icf on icf.intervention_id = intervention.template_intervention
                      and icf.row_index = id2.row_index 
                where
                    id2.intervention_id = g.intervention_id
                    and header1 = g.header1
                    and header2 = g.header2
                    and row_name =(
                        select
                            mapping ->(g.header1) ->>(g.header2)
                        from
                            totalfields
                    )
            ),
            'year1Total',
            (
                select
                    year_1
                from
                    intervention_data id2
                where
                    intervention_id = g.intervention_id
                    and header1 = g.header1
                    and header2 = g.header2
                    and row_name =(
                        select
                            mapping ->(g.header1) ->>(g.header2)
                        from
                            totalfields
                    )
            ),
            'year1TotalFormula',
            (
                select
                    year_0_formula
                from
                    intervention_data id2
                    join intervention on id2.intervention_id = intervention.id
                    left join intervention_cell_formula_deps icf on icf.intervention_id = intervention.template_intervention
                      and icf.row_index = id2.row_index 
                where
                    id2.intervention_id = g.intervention_id
                    and header1 = g.header1
                    and header2 = g.header2
                    and row_name =(
                        select
                            mapping ->(g.header1) ->>(g.header2)
                        from
                            totalfields
                    )
            )
        ) as d
    from
        intervention_values_json_updated_summaries g
    group by
        header1,
        header2,
        intervention_id
)

--select * from gov_su_agg where intervention_id = 2 and header1 = 'Undiscounted costs, real 2021 US dollars'

, su_agg2 as (
    select
        intervention_id,
        header1,
        json_build_object('category', header1, 'costs', array_agg(d)) as startup_scaleup_costs
    from
        gov_su_agg
    where
        header1 in (
            'Undiscounted costs, US dollars (USD)'
        )
    group by
        intervention_id,
        header1
)
select
    intervention_id,
    array_agg(startup_scaleup_costs) as summary_costs
from
    su_agg2
group by
    intervention_id
;


comment ON view intervention_summary_costs IS 'Extract summary cost total rows for a given intervention';