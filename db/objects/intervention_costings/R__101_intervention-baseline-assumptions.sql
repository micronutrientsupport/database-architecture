CREATE OR REPLACE view intervention_baseline_assumptions AS 
WITH fortifiable AS (
    select
        intervention_data.intervention_id,
        json_build_object(
            'title',
            intervention_data.factor_text,
            'rowIndex',
            intervention_data.row_index,
            'rowUnits',
            intervention_data.units,
            'isEditable',
            intervention_data.is_user_editable,
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
            data_citation.citation_text
        ) as potentially_fortifiable
    from
	    intervention_data intervention_data
	    join intervention on intervention_data.intervention_id = intervention.id
	    left join data_citation on data_citation.id = intervention.data_citation_id
	    -- Re-join intervention_data to get the values for the parent intervention
	    left join intervention_data intervention_parent 
	    	ON intervention_parent.row_index = intervention_data.row_index 
	    	and intervention_parent.intervention_id = intervention.parent_intervention
    where
        intervention_data.row_name = 'fortifiable_vehicle_pct'
        and intervention_data.header1 = 'Program assumptions'
),
fortified as (
    select
        intervention_data.intervention_id,
        json_build_object(
            'title',
            intervention_data.factor_text,
            'rowIndex',
            intervention_data.row_index,
            'rowUnits',
            intervention_data.units,
            'isEditable',
            intervention_data.is_user_editable,
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
        ) as actually_fortified
    from
	    intervention_data intervention_data
	    join intervention on intervention_data.intervention_id = intervention.id
	    left join data_citation on data_citation.id = intervention.data_citation_id
	    -- Re-join intervention_data to get the values for the parent intervention
	    left join intervention_data intervention_parent 
	    	ON intervention_parent.row_index = intervention_data.row_index 
	    	and intervention_parent.intervention_id = intervention.parent_intervention
    where
        intervention_data.row_name = 'fortified_fortifiable_vehicle_pct'
        and intervention_data.header1 = 'Program assumptions'
),
average AS (
    select
        intervention_data.intervention_id,
        json_build_object(
            'title',
            intervention_data.factor_text,
            'rowIndex',
            intervention_data.row_index,
            'rowUnits',
            intervention_data.units,
            'isEditable',
            intervention_data.is_user_editable,
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
            data_citation.citation_text
        ) as average_fortification_level
    from
	    intervention_data intervention_data
	    join intervention on intervention_data.intervention_id = intervention.id
	    left join data_citation on data_citation.id = intervention.data_citation_id
	    -- Re-join intervention_data to get the values for the parent intervention
	    left join intervention_data intervention_parent 
	    	ON intervention_parent.row_index = intervention_data.row_index 
	    	and intervention_parent.intervention_id = intervention.parent_intervention
    where
        intervention_data.row_name = 'avg_level_fortified_fortifiable_vehicle_pct'
        and intervention_data.header1 = 'Program assumptions'
)
select
    pf.intervention_id,
    json_build_object(
        'potentiallyFortified',
        potentially_fortifiable,
        'actuallyFortified',
        actually_fortified,
        'averageFortificationLevel',
        average_fortification_level

    ) as baseline_assumptions
from
    fortifiable pf
    join fortified af on pf.intervention_id = af.intervention_id
    join average ag on pf.intervention_id = ag.intervention_id;

comment ON view intervention_baseline_assumptions IS 'Extract baseline assumptions (potentially fortified/actually fortified) rows for a given intervention';