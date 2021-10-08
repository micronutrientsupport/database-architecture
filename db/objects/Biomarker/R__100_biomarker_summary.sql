create or replace view biomarker_summary as

select
    hh.survey_id
    , hm.group_id
    , sr.name as region_name
    , hh.wealth_quintile
    , hh.urbanity
	, hm.age_in_months
	, hm.is_pregnant
	, bm.was_fasting
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
join household_member hm on bm.id = hm.id -- Details of the individual e.g. age, pregnancy
join household hh on hm.household_id = hh.id -- Details of the household e.g. location, wealth
left join aggregation_area sr on st_contains(sr.geometry, hh.location) WHERE s.type='admin' AND s.admin_level=1 -- Which aggregation area the household falls into for aggregation



	order by hh.survey_id, hm.group_id ASC
