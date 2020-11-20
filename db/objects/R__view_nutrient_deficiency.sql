CREATE OR REPLACE VIEW individual_intake AS
WITH
    energy_ear as (
        SELECT ear
        FROM intake_threshold
        WHERE
            nutrient_name = 'Energy'
            AND sex = 'Male'
            AND age_lower = 50
    )
    , fe_ear as (
    SELECT ear
    FROM intake_threshold
    WHERE
        nutrient_name = 'Iron'
        AND sex = 'Male'
        AND age_lower = 50
)
SELECT
    member.id
    , sum(EnergyCalculated_in_kCal/100 * amount_consumed_in_g)    as "energy consumed per day"-- recommnded daily allowance
    , sum(EnergyCalculated_in_kCal/100 * amount_consumed_in_g) / (select ear from energy_ear) * 100 as "percent of 3200 consumed per day" -- recommnded daily allowance
    , sum(fe_in_mg/100 * amount_consumed_in_g) as  "iron intake"
    , sum(fe_in_mg/100 * amount_consumed_in_g) /  (select ear from fe_ear)  * 100 as "percent of 10ish  consumed per day" -- recommnded daily allowance

FROM
    fooditem food
JOIN HOUSEHOLD_MEMBER_CONSUMPTION hhmc ON hhmc.fooditem_id = food.id
JOIN HOUSEHOLD_MEMBER member ON member.id = hhmc.HOUSEHOLD_MEMBER_id
GROUP BY member.id
ORDER BY member.id
