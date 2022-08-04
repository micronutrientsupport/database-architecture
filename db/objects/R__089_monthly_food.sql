 DROP MATERIALIZED VIEW IF EXISTS monthly_food;
 CREATE MATERIALIZED VIEW monthly_food AS

SELECT
	round( (mn_consumed / sum(mn_consumed) OVER (PARTITION BY mn_name, month_consumed, fct_source_id, survey_id)) * 100 , 1) AS percentage_mn_consumed
	, *
FROM (
	SELECT
		 flfc.micronutrient_id  as mn_name
		 , sum((flfc.micronutrient_composition  / 100 * amount_consumed_in_g )) AS mn_consumed
		 , EXTRACT(MONTH FROM hh.interview_date) AS month_consumed
		 , fg.food_group_id
		 , fgi.food_group_name
		 , -1 as fct_source_id
		 , hh.survey_id
	FROM
	    household_consumption AS hc
	    JOIN household AS hh ON hc.household_id = hh.id
		join household_fct_list hfl on hh.id = hfl.household_id 
		join fct_list_food_composition flfc on flfc.fct_list_id = hfl.fct_list_id and flfc.food_genus_id = hc.food_genus_id 
	    JOIN food_genus fg ON fg.id = flfc.food_genus_id
	    join food_group_items fgi on fgi.food_group_id = fg.food_group_id
	    
	WHERE
		1=1
		AND flfc.micronutrient_composition IS NOT NULL
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