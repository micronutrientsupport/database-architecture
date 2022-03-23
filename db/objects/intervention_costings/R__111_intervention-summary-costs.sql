CREATE
OR REPLACE view intervention_summary_costs AS with summary_costs as (
    select
        intervention_id,
        json_build_object(
            'row_name',
            row_name,
            'rowIndex',
            row_index,
            'rowUnits',
            units,
            'labelText',
            factor_text,
            'year0',
            year_0,
            'year1',
            year_1,
            'year2',
            year_2,
            'year3',
            year_3,
            'year4',
            year_4,
            'year5',
            year_5,
            'year6',
            year_6,
            'year7',
            year_7,
            'year8',
            year_8,
            'year9',
            year_9
        ) as summary_costs
    from
        intervention_data id
    where
        row_name = 'summary_annual_startup_and_recurring_cost'
),
summary_costs_discounted as (
    select
        intervention_id,
        json_build_object(
            'row_name',
            row_name,
            'rowIndex',
            row_index,
            'rowUnits',
            units,
            'labelText',
            factor_text,
            'year0',
            year_0,
            'year1',
            year_1,
            'year2',
            year_2,
            'year3',
            year_3,
            'year4',
            year_4,
            'year5',
            year_5,
            'year6',
            year_6,
            'year7',
            year_7,
            'year8',
            year_8,
            'year9',
            year_9
        ) as summary_costs_discounted
    from
        intervention_data id
    where
        row_name = 'summary_annual_discounted_startup_and_recurring_cost'
),
discount_rate as (
    select
        intervention_id,
        year_0 as discount_rate
    from
        intervention_data id
    where
        row_name = 'discount_rate'
)
select
    sc.intervention_id,
    summary_costs,
    discount_rate,
    summary_costs_discounted
from
    summary_costs sc
    join summary_costs_discounted scd on sc.intervention_id = scd.intervention_id
    join discount_rate dr on dr.intervention_id = sc.intervention_id
;

comment ON view intervention_summary_costs IS 'Extract summary cost total rows for a given intervention';