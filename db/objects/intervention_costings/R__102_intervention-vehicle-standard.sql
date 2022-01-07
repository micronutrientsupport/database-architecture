CREATE
OR REPLACE view intervention_vehicle_standard AS with food_vehicle as (
    select
        intervention_id,
        split_part(
            split_part(factor_text, 'Food vehicle standard, ', 2),
            '(',
            1
        ) as micronutrient,
        split_part(split_part(factor_text, '(', 2), ')', 1) as compound,
        year_0 as target_val,
        row_index
    from
        intervention_data id
    where
        header1 = 'Program assumptions'
        and row_name is null
    order by
        row_index asc
)
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
            row_index
        )
    ) as food_vehicle_standard
from
    food_vehicle fv
group by
    intervention_id,
    micronutrient;

comment ON view intervention_vehicle_standard IS 'Extract intervention vehicle standards rows for a given intervention';