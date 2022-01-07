CREATE
or replace AGGREGATE jsonb_object_aggregate(jsonb) (
    SFUNC = 'jsonb_concat',
    STYPE = jsonb,
    INITCOND = '{}'
);

CREATE
OR REPLACE view intervention_startup_scaleup_costs AS with totalfields as (
    select
        '{
		"Industry start-up/scale-up costs": {
			"Equipment": "total_equipment_cost",
			"Labeling": "total_labeling_cost",
			"Training": "total_training_cost"
		},
		"Industry-related start-up/scale-up costs": {
			"Equipment": "total_equipment_cost",
			"Labeling": "total_labeling_cost",
			"Training": "total_training_cost"
		}, 
		"Government-related start-up/scale-up costs": {
			"Equipment": "total_equipment_cost_gov",
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
gov_su as (
    select
        intervention_id,
        header1,
        header2,
        json_build_object(
            'name',
            factor_text,
            'rowIndex',
            row_index,
            'year0',
            year_0,
            'year1',
            year_1
        ) as data
    from
        intervention_data id
),
gov_su_agg as (
    select
        intervention_id,
        header1,
        json_build_object(
            header2,
            json_build_object(
                'breakdown',
                json_agg(data),
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
                )
            )
        ) as d
    from
        gov_su g
    group by
        header1,
        header2,
        intervention_id
)
select
    intervention_id,
    header1,
    jsonb_object_aggregate(d :: jsonb)
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
    header1;

comment ON view intervention_startup_scaleup_costs IS 'Extract intervention start-up/scale-up rows for a given intervention';