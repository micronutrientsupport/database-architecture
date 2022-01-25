CREATE OR REPLACE view intervention_vehicle_standard AS 
with food_vehicle as (
    select
        intervention_id,
        split_part(
            split_part(factor_text, 'Food vehicle standard, ', 2),
            '(',
            1
        ) as micronutrient,
        split_part(split_part(factor_text, '(', 2), ')', 1) as compound,
        year_0 as target_val,
        row_index,
        units,
        is_user_editable 
    from
        intervention_data
    where
        header1 = 'Program assumptions'
        and row_name is null
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
                'rowIndex',
                row_index,
                'rowUnits',
                units,
                'isEditable',
                is_user_editable
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