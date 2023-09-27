create or replace view intervention_list as

select
    i.id,
    i.intervention_name as name,
    i.app_user_id,
    coalesce(i.description, 'No description available') as description,
    i.country_id,
    i.fortification_type_id,
    ft."name" as fortification_type_name,
    i.program_status,
    i.food_vehicle_id,
    fv.vehicle_name as food_vehicle_name,
    i.focus_micronutrient,
    i.is_premade,
    NOT(i.is_premade OR i.is_locked) as is_editable,
    i.base_year,
    round(
        (
            select
                year_0
            from
                intervention_data d
            where
                d.row_name = 'summary_10yr_discounted_startup_and_recurring_cost'
                and d.intervention_id = i.id
            limit 1
        ),
        0
    ) as ten_year_total_cost,
    i.parent_intervention,
    i.last_edited 
from
    intervention i
    join fortification_type ft on ft.id = i.fortification_type_id
    join food_vehicle fv on fv.id = i.food_vehicle_id;

comment on view intervention_list is 'View of interventions and summary attributes';