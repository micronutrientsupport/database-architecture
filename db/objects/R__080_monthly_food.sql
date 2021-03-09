 DROP MATERIALIZED VIEW IF EXISTS monthly_food;
 CREATE MATERIALIZED VIEW monthly_food AS


SELECT
	round( (mn_consumed / sum(mn_consumed) OVER (PARTITION BY mn_name, month_consumed, fct_source_id, survey_id)) * 100 , 1) AS percentage_mn_consumed
	, *
FROM (
	SELECT
		 mn_name
		 , sum((mn_value / 100 * amount_consumed_in_g )) AS mn_consumed
		 , EXTRACT(MONTH FROM hh.interview_date) AS month_consumed
		 , fg.food_group
		 , fct_source_id
		 , hh.survey_id
	FROM
	    food_genus_nutrients_pivot AS fgnp
	    JOIN household_consumption AS hhc ON hhc.food_genus_id = fgnp.food_genus_id
	    JOIN household AS hh ON hhc.household_id = hh.id
	    JOIN food_genus fg ON fg.id = fgnp.food_genus_id

	WHERE
		1=1
		AND mn_value IS NOT NULL
		AND amount_consumed_in_g IS NOT NULL
	GROUP BY
		survey_id
		, fct_source_id
		, food_group
		, mn_name
		, month_consumed
) a

ORDER BY
	mn_name
	, month_consumed
	, mn_consumed DESC NULLS LAST

