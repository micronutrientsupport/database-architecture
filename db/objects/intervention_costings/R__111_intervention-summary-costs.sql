CREATE OR REPLACE view intervention_summary_costs AS 
with totalfields as (
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
                    left join intervention_cell_formula_deps icf on icf.intervention_id = coalesce(intervention.parent_intervention, intervention.id)
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
                    left join intervention_cell_formula_deps icf on icf.intervention_id = coalesce(intervention.parent_intervention, intervention.id)
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
        intervention_values_json g
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