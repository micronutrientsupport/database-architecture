SELECT
	round( (mn_consumed / sum(mn_consumed) OVER (PARTITION BY mn_name, month_consumed, fct_source_id, survey_id)) * 100 , 1) AS percentage_mn_consumed
	, *
FROM (
	SELECT
		 mn_name
		 , sum((mn_value / 100 * amount_consumed_in_g )) AS mn_consumed
		 , EXTRACT(MONTH FROM hh.interview_date) AS month_consumed
		 , fg.food_group_id
		 , fgi.food_group_name
		 , fct_source_id
		 , hh.survey_id
	FROM
	    food_genus_nutrients_pivot AS fgnp
	    JOIN household_consumption AS hhc ON hhc.food_genus_id = fgnp.food_genus_id
	    JOIN household AS hh ON hhc.household_id = hh.id
	    JOIN food_genus fg ON fg.id = fgnp.food_genus_id
	    join food_group_items fgi on fgi.food_group_id = fg.food_group_id

	WHERE
		1=1
		AND mn_value IS NOT NULL
		AND amount_consumed_in_g IS NOT NULL
	GROUP BY
		survey_id
		, fct_source_id
		, fg.food_group_id
		, fgi.food_group_name
		, mn_name
		, month_consumed
) a
WHERE mn_consumed > 0

ORDER BY
	mn_name
	, month_consumed
	, mn_consumed DESC NULLS LAST