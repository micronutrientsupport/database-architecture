CREATE OR REPLACE view intervention_vehicle_standard AS 
with food_vehicle as (
    select
        intervention_data.intervention_id,
        split_part(
            split_part(intervention_data.factor_text, 'Food vehicle standard, ', 2),
            '(',
            1
        ) as micronutrient,
        split_part(split_part(intervention_data.factor_text, '(', 2), ')', 1) as compound,
        intervention_data.year_0 as target_val,
        intervention_parent.year_0 as target_val_default,
        intervention_data.year_0 != intervention_parent.year_0 as target_val_edited,
        intervention_data.row_index,
        intervention_data.units,
        intervention_data.is_user_editable,
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
	        'User Edited' else data_citation.short_text end as data_source,
        data_citation.short_text as data_source_default,
        data_citation.citation_text as data_citation
    from
	    intervention_data intervention_data
	    join intervention on intervention_data.intervention_id = intervention.id
	    left join data_citation on data_citation.id = intervention.data_citation_id
	    -- Re-join intervention_data to get the values for the parent intervention
	    left join intervention_data intervention_parent 
	    	ON intervention_parent.row_index = intervention_data.row_index 
	    	and intervention_parent.intervention_id = intervention.parent_intervention
    where
        intervention_data.header1 = 'Program assumptions'
        and intervention_data.row_name is null
    order by
        row_index asc
),
fvs as (
    select
        intervention_id,
        micronutrient,
        json_agg(
            json_build_object(
                'compound',
                compound,
                'targetVal',
                target_val,
                'targetValDefault',
                target_val_default,
                'targetValEdited',
                target_val_edited,
                'rowIndex',
                row_index,
                'rowUnits',
                units,
                'isEditable',
                is_user_editable,
                'dataSource',
                data_source,
                'dataSourceDefault',
                data_source_default,
                'dataCitation',
                data_citation
            )
        ) as food_vehicle_standard
    from
        food_vehicle fv
    group by
        intervention_id,
        micronutrient
)
select
    intervention_id,
    array_agg(
        json_build_object(
            'micronutrient',
            micronutrient,
            'compounds',
            food_vehicle_standard
        )
    ) as food_vehicle_standard
from
    fvs
group by
    intervention_id;

comment ON view intervention_vehicle_standard IS 'Extract intervention vehicle standards rows for a given intervention';