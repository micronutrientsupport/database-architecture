create or replace view intervention_standard_expected_losses as

with fvs_unnest as (
	select 
		intervention_id, 
		((unnest(food_vehicle_standard))->>'micronutrient')::text as micronutrient_id, 
		((json_array_elements((unnest(food_vehicle_standard))->'compounds'))->>'targetVal')::numeric as target_val
	from intervention_vehicle_standard ivs
),
losses as (

  select
        fvs.intervention_id,
        fvs.micronutrient_id,
            json_build_object(
                'targetVal',
                fvs.target_val,
                'rowIndex',
                iel.id,
                'rowUnits',
                'number',
                'expectedLosses',
                iel.expected_losses,
                'expectedLossesDefault',
                iel.expected_losses_default,
                'source',
                iel.source
        ) as expected_losses
        
from fvs_unnest fvs
left join intervention_expected_losses iel on iel.intervention_id = fvs.intervention_id
and iel.micronutrient_id = fvs.micronutrient_id

where target_val > 0

group by fvs.intervention_id, fvs.micronutrient_id, fvs.target_val, iel.id
)

select
    intervention_id,
    array_agg(
        json_build_object(
            'micronutrient',
            micronutrient_id,
            'expectedLosses',
            expected_losses
        )
    ) as expected_losses
from
    losses
group by
    intervention_id;

