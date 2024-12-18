create or replace view intervention_list as




with latest_templates as (
SELECT DISTINCT ON (country_id, fortification_type_id, food_vehicle_id)
    *
FROM (
    SELECT
         i.id,
    i.intervention_name as name,
    i.app_user_id,
    coalesce(i.description, 'No description available') as description,
    i.country_id,
    i.focus_geography,
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
    i.template_intervention,
    i.template_date,
    i.last_edited,
    cds.consumption_data_id as hces_survey_id
       -- COUNT(*) OVER (PARTITION BY country_id, food_vehicle_id, fortification_type_id)
from
    intervention i
    join fortification_type ft on ft.id = i.fortification_type_id
    join food_vehicle fv on fv.id = i.food_vehicle_id
    left join consumption_data_sources cds on cds.country_id = i.country_id and cds.consumption_data_type = 'household'
    WHERE is_premade = TRUE
) s
ORDER BY country_id ASC, fortification_type_id asc, food_vehicle_id asc, template_date desc
)

select * from latest_templates

union

select
    i.id,
    i.intervention_name as name,
    i.app_user_id,
    coalesce(i.description, 'No description available') as description,
    i.country_id,
    i.focus_geography,
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
    i.template_intervention,
    i.template_date,
    i.last_edited,
    cds.consumption_data_id as hces_survey_id
from
    intervention i
    join fortification_type ft on ft.id = i.fortification_type_id
    join food_vehicle fv on fv.id = i.food_vehicle_id
    left join consumption_data_sources cds on cds.country_id = i.country_id and cds.consumption_data_type = 'household'
    where i.is_premade = false;

comment on view intervention_list is 'View of interventions and summary attributes';