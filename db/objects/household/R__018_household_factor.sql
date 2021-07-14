create
or replace view household_normalisation as with factors as (
    -- AFE/AME for females
    select
        hm.household_id,
        sum(hnf.afe_f) as afe_factor,
        sum(hnf.ame_f) as ame_factor,
        count(hm.id)
    from
        household_member hm
        join household_normalisation_factor hnf on hm.age_in_months = hnf.age_in_months
    where
        hm.sex = 'f'
    group by
        hm.household_id,
        hm.sex
    union
    -- AFE/AME for males
    select
        hm.household_id,
        sum(hnf.afe_m) as afe_factor,
        sum(hnf.ame_f) as ame_factor,
        count(hm.id)
    from
        household_member hm
        join household_normalisation_factor hnf on hm.age_in_months = hnf.age_in_months
    where
        hm.sex = 'm'
    group by
        hm.household_id,
        hm.sex
)
select
    household_id,
    sum(afe_factor) as afe_factor,
    sum(ame_factor) as ame_factor,
    sum(count) as member_count
from
    factors
group by
    household_id;

COMMENT ON VIEW afe_ear_threshold IS 'View to calculate the Adult Female Equivalent (AFE) factor for a household as the sum of household members AFE factor;
