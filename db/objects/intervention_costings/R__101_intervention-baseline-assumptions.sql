CREATE OR REPLACE view intervention_baseline_assumptions AS 

with baseline_assumptions as 
(
select 
	intervention_id
	, json_array_elements(data)->>'rowName' as row_name
	, json_array_elements(data) as data
from intervention_values_json ivj
where header1 = 'Program assumptions' and header2 = 'Performance over time'
),
fortifiable AS (
	select
		intervention_id
	   	, data as potentially_fortifiable
	from baseline_assumptions ba
	where ba.row_name = 'fortifiable_vehicle_pct'
),
fortified as (
	select
		intervention_id
	   	, data as actually_fortified
	from baseline_assumptions ba
	where ba.row_name = 'fortified_fortifiable_vehicle_pct'
),
average as (
	select
		intervention_id
	   	, data as average_fortification_level
	from baseline_assumptions ba
	where ba.row_name = 'avg_level_fortified_fortifiable_vehicle_pct'
)

select
    pf.intervention_id,
    json_build_object(
        'potentiallyFortified',
        potentially_fortifiable,
        'actuallyFortified',
        actually_fortified,
        'averageFortificationLevel',
        average_fortification_level

    ) as baseline_assumptions
from
    fortifiable pf
    join fortified af on pf.intervention_id = af.intervention_id
    join average ag on pf.intervention_id = ag.intervention_id;

comment ON view intervention_baseline_assumptions IS 'Extract baseline assumptions (potentially fortified/actually fortified) rows for a given intervention';