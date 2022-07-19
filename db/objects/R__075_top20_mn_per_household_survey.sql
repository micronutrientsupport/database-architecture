DROP MATERIALIZED VIEW IF EXISTS top20_mn_per_hhsurvey;
CREATE MATERIALIZED VIEW top20_mn_per_hhsurvey AS

SELECT b.* , food_genus.food_name
	, food_group.id as food_group_id
	, food_group.name as food_group_name
FROM (
	SELECT
		-1 as fct_source_id
		, *
		, row_number() over (
			PARTITION BY
				survey_id
				--, fct_source_id
				-- , data_source_id
				, mn_name
			ORDER BY mn_consumed_per_day desc NULLS LAST
		) as ranking
	FROM (
select 
	hh.survey_id
	--, hfl.fct_list_id as fct_source_id
	, flfc.micronutrient_id as mn_name
	, sum( (flfc.micronutrient_composition / 100 * amount_consumed_in_g) )/(select afe_total from survey_member_count smc where smc.survey_id = hh.survey_id)  AS mn_consumed_per_day
	, hc.food_genus_id
from household_consumption hc 
join household hh on hc.household_id = hh.id
join household_fct_list hfl on hh.id = hfl.household_id 
join fct_list_food_composition flfc on flfc.fct_list_id = hfl.fct_list_id and flfc.food_genus_id = hc.food_genus_id 
--where flfc.micronutrient_id = 'Ca'
GROUP BY
	hh.survey_id
	, hc.food_genus_id
	--, hfl.fct_list_id
	, mn_name
	) a
) b
JOIN food_genus ON b.food_genus_id = food_genus.id
JOIN food_group ON food_genus.food_group_id = food_group.id
WHERE ranking <= 20
ORDER BY survey_id, mn_name, ranking asc;

COMMENT ON MATERIALIZED VIEW top20_mn_per_hhsurvey IS 'View showing the rankings of how much each food genus contributes to a particular micronutrient intake in a particular household consumption survey.'
