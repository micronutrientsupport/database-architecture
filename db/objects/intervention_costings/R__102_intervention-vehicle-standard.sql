CREATE OR REPLACE view intervention_vehicle_standard AS 

with food_vehicle as (
   select
        intervention_data.intervention_id,
        intervention_data.factor_text,
        trim(split_part(
            split_part(intervention_data.factor_text, 'Food vehicle standard or target, ', 2),
            '(',
            1
        )) as micronutrient,
        f.micronutrient_id,
        reverse(substr(reverse(TRIM(LEADING '(' FROM
			substring(intervention_data.factor_text , '\(.*\)')
		)),2)) as compound,
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
	        'User Edited' else intervention_data.source end as data_source,
         intervention_data.source as data_source_default,
        data_citation.citation_text as data_citation
    from
	    intervention_data intervention_data
	    left join fortificant f on lower(f.name)=lower(reverse(substr(reverse(TRIM(LEADING '(' FROM
			substring(intervention_data.factor_text , '\(.*\)')
		)),2)))
	    join intervention on intervention_data.intervention_id = intervention.id
	    left join data_citation on data_citation.id = intervention.data_citation_id
	    -- Re-join intervention_data to get the values for the parent intervention
	    left join intervention_data intervention_parent 
	    	ON intervention_parent.row_index = intervention_data.row_index 
	    	and intervention_parent.intervention_id = intervention.template_intervention
	    	and intervention_parent.intervention_status = intervention.intervention_status
	    	and intervention_parent.intervention_nature = intervention.intervention_nature
	where
        intervention_data.header1 = 'Program assumptions'
    order by
        row_index asc
),
fvs as (
    select
        intervention_id,
        micronutrient_id,
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
    where not micronutrient = '' and micronutrient_id is not null
    group by
        intervention_id,
        micronutrient_id
)
select
    intervention_id,
    array_agg(
        json_build_object(
            'micronutrient',
            micronutrient_id,
            'compounds',
            food_vehicle_standard
        )
    ) as food_vehicle_standard
from
    fvs
group by
    intervention_id;

comment ON view intervention_vehicle_standard IS 'Extract intervention vehicle standards rows for a given intervention';