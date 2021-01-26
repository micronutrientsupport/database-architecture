CREATE OR REPLACE VIEW IMPACT_TOTAL_FOOD_AVAILABILITY AS

select 
    country
	, year
	, scenario
	, sum(calcium) as calcium 
	-- Get previous row value (partitioned by country/scenario and ordered as main table)
	--, LAG(sum(calcium),1) OVER (partition by country, scenario order by country, scenario, year ASC) as previous_calcium
	-- Subtract from current value to get diff
	--, sum(calcium)-(LAG(sum(calcium),1) OVER (partition by country, scenario order by country, scenario, year ASC)) as calcium_diff
	-- Calculate percentage change and round to 2dp
	, round(100*(sum(calcium)-(LAG(sum(calcium),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(calcium),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as calcium_diff
	, sum(folate) as folate
	, round(100*(sum(folate)-(LAG(sum(folate),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(folate),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as folate_diff
	, sum(iron) as iron
	, round(100*(sum(iron)-(LAG(sum(iron),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(iron),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as iron_diff
	, sum(magnesium) as magnesium
	, round(100*(sum(magnesium)-(LAG(sum(magnesium),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(magnesium),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as magnesium_diff
	, sum(niacin) as niacin
	, round(100*(sum(niacin)-(LAG(sum(niacin),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(niacin),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as niacin_diff
	, sum(phosphorus) as phosphorus
	, round(100*(sum(phosphorus)-(LAG(sum(phosphorus),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(phosphorus),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as phosphorus_diff
	, sum(potassium) as potassium
	, round(100*(sum(potassium)-(LAG(sum(potassium),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(potassium),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as potassium_diff
	, sum(protein) as protein
	, round(100*(sum(protein)-(LAG(sum(protein),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(protein),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as protein_diff
	, sum(riboflavin) as riboflavin
	, round(100*(sum(riboflavin)-(LAG(sum(riboflavin),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(riboflavin),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as riboflavin_diff
	, sum(thiamin) as thiamin
	, round(100*(sum(thiamin)-(LAG(sum(thiamin),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(thiamin),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as thiamin_diff
	, sum(vit_a) as vit_a
	, round(100*(sum(vit_a)-(LAG(sum(vit_a),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(vit_a),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as vit_a_diff
	, sum(vit_b6) as vit_b6
	, round(100*(sum(vit_b6)-(LAG(sum(vit_b6),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(vit_b6),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as vit_b6_diff
	, sum(vit_c) as vit_c
	, round(100*(sum(vit_c)-(LAG(sum(vit_c),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(vit_c),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as vit_c_diff
	, sum(zinc) as zinc
	, round(100*(sum(zinc)-(LAG(sum(zinc),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(zinc),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as zinc_diff


from impact_food_availability

group by 
	country
	, scenario
	, year
order by 
	country
	, scenario
	, year
	ASC