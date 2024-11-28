CREATE OR REPLACE view intervention_startup_scaleup_costs AS


with totalfields as (
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
		},
        "User added start-up/scale-up costs": {
            "Additional Costs": "Total"
        }
}' :: json as mapping
),
default_susu_costs as 
	(select
	0 as row_index
	, id as intervention_id
	, 'susu' as cost_type
	, 'Blank' as factor_text
	, 0 as year_0
	, 0 as year_1
	, 0 as year_2
	, 0 as year_3
	, 0 as year_4
	, 0 as year_5
	, 0 as year_6
	, 0 as year_7
	, 0 as year_8
	, 0 as year_9
	from intervention i 
	where i.is_premade = false)
, default_recurring_costs as 
	(select
	0 as row_index
	, id as intervention_id
	, 'recurring' as cost_type
	, 'Blank' as factor_text
	, 0 as year_0
	, 0 as year_1
	, 0 as year_2
	, 0 as year_3
	, 0 as year_4
	, 0 as year_5
	, 0 as year_6
	, 0 as year_7
	, 0 as year_8
	, 0 as year_9
	from intervention i 
	where i.is_premade = false),
iec_totals as (
    select 
	99999 as row_index,
	intervention_id,
	cost_type,
	'Total' as factor_text,
	sum(year_0) as year_0,
	sum(year_1) as year_1,
	sum(year_2) as year_2,
	sum(year_3) as year_3,
	sum(year_4) as year_4,
	sum(year_5) as year_5,
	sum(year_6) as year_6,
	sum(year_7) as year_7,
	sum(year_8) as year_8,
	sum(year_9) as year_9
	from (
		select * from intervention_extra_costs iec2
		union select * from default_susu_costs
		union select * from default_recurring_costs
	) as iec
	
	group by intervention_id, cost_type
),
intervention_extra_costs_totalled as (
select * from intervention_extra_costs iec 
union select * from iec_totals
),
add_extra_costs as (
    select intervention_id, header1, header2, factor_text, row_name, year_0, year_1, year_2, year_3, year_4, year_5, year_6, year_7, year_8, year_9 from intervention_data id
union 
	select intervention_id,'User added start-up/scale-up costs' as header1, 'Additional Costs' as header2, factor_text, factor_text as row_name, year_0, year_1, year_2, year_3, year_4, year_5, year_6, year_7, year_8, year_9 from iec_totals iec
	where cost_type = 'susu'
order by intervention_id desc
),
add_extra_costs_json as (
(select intervention_id, header1, header2, max_row, data  from intervention_values_json_subset)
union all 
select 
	iec.intervention_id
	, 'User added start-up/scale-up costs' as header1
	, 'Additional Costs' as header2
	, max(iec.id + 9999) as max_row
	, json_agg(
        json_build_object(
            'rowIndex',
            concat('uecs_',iec.id),
            'labelText',
            iec.factor_text,
            'rowName',
            iec.factor_text,
            'rowUnits',
            'US dollars',
            'isEditable',
            (CASE WHEN (iec.factor_text = 'Total') THEN false ELSE true END),
            'isCalculated',
            false,
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
    ) AS d
from intervention_extra_costs_totalled iec 
where iec.cost_type = 'susu'
GROUP by
    iec.intervention_id

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
                select
                    year_0
                from
                    add_extra_costs id2
                where
                    intervention_id = g.intervention_id
                    and header1 = g.header1
                    and header2 = g.header2
                    and row_name =(
                        select
                            mapping ->(g.header1) ->>(g.header2)
                        from
                            totalfields
                    )
            ),
            'year1Total',
            (
                select
                    year_1
                from
                    add_extra_costs id2
                where
                    intervention_id = g.intervention_id
                    and header1 = g.header1
                    and header2 = g.header2
                    and row_name =(
                        select
                            mapping ->(g.header1) ->>(g.header2)
                        from
                            totalfields
                    )
            )
        ) as d
    from
        add_extra_costs_json g
        JOIN intervention i ON g.intervention_id = i.id
    group by
        header1,
        header2,
        intervention_id
),
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
            'Industry start-up/scale-up costs',
            'Industry-related start-up/scale-up costs',
            'Government-related start-up/scale-up costs',
            'Government start-up/scale-up costs',
            'User added start-up/scale-up costs'
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


comment ON view intervention_startup_scaleup_costs IS 'Extract intervention start-up/scale-up rows for a given intervention';

