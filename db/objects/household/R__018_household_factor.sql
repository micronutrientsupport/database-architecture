CREATE
OR replace view household_normalisation AS 
WITH factors AS (
    -- AFE/AME for females
    SELECT
        hm.household_id,
        sum(hnf.afe_f) AS afe_factor,
        sum(hnf.ame_f) AS ame_factor,
        count(hm.id)
    FROM
        household_member hm
        JOIN household_normalisation_factor hnf ON hm.age_in_months = hnf.age_in_months
    WHERE
        hm.sex = 'f'
    GROUP BY
        hm.household_id,
        hm.sex
    UNION
    -- AFE/AME for males
    SELECT
        hm.household_id,
        sum(hnf.afe_m) AS afe_factor,
        sum(hnf.ame_f) AS ame_factor,
        count(hm.id)
    FROM
        household_member hm
        JOIN household_normalisation_factor hnf ON hm.age_in_months = hnf.age_in_months
    WHERE
        hm.sex = 'm'
    GROUP BY
        hm.household_id,
        hm.sex
)
SELECT
    household_id,
    sum(afe_factor) AS afe_factor,
    sum(ame_factor) AS ame_factor,
    sum(count) AS member_count
FROM
    factors
GROUP BY
    household_id;

COMMENT ON VIEW afe_ear_threshold IS 'View to calculate the Adult Female Equivalent (AFE) factor for a household as the sum of household members AFE factor';