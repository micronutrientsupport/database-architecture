DROP MATERIALIZED VIEW IF EXISTS impact_summary;
CREATE MATERIALIZED VIEW impact_summary as

with country_median as (
	select cda.country_id, cda.micronutrient_id, cda.dietary_supply 
	from composition_data_sources cds
	join country_deficiency_afe cda 
	on cds.country_id = cda.country_id 
	and cds.micronutrient_id = cda.micronutrient_id 
	and cds.composition_data_id = cda.composition_data_id 
),
household_median as (
	select hdaa.country as country_id, hdaa.micronutrient_id, hdaa.dietary_supply 
	from household_deficiency_afe_aggregation hdaa 
	where aggregation_area_type = 'country'
)
,
combined_median as (
	select cm.country_id, cm.micronutrient_id, coalesce(hm.dietary_supply, cm.dietary_supply) as dietary_supply_median
	from country_median cm left join household_median hm 
	on hm.country_id = cm.country_id
	and hm.micronutrient_id = cm.micronutrient_id
)

SELECT
	country.id as country
    , micronutrient.id as micronutrient
   	, impact_scenario.id as scenario
    , intake_threshold.ear as recommended
    , interpolate_impact_year.reference_val as impact_reference_val
    , interpolate_impact_year.reference_year as impact_reference_year
    , interpolate_impact_year.intersect_year as impact_intersect_year
	, -1 * round(
			((intake_threshold.ear - (interpolate_impact_year.reference_val)) / intake_threshold.ear) * 100,
		2
	) as impact_difference
	, cm.dietary_supply_median
FROM
	impact_scenario
	CROSS JOIN country
	CROSS JOIN micronutrient
	JOIN intake_threshold on micronutrient.name = intake_threshold.nutrient_name
	CROSS JOIN interpolate_impact_year(country.id, impact_scenario.id, micronutrient.impact_column,  intake_threshold.ear )
	left JOIN combined_median cm on cm.country_id = country.id and cm.micronutrient_id = micronutrient.id
WHERE
micronutrient.is_in_impact = true
AND interpolate_impact_year.reference_val IS NOT NULL
AND interpolate_impact_year.intersect_year IS NOT null;

