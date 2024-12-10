CREATE OR REPLACE view intervention_recurring_costs AS 

with totalfields as (
    select
        '{
		"Recurring premix costs": {
			"Premix ": "total_premix_cost"
		},
		"Government-related capital costs": {
			"Monitoring equipment": "annualized_equip2_cost_gov"
		},
		"Industry-related capital costs": {
			"Fortification equipment": "annualized_fort_equip3_cost",
			"Quality assurance/quality control (QA/QC) equipment": "annualized_quality_equip2_cost"
		},
		"Government-related recurring monitoring and management costs ": {
			"Mill inspections and monitoring": "total_factory_inspections_cost",
			"Import monitoring": "total_import_monitoring_cost",
			"Commercial monitoring/market surveys": "total_commercial_monitoring_cost",
			"Household monitoring ": "total_household_monitoring_cost",
			"Social marketing": "total_social_marketing_recurring_cost",
			"Training/Retraining": "total_retraining_gov_cost",
			"Management, overhead, administration ": "total_management_cost_gov"
		},
		"Industry-related recurring fortification costs": {
			"Fortification": "total_fortification_cost",
			"Internal quality assurance/quality control (QA/QC)": "total_internal_qaqc_cost",
			"External quality assurance/quality control (QA/QC)": "total_external_qaqc_cost",
			"Training/Retraining": "total_retraining_cost",
			"Management, overhead, administration ": "total_management_cost"
		},
        "Total industry-related recurring fortification costs": {
			"Fortification": "total_fortification_cost",
			"Internal quality assurance/quality control (QA/QC)": "total_internal_qaqc_cost",
			"External quality assurance/quality control (QA/QC)": "total_external_qaqc_cost",
			"Training/Retraining": "total_retraining_cost",
			"Management, overhead, administration ": "total_management_cost"
		},
		"Impact evaluation costs": {
			"Impact evaluation/nutrition surveillance": "total_impact_evalutaion_cost"
		},
        "Recurring costs ": {
            "Seed maintenance": "total_maintenance_breeding_cost",
            "Seed production and dissemination": "total_seed_production_distribution_cost",
            "Ag extension ": "ag_extension_cost",
            "Market and value chain promotion and development": "total_market_promotion_recurring_cost",
            "Social marketing/advocacy and nutrition education": "total_social_marketing_recurring_cost",
            "Monitoring": "total_monitoring_cost",
            "Management, overhead, administration ": "total_management_cost"
        },
        "User added recurring costs": {
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
	select intervention_id,'User added recurring costs' as header1, 'Additional Costs' as header2, factor_text, factor_text as row_name, year_0, year_1, year_2, year_3, year_4, year_5, year_6, year_7, year_8, year_9 from iec_totals iec
	where cost_type = 'recurring'
order by intervention_id desc
),
add_extra_costs_json as (
(select intervention_id, header1, header2, max_row, data from intervention_values_json)
union all 
select 
	iec.intervention_id
	, 'User added recurring costs' as header1
	, 'Additional Costs' as header2
	, max(iec.id + 9999) as max_row
	, json_agg(
        json_build_object(
            'rowIndex',
            concat('uecr_',iec.id),
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
            true,
            'year2',
            iec.year_2,
            'year2Default',
            iec.year_2,
            'year2Edited',
            true,
            'year3',
            iec.year_3,
            'year3Default',
            iec.year_3,
            'year3Edited',
            true,
            'year4',
            iec.year_4,
            'year4Default',
            iec.year_4,
            'year4Edited',
            true,
            'year5',
            iec.year_5,
            'year5Default',
            iec.year_5,
            'year5Edited',
            true,
            'year6',
            iec.year_6,
            'year6Default',
            iec.year_6,
            'year6Edited',
            true,
            'year7',
            iec.year_7,
            'year7Default',
            iec.year_7,
            'year7Edited',
            true,
            'year8',
            iec.year_8,
            'year8Default',
            iec.year_8,
            'year8Edited',
            true,
            'year9',
            iec.year_9,
            'year9Default',
            iec.year_9,
            'year9Edited',
            true
            )::jsonb
            ORDER BY
            iec.id ASC
    ) AS d
from intervention_extra_costs_totalled iec 
where iec.cost_type = 'recurring'
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
            ),
            'year2Total',
            (
                select
                    year_2
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
            'year3Total',
            (
                select
                    year_3
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
            'year4Total',
            (
                select
                    year_4
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
            'year5Total',
            (
                select
                    year_5
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
            'year6Total',
            (
                select
                    year_6
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
            'year7Total',
            (
                select
                    year_7
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
            'year8Total',
            (
                select
                    year_8
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
            'year9Total',
            (
                select
                    year_9
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
        json_build_object('category', header1, 'costs', array_agg(d ORDER BY max_row ASC)) as recurring_costs
    from
        gov_su_agg
    where
        header1 in (
            'Recurring premix costs',
            'Government-related capital costs',
            'Government-related recurring monitoring and management costs ',
            'Industry-related capital costs',
            'Industry-related recurring fortification costs',
            'Total industry-related recurring fortification costs',
            'Impact evaluation costs',
            'Recurring costs ',
            'User added recurring costs'
        )
    group by
        intervention_id,
        header1
)
select
    intervention_id,
    array_agg(recurring_costs order by max_row asc) as recurring_costs
from
    su_agg2
group by
    intervention_id;

comment ON view intervention_recurring_costs IS 'Extract intervention recurring cost rows for a given intervention';