DROP MATERIALIZED VIEW IF EXISTS impact_summary;
CREATE MATERIALIZED VIEW impact_summary as
SELECT
	country.id as country
    , micronutrient.id as micronutrient
   	, impact_scenario.id as scenario
    , intake_threshold.rda as recommended
    , interpolate_impact_year.reference_val as daily_reference_val
    , interpolate_impact_year.reference_year
    , interpolate_impact_year.intersect_year
	, -1 * round(
			((intake_threshold.rda - (interpolate_impact_year.reference_val)) / intake_threshold.rda) * 100,
		2
	) as difference
FROM
	impact_scenario
	CROSS JOIN country
	CROSS JOIN micronutrient
	JOIN intake_threshold on micronutrient.name = intake_threshold.nutrient_name
	CROSS JOIN interpolate_impact_year(country.id, impact_scenario.id, micronutrient.impact_column,  intake_threshold.rda )
WHERE
micronutrient.is_in_impact = true
AND sex = 'Female' AND age_upper < 30 AND age_lower > 24
AND interpolate_impact_year.reference_val IS NOT NULL
AND interpolate_impact_year.intersect_year IS NOT NULL
;
