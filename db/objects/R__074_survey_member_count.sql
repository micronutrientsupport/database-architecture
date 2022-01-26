create
or replace view survey_member_count as
select
    h.survey_id,
    sum(hn.afe_factor) as afe_total,
    sum(hn.ame_factor) as ame_total
from
    household_normalisation hn
    join household h on hn.household_id = h.id
group by
    h.survey_id;

comment on view survey_member_count is 'View of the adult female and adult male equivalent size of the total survey population';