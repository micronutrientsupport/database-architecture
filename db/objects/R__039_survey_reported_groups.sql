create or replace view survey_reported_groups as

with survey_participants as 
(
select h.survey_id, hm.group_id from biomarker_measurement bm 
join household_member hm 
on bm.household_member_id=hm.id
join household h 
on hm.household_id = h.id
where education_level notnull
group by survey_id, group_id
)

select survey_id
    , array_agg(group_id) as reported_groups
from survey_participants group by survey_id;

COMMENT ON VIEW survey_reported_groups IS 'View of array of reported age-gender groups for a given biomarker survey';
