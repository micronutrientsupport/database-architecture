-- create or replace view intervention_user_cost as

with extra_costs_json as (

select 
	iec.intervention_id
	, 'User added recurring costs' as header1
	, iec.header2 as header2
	, max(iec.id) as max_row
	, json_agg(
        json_build_object(
            'rowIndex',
            iec.id,
            'labelText',
            iec.factor_text,
            'rowName',
            iec.factor_text,
            'rowUnits',
            'US Dollars',
            'isEditable',
            true,
            'year0',
            iec.year_0,
            'year0Default',
            iec.year_0,
            'year0Edited',
            true,
            'year1',
            iec.year_1,
            'year1Default',
            iec.year_1,
            'year1Edited',
            true
            )::jsonb
            ORDER BY
            iec.id ASC
    ) AS data
from intervention_extra_costs iec 
GROUP BY
    iec.intervention_id
    , iec.header2
),
totalfields as (
    select
        '{
		"Industry start-up/scale-up costs": {
			"Equipment": "total_equipment_cost",
			"Labeling": "total_labeling_cost",
			"Training": "total_training_cost"
		},
		"Industry-related start-up/scale-up costs": {
            "Fortification equipment": "total_equipment_cost",
			"Quality assurance/quality control (QA/QC) equipment": "total_quality_equipment_cost",
			"Labeling": "total_labeling_cost",
			"Training": "total_training_cost"
		},
		"Government-related start-up/scale-up costs": {
			"Monitoring equipment": "total_equipment_cost_gov",
			"Planning": "total_planning_cost",
			"Social marketing and advocacy": "total_social_marketing_startup_cost",
			"Training ": "total_training_cost_gov"
		},
		"Government start-up/scale-up costs": {
			"Equipment": "total_equipment_cost_gov",
			"Planning": "total_planning_cost",
			"Social marketing and advocacy": "total_social_marketing_startup_cost",
			"Training ": "total_training_cost_gov"
		}
}' :: json as mapping
),
gov_su_agg as (
    select
        intervention_id,
        header1,
        header2,
        max(max_row) as max_row,
        json_build_object(
            'section',
            header2,
            'costBreakdown',
            json_agg(data)->0,
            'year0Total',
            (
0
            ),
            'year0TotalFormula',
            (
0
            ),
            'year1Total',
            (
0
            ),
            'year1TotalFormula',
            (
0
            )
        ) as d
    from
        extra_costs_json g
    group by
        header1,
        header2,
        intervention_id
)

,
su_agg2 as (
    select
        intervention_id,
        header1,
        max(max_row) as max_row,
        json_build_object('category', header1, 'costs', array_agg(d ORDER BY max_row ASC)) as startup_scaleup_costs
    from
        gov_su_agg
    where
        header1 in (
            'User added recurring costs'
        )
    group by
        intervention_id,
        header1
)
select
    intervention_id,
    array_agg(startup_scaleup_costs ORDER BY max_row asc) as startup_scaleup_costs
from
    su_agg2
group by
    intervention_id
;







with extra_susu_costs_json as (
select 
	iec.intervention_id
	cost_type
	, 'User added recurring costs' as header1
	, 'Additional Costs' as header2
	, max(iec.id) as max_row
	, json_agg(
        json_build_object(
            'rowIndex',
            iec.id,
            'labelText',
            iec.factor_text,
            'rowName',
            iec.factor_text,
            'rowUnits',
            'US Dollars',
            'isEditable',
            true,
            'year0',
            iec.year_0,
            'year0Default',
            iec.year_0,
            'year0Edited',
            true,
            'year1',
            iec.year_1,
            'year1Default',
            iec.year_1,
            'year1Edited',
            true
            )::jsonb
            ORDER BY
            iec.id ASC
    ) AS data
from intervention_extra_costs iec 
where iec.cost_type = 'susu'
GROUP by
    iec.intervention_id
)