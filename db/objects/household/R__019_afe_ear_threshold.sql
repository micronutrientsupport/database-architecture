create or replace view afe_ear_threshold as

select
    m.id as micronutrient_id
    , nutrient_name as micronutrient_name
    , avg(ear) as afe_ear
from
    intake_threshold it
join
    micronutrient m
    on m."name" = it.nutrient_name
where
    sex = 'Female'
    AND age_lower >= 18
    and age_upper <= 29
group by
    it.nutrient_name,
    m.id;

COMMENT ON VIEW afe_ear_threshold IS 'View to extract the Estimated Average Requirement (EAR) for an Adult Female Equivalent (AFE) from the thresholds table';
