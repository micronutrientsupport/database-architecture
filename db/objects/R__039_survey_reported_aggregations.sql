create or replace view survey_reported_aggregations as

with survey_participants as 
(
select h.survey_id, 
	case when count(distinct urbanity) > 0 then 'urbanity' else null end as urbanity,
	case when count(distinct wealth_quintile) > 0 then 'wealth_quintile' else null end as wealth_quintile,
	case when count(distinct household_expenditure) > 0 then 'household_expenditure' else null end as household_expenditure,
	case when count(distinct location) > 0 then 'region' else null end as location
from biomarker_measurement bm 
join household_member hm 
on bm.household_member_id=hm.id
join household h 
on hm.household_id = h.id
where group_id notnull
group by survey_id
)

select survey_id,
-- array_to_string ignores null values so cast to string and back to array to clear nulls
string_to_array( 
	array_to_string(
		array[urbanity,wealth_quintile,household_expenditure,location], ','
	),
','
) as reported_aggregations
from survey_participants
group by survey_id, urbanity, wealth_quintile,household_expenditure,location;


COMMENT ON VIEW survey_reported_aggregations IS 'View of array of aggregation fields with valid data for a given biomarker survey';
