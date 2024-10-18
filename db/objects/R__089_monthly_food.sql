 DROP MATERIALIZED VIEW IF EXISTS monthly_food;
 CREATE MATERIALIZED VIEW monthly_food AS

WITH base_data AS (
    SELECT
        flfc.micronutrient_id AS mn_name,
        sum(flfc.micronutrient_composition / 100 * amount_consumed_in_g) AS mn_consumed,
        EXTRACT(MONTH FROM hh.interview_date) AS month_consumed,
        fg.food_group_id,
        fgi.food_group_name,
        -1 AS fct_source_id,
        hh.survey_id
    FROM
        household_consumption AS hc
        JOIN household AS hh ON hc.household_id = hh.id
        JOIN household_fct_list hfl ON hh.id = hfl.household_id
        JOIN fct_list_food_composition flfc 
            ON flfc.fct_list_id = hfl.fct_list_id 
            AND flfc.food_genus_id = hc.food_genus_id
        JOIN food_genus fg ON fg.id = flfc.food_genus_id
        JOIN food_group_items fgi ON fgi.food_group_id = fg.food_group_id
    WHERE
        flfc.micronutrient_composition IS NOT NULL
        AND amount_consumed_in_g IS NOT NULL
    GROUP BY
        hh.survey_id,
        fg.food_group_id,
        fgi.food_group_name,
        flfc.micronutrient_id,
        month_consumed
),
aggregated_data AS (
    SELECT
        mn_name,
        month_consumed,
        fct_source_id,
        survey_id,
        sum(mn_consumed) OVER (PARTITION BY mn_name, month_consumed, fct_source_id, survey_id) AS total_mn_consumed,
        mn_consumed,
        food_group_id,
        food_group_name
    FROM base_data
    WHERE mn_consumed > 0
)
SELECT
    fct_source_id,
    ROUND((mn_consumed / total_mn_consumed) * 100, 1) AS percentage_mn_consumed,
    mn_name,
    month_consumed,
    food_group_id,
    food_group_name,
    mn_consumed,
    total_mn_consumed
FROM aggregated_data
GROUP BY fct_source_id
ORDER BY
    mn_name,
    month_consumed,
    mn_consumed DESC NULLS LAST;
