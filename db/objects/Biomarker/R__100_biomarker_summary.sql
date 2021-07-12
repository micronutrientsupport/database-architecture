create or replace view biomarker_summary as

select
    sgd.survey_id
    , sgd.group_id
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
left join aggregation_area sr on st_contains(sr.geometry, hh.location) -- Which aggregation area the household falls into for aggregation

join survey_group_def sgd on -- Details of the survey, groupings WRA, AGE etc.
	sgd.survey_id = hh.survey_id and
	(
		(
		-- If age bounds, match between bounds
		-- and by sex.
		-- TODO: check which of the bounds is inclusive and which exclusive
		sgd.age_lower_in_months < hm.age_in_months
		and sgd.age_upper_in_months >= hm.age_in_months
		and (( sgd.sex = hm.sex) or (sgd.sex = 'both'))
		)
		or
		(
		-- No age bounds,  still join in sex but not if PREG as
		-- has extra constraints
		sgd.age_lower_in_months isnull
		and sgd.age_upper_in_months isnull
		and (( sgd.sex = hm.sex) or (sgd.sex = 'both'))
		and sgd.group_id != 'PREG'
		)
		or
		(
		-- Special case for pregnant
		sgd.group_id = 'PREG'
		and hm.is_pregnant
		)
	)

	order by sgd.survey_id, sgd.group_id ASC
