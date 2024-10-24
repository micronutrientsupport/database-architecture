DROP MATERIALIZED VIEW IF EXISTS top20_mn_per_hhsurvey;
CREATE MATERIALIZED VIEW top20_mn_per_hhsurvey AS

WITH NutrientConsumption AS (
    SELECT
        hh.survey_id,
        flfc.micronutrient_id AS mn_name,
        SUM(flfc.micronutrient_composition / 100 * hc.amount_consumed_in_g) / smc.afe_total AS mn_consumed_per_day,
        hc.food_genus_id
    FROM
        household_consumption hc
        JOIN household hh ON hc.household_id = hh.id
        JOIN household_fct_list hfl ON hh.id = hfl.household_id
        JOIN fct_list_food_composition flfc ON flfc.fct_list_id = hfl.fct_list_id AND flfc.food_genus_id = hc.food_genus_id
        JOIN survey_member_count smc ON smc.survey_id = hh.survey_id
    GROUP BY
        hh.survey_id, hc.food_genus_id, flfc.micronutrient_id, smc.afe_total
),
RankedNutrientConsumption AS (
    SELECT
        -1 AS fct_source_id,
        nc.*,
        ROW_NUMBER() OVER (
            PARTITION BY nc.survey_id, nc.mn_name
            ORDER BY nc.mn_consumed_per_day DESC NULLS LAST
        ) AS ranking
    FROM NutrientConsumption nc
)
SELECT
    b.*, 
    fg.food_name,
    fg.food_group_id,
    fg_group.name as food_group_name
FROM RankedNutrientConsumption b
JOIN food_genus fg ON b.food_genus_id = fg.id
JOIN food_group fg_group ON fg.food_group_id = fg_group.id
WHERE b.ranking <= 20
ORDER BY b.survey_id, b.mn_name, b.ranking ASC;
--Thanks ChatGPT :)

COMMENT ON MATERIALIZED VIEW top20_mn_per_hhsurvey IS 'View showing the rankings of how much each food genus contributes to a particular micronutrient intake in a particular household consumption survey.'
