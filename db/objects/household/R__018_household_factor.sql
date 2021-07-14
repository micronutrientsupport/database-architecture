CREATE
OR replace view household_normalisation AS 
WITH factors AS (
    -- AFE/AME for females
    SELECT
        hm.household_id,
        sum(hnf.afe) AS afe_factor,
        sum(hnf.ame) AS ame_factor,
        count(hm.id)
    FROM
        household_member hm
        JOIN household_normalisation_factor hnf 
        ON hm.age_in_months = hnf.age_in_months
        AND hm.sex = hnf.sex
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

COMMENT ON VIEW household_normalisation IS 'View to calculate the Adult Female Equivalent (AFE) factor for a household as the sum of household members AFE factor';