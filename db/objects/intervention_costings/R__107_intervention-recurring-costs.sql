CREATE
or replace AGGREGATE jsonb_object_aggregate(jsonb) (
    SFUNC = 'jsonb_concat',
    STYPE = jsonb,
    INITCOND = '{}'
);

CREATE
OR REPLACE view intervention_recurring_costs AS with totalfields as (
    select
        '{
		"Recurring premix costs": {
			"Premix": "total_premix_cost"
		},
		"Government-related recurring monitoring and management costs ": {
			"Mill inspections and monitoring": "total_factory_inspections_cost",
			"Import monitoring": "???",
			"Commercial monitoring/market surveys": "???",
			"Household monitoring  ": "total_household_monitoring_cost",
			"Social marketing": "total_social_marketing_recurring_cost",
			"Training/Retraining": "total_retraining_gov_cost",
			"Management, overhead, administration ": "total_management_cost_gov"
		},
		"Industry-related recurring fortification costs": {
			"Fortification": "total_fortification_cost",
			"Internal quality assurance/quality control (QA/QC)": "total_internal_qaqc_cost",
			"External quality assurance/quality control (QA/QC)": "total_external_qaqc_cost",
			"Training/Retraining": "total_retraining_cost",
			"Management, overhead, administration ": "total_management_cost"
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
            year_1,
            'year2',
            year_2,
            'year3',
            year_3,
            'year4',
            year_4,
            'year5',
            year_5,
            'year6',
            year_6,
            'year7',
            year_7,
            'year8',
            year_8,
            'year9',
            year_9
        ) as data
    from
        intervention_data id --where header1 = 'Government-related start-up/scale-up costs' --and header2 = 'Planning'
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
                ),
                'year2Total',
                (
                    select
                        year_2
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
                'year3Total',
                (
                    select
                        year_3
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
                'year4Total',
                (
                    select
                        year_4
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
                'year5Total',
                (
                    select
                        year_5
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
                'year6Total',
                (
                    select
                        year_6
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
                'year7Total',
                (
                    select
                        year_7
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
                'year8Total',
                (
                    select
                        year_8
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
                'year9Total',
                (
                    select
                        year_9
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
        'Recurring premix costs',
        'Government-related recurring monitoring and management costs ',
        'Industry-related recurring fortification costs'
    )
group by
    intervention_id,
    header1;

comment ON view intervention_recurring_costs IS 'Extract intervention recurring cost rows for a given intervention';