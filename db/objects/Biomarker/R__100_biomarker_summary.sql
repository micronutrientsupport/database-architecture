DROP MATERIALIZED VIEW IF EXISTS biomarker_summary;
CREATE MATERIALIZED VIEW biomarker_summary AS

select
    hh.survey_id
    , hm.group_id
    , coalesce(biomarker_aggregation_area.name, aggregation_area.name) as region
    , hh.wealth_quintile
    , hh.urbanity
    , hh.altitude_in_metres
	, hm.age_in_months
	, hm.sex
	, s.hb_is_adjusted_for_smoking as is_adjusted_for_smoking
	, s.hb_is_adjusted_for_altitude as is_adjusted_for_altitude
	, hm.is_pregnant
	, hm.is_smoker
	, hm.had_malaria
	, hm.had_diarrhoea
	, hm.weight_in_kg
	, hm.height_in_cm
	, bm.was_fasting
	, bm.date_sampled
	, bm.time_of_day_sampled
	, hm.survey_cluster
	, hm.survey_strata
	, hm.survey_weight
	, bm.haemoglobin
	, bm.ferritin
	, bm.stfr
	, bm.rbp
	, bm.retinol
	, bm.rbc_folate
	, bm.ps_folate
	, bm.vitamin_b12
	, bm.zinc
	, bm.crp
	, bm.agp
	, bm.iodine

from biomarker_measurement bm	-- Biomarker measurement data
join household_member hm on bm.household_member_id = hm.id -- Details of the individual e.g. age, pregnancy
join household hh on hm.household_id = hh.id -- Details of the household e.g. location, wealth
join survey s on hh.survey_id = s.id
left join aggregation_area on st_contains(aggregation_area.geometry, hh.location)  AND (aggregation_area.id IS NULL OR (aggregation_area.type='admin' AND aggregation_area.admin_level=1))
left join biomarker_aggregation_area on st_contains(biomarker_aggregation_area.geometry, hh.location) 
WHERE s.survey_type = 'biomarker' -- Which aggregation area the household falls into for aggregation

order by hh.survey_id DESC, hm.group_id ASC;