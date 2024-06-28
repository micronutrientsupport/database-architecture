CREATE OR REPLACE view intervention_startup_scaleup_costs AS
with totalfields as (
    select
        '{
		"Industry start-up/scale-up costs": {
			"Equipment": "total_equipment_cost",
			"Labeling": "total_labeling_cost",
			"Training": "total_training_cost"
		},
		"Industry-related start-up/scale-up costs": {
            "Fortification equipment": "total_equipment_cost",
			"Quality assurance/quality control (QA/QC) equipment": "total_quality_equipment_cost",
			"Labeling": "total_labeling_cost",
			"Training": "total_training_cost"
		},
		"Government-related start-up/scale-up costs": {
			"Monitoring equipment": "total_equipment_cost_gov",
			"Planning": "total_planning_cost",
			"Social marketing and advocacy": "total_social_marketing_startup_cost",
			"Training ": "total_training_cost_gov"
		},
		"Government start-up/scale-up costs": {
			"Equipment": "total_equipment_cost_gov",
			"Planning": "total_planning_cost",
			"Social marketing and advocacy": "total_social_marketing_startup_cost",
			"Training ": "total_training_cost_gov"
		}
}' :: json as mapping
),
gov_su_agg as (
    select
        intervention_id,
        header1,
        header2,
        max(max_row) as max_row,
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
                    left join intervention_cell_formula_deps icf on icf.intervention_id = i.template_intervention
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
                    left join intervention_cell_formula_deps icf on icf.intervention_id = i.template_intervention
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
        intervention_values_json_subset g
        JOIN intervention i ON g.intervention_id = i.id
    group by
        header1,
        header2,
        intervention_id,
        template_intervention
),
su_agg2 as (
    select
        intervention_id,
        header1,
        max(max_row) as max_row,
        json_build_object('category', header1, 'costs', array_agg(d ORDER BY max_row ASC)) as startup_scaleup_costs
    from
        gov_su_agg
    where
        header1 in (
            'Industry start-up/scale-up costs',
            'Industry-related start-up/scale-up costs',
            'Government-related start-up/scale-up costs',
            'Government start-up/scale-up costs'
        )
    group by
        intervention_id,
        header1
)
select
    intervention_id,
    array_agg(startup_scaleup_costs ORDER BY max_row asc) as startup_scaleup_costs
from
    su_agg2
group by
    intervention_id
;

comment ON view intervention_startup_scaleup_costs IS 'Extract intervention start-up/scale-up rows for a given intervention';

