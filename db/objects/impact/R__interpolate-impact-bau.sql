CREATE MATERIALIZED VIEW impact_summary as

    with baseline as (
    select id from impact_scenario),
    impact_nutrients as (
    select id, impact_column from micronutrient where in_impact = true),
    threshold as (
    select 107000 as threshold 
    )


    select country.id as country, impact_nutrients.id as micronutrient, baseline.id as scenario, threshold.threshold as target, interpolate_impact_year.*, -round(((threshold.threshold-interpolate_impact_year.reference_val)/threshold.threshold)*100,2) as difference
    from country, baseline, impact_nutrients, threshold, interpolate_impact_year(country.id,baseline.id,impact_nutrients.impact_column, threshold.threshold)

    where interpolate_impact_year.intersect_year notnull 