DROP MATERIALIZED VIEW IF EXISTS top20_mn_per_country;
CREATE MATERIALIZED VIEW top20_mn_per_country AS



SELECT b.* 
    , food_genus.food_name
	, food_group.id as food_group_id
	, food_group.name as food_group_name
FROM (
	SELECT
		*
		, row_number() over (
			PARTITION BY
				country_id
				, fct_list_id
				, data_source_id
				, mn_name
			ORDER BY mn_consumed_per_day desc NULLS LAST
		) as ranking
	FROM (
		SELECT
			cc.country_id
			, flfc.fct_list_id
			, cc.data_source_id
			, flfc.micronutrient_id as mn_name
			, flfc.food_genus_id
			, sum( (flfc.micronutrient_composition  / 100 * amount_consumed_in_g) )  AS mn_consumed_per_day
		FROM fct_list_food_composition flfc

		JOIN 
		(select cc1.food_genus_id,
				cc1.data_source_id, 
				c1.id as country_id,
				cc1.amount_consumed_in_g
			from
			country_consumption cc1,
			country_consumption_source ccs1,
			country c1 
			where 
			cc1.data_source_id = ccs1.id 
			and st_equals(ccs1.geometry, c1.geometry)) cc
		ON cc.food_genus_id = flfc.food_genus_id
		-- WHERE date_part('year', cc.date_consumed) = 2018
		GROUP BY
			cc.data_source_id
			, flfc.food_genus_id
			, flfc.fct_list_id
			, country_id
			, mn_name
	) a
) b
JOIN food_genus ON b.food_genus_id = food_genus.id
JOIN food_group ON food_genus.food_group_id = food_group.id
WHERE ranking <= 20
ORDER BY country_id, mn_name, ranking asc
;

COMMENT ON MATERIALIZED VIEW top20_mn_per_country IS 'View showing the rankings of how much each food genus contributes to a particular micronutrient intake in a particular country and data set.'
