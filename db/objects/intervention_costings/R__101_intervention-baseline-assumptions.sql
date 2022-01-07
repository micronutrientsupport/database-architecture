CREATE
OR REPLACE view intervention_baseline_assumptions AS WITH fortifiable AS (
    select
        intervention_id,
        json_build_object(
            'title',
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
            year_9,
            'rowIndex',
            row_index
        ) as potentially_fortifiable
    from
        intervention_data d
    where
        d.row_name = 'fortifiable_vehicle_pct'
        and d.header1 = 'Program assumptions'
),
fortified as (
    select
        intervention_id,
        json_build_object(
            'title',
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
            year_9,
            'rowIndex',
            row_index
        ) as actually_fortified
    from
        intervention_data d
    where
        d.row_name = 'fortified_fortifiable_vehicle_pct'
        and d.header1 = 'Program assumptions'
)
select
    pf.intervention_id,
    json_build_object(
        'potentiallyFortified',
        potentially_fortifiable,
        'actuallyFortified',
        actually_fortified
    ) as baseline_assumptions
from
    fortifiable pf
    join fortified af on pf.intervention_id = af.intervention_id;

comment ON view intervention_baseline_assumptions IS 'Extract baseline assumptions (potentially fortified/actually fortified) rows for a given intervention';