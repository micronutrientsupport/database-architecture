create or replace view biomarker_threshold_list as
select
	threshold_id,
	biomarker_id,
	group_id,
	conditional_info as condition_text,
	json_strip_nulls(json_build_object(
		'timeOfDaySampled',
		condition_time_of_day_sampled,
		'wasFasting',
		condition_was_fasting,
		'ageInMonths',
		condition_age_in_months,
		'sex',
		condition_sex,
		'is_adjusted_for_smoking',
		condition_is_adjusted_for_smoking,
		'is_adjusted_for_altitude',
		condition_is_adjusted_for_altitude
	)) as condition,
	threshold_type,
	source,
	matrix,
	lower_threshold,
	upper_threshold,
	comments 
from biomarker_threshold bt;

comment on view biomarker_threshold_list is 'Summary view of biomarker thresholds for use by the API/R script';