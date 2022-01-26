CREATE OR REPLACE view intervention_recurring_costs AS 
with totalfields as (
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
        intervention_data.intervention_id,
        intervention_data.header1,
        intervention_data.header2,
        json_build_object(
            'name',
            intervention_data.factor_text,
            'rowIndex',
            intervention_data.row_index,
            'year0',
            intervention_data.year_0,
            'year0Default',
            intervention_parent.year_0,
            'year0Edited',
            intervention_data.year_0 != intervention_parent.year_0,
            'year1',
            intervention_data.year_1,
            'year1Default',
            intervention_parent.year_1,
            'year1Edited',
            intervention_data.year_1 != intervention_parent.year_1,
            'year2',
            intervention_data.year_2,
            'year2Default',
            intervention_parent.year_2,
            'year2Edited',
            intervention_data.year_2 != intervention_parent.year_2,
            'year3',
            intervention_data.year_3,
            'year3Default',
            intervention_parent.year_3,
            'year3Edited',
            intervention_data.year_3 != intervention_parent.year_3,
            'year4',
            intervention_data.year_4,
            'year4Default',
            intervention_parent.year_4,
            'year4Edited',
            intervention_data.year_4 != intervention_parent.year_4,
            'year5',
            intervention_data.year_5,
            'year5Default',
            intervention_parent.year_5,
            'year5Edited',
            intervention_data.year_5 != intervention_parent.year_5,
            'year6',
            intervention_data.year_6,
            'year6Default',
            intervention_parent.year_6,
            'year6Edited',
            intervention_data.year_6 != intervention_parent.year_6,
            'year7',
            intervention_data.year_7,
            'year7Default',
            intervention_parent.year_7,
            'year7Edited',
            intervention_data.year_7 != intervention_parent.year_7,
            'year8',
            intervention_data.year_8,
            'year8Default',
            intervention_parent.year_8,
            'year8Edited',
            intervention_data.year_8 != intervention_parent.year_8,
            'year9',
            intervention_data.year_9,
            'year9Default',
            intervention_parent.year_9,
            'year9Edited',
            intervention_data.year_9 != intervention_parent.year_9,
            'dataSource',
            data_citation.short_text,
            'dataSource',
	            case when ((intervention_data.year_0 != intervention_parent.year_0) OR
	            (intervention_data.year_1 != intervention_parent.year_1) OR
	            (intervention_data.year_2 != intervention_parent.year_2) OR
	            (intervention_data.year_3 != intervention_parent.year_3) OR
	            (intervention_data.year_4 != intervention_parent.year_4) OR
	            (intervention_data.year_5 != intervention_parent.year_5) OR
	            (intervention_data.year_6 != intervention_parent.year_6) OR
	            (intervention_data.year_7 != intervention_parent.year_7) OR
	            (intervention_data.year_8 != intervention_parent.year_8) OR
	            (intervention_data.year_9 != intervention_parent.year_9)) then
	            'User Edited' else data_citation.short_text end,
            'dataSourceDefault',
            data_citation.short_text,
            'dataCitation',
            data_citation.citation_text,
            'rowUnits',
            intervention_data.units,
            'isEditable',
            intervention_data.is_user_editable
        ) as data
    from
	    intervention_data intervention_data
	    join intervention on intervention_data.intervention_id = intervention.id
	    left join data_citation on data_citation.id = intervention.data_citation_id
	    -- Re-join intervention_data to get the values for the parent intervention
	    left join intervention_data intervention_parent 
	    	ON intervention_parent.row_index = intervention_data.row_index 
	    	and intervention_parent.intervention_id = intervention.parent_intervention
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
        ) as d
    from
        gov_su g
    group by
        header1,
        header2,
        intervention_id
),
su_agg2 as (
    select
        intervention_id,
        header1,
        json_build_object('category', header1, 'costs', array_agg(d)) as recurring_costs
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
        header1
)
select
    intervention_id,
    array_agg(recurring_costs) as recurring_costs
from
    su_agg2
group by
    intervention_id;

comment ON view intervention_recurring_costs IS 'Extract intervention recurring cost rows for a given intervention';