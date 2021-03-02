
-- Naive implementation: do this for each of the 35 mincronutrients and UNION ALL them together
SELECT * FROM (
	SELECT
        'TotalProtein_in_g'
		, max(fg.food_name)
		, country_id
		, sum(amount_consumed_in_g * TotalProtein_in_g) AS protscore
		, ROW_NUMBER() over (
		    partition by cc.country_id--, original_name
		    order BY
		        sum(TotalProtein_in_g / 100 * amount_consumed_in_g) desc
		) as rank
	FROM country_consumption cc
	JOIN food_genus fg ON cc.food_genus_id = fg.id
	JOIN fooditem fi ON fg.id = fi.food_genus_id
	GROUP BY  cc.food_genus_id, cc.country_id, original_name
	ORDER by  sum(amount_consumed_in_g * TotalProtein_in_g)  DESC NULLS LAST
) TotalProtein_in_g
WHERE rank <= 20
UNION ALL
SELECT * FROM (
	SELECT
        'totalfats_in_g'
		, max(fg.food_name)
		, country_id
		, sum(amount_consumed_in_g * totalfats_in_g) AS fatscore
		, ROW_NUMBER() over (
		    partition by cc.country_id--, original_name
		    order BY
		        sum(totalfats_in_g / 100 * amount_consumed_in_g) desc
		) as rank
	FROM country_consumption cc
	JOIN food_genus fg ON cc.food_genus_id = fg.id
	JOIN fooditem fi ON fg.id = fi.food_genus_id
	GROUP BY  cc.food_genus_id, cc.country_id, original_name
	ORDER by  sum(amount_consumed_in_g * totalfats_in_g)  DESC NULLS LAST
) totalfats_in_g
WHERE rank <= 20
