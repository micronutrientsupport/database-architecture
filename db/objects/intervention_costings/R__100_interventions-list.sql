create
or replace view intervention_list as
select
    i.id,
    i.intervention_name as name,
    'No description available' as description,
    i.country_id,
    i.fortification_type_id,
    ft."name" as fortification_type_name,
    i.program_status,
    i.food_vehicle_id,
    fv.vehicle_name as food_vehicle_name,
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
        ),
        0
    ) as ten_year_total_cost
from
    intervention i
    join fortification_type ft on ft.id = i.fortification_type_id
    join food_vehicle fv on fv.id = i.food_vehicle_id
where
    is_premade = true;

comment on view intervention_list is 'View of premade interventions and summary attributes';