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
            'rowUnits',
            intervention_data.units,
            'isEditable',
            intervention_data.is_user_editable,
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
            data_citation.citation_text
        ) as data
    from
	    intervention_data intervention_data
	    join intervention on intervention_data.intervention_id = intervention.id
	    left join data_citation on data_citation.id = intervention.data_citation_id
	    -- Re-join intervention_data to get the values for the parent intervention
	    left join intervention_data intervention_parent
	    	ON intervention_parent.row_index = intervention_data.row_index
	    	and intervention_parent.intervention_id = intervention.parent_intervention
    ORDER BY intervention_data.row_index ASC
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
        json_build_object('category', header1, 'costs', array_agg(d)) as startup_scaleup_costs
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
    array_agg(startup_scaleup_costs) as startup_scaleup_costs
from
    su_agg2
group by
    intervention_id
;


comment ON view intervention_startup_scaleup_costs IS 'Extract intervention start-up/scale-up rows for a given intervention';

