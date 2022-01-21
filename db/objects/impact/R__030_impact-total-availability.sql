CREATE OR REPLACE VIEW impact_total_food_availability AS

select
    country
	, year
	, scenario
	, sum(calcium) / 365 as calcium
	-- Get previous row value (partitioned by country/scenario and ordered as main table)
	--, LAG(sum(calcium),1) OVER (partition by country, scenario order by country, scenario, year ASC) as previous_calcium
	-- Subtract from current value to get diff
	--, sum(calcium)-(LAG(sum(calcium),1) OVER (partition by country, scenario order by country, scenario, year ASC)) as calcium_diff
	-- Calculate percentage change and round to 2dp
	, round(100*(sum(calcium)-(LAG(sum(calcium),1)       OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(calcium),1)    OVER (partition by country, scenario order by country, scenario, year ASC)),2) as calcium_diff
	, sum(folate) / 365 as folate
	, round(100*(sum(folate)-(LAG(sum(folate),1)         OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(folate),1)     OVER (partition by country, scenario order by country, scenario, year ASC)),2) as folate_diff
	, sum(iron) / 365 as iron
	, round(100*(sum(iron)-(LAG(sum(iron),1)             OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(iron),1)       OVER (partition by country, scenario order by country, scenario, year ASC)),2) as iron_diff
	, sum(magnesium) / 365 as magnesium
	, round(100*(sum(magnesium)-(LAG(sum(magnesium),1)   OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(magnesium),1)  OVER (partition by country, scenario order by country, scenario, year ASC)),2) as magnesium_diff
	, sum(niacin) / 365 as niacin
	, round(100*(sum(niacin)-(LAG(sum(niacin),1)         OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(niacin),1)     OVER (partition by country, scenario order by country, scenario, year ASC)),2) as niacin_diff
	, sum(phosphorus) / 365 as phosphorus
	, round(100*(sum(phosphorus)-(LAG(sum(phosphorus),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(phosphorus),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as phosphorus_diff
	, sum(potassium) / 365 as potassium
	, round(100*(sum(potassium)-(LAG(sum(potassium),1)   OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(potassium),1)  OVER (partition by country, scenario order by country, scenario, year ASC)),2) as potassium_diff
	, sum(protein) / 365 as protein
	, round(100*(sum(protein)-(LAG(sum(protein),1)       OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(protein),1)    OVER (partition by country, scenario order by country, scenario, year ASC)),2) as protein_diff
	, sum(riboflavin) / 365 as riboflavin
	, round(100*(sum(riboflavin)-(LAG(sum(riboflavin),1) OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(riboflavin),1) OVER (partition by country, scenario order by country, scenario, year ASC)),2) as riboflavin_diff
	, sum(thiamin) / 365 as thiamin
	, round(100*(sum(thiamin)-(LAG(sum(thiamin),1)       OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(thiamin),1)    OVER (partition by country, scenario order by country, scenario, year ASC)),2) as thiamin_diff
	, sum(vit_a) / 365 as vit_a
	, round(100*(sum(vit_a)-(LAG(sum(vit_a),1)           OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(vit_a),1)      OVER (partition by country, scenario order by country, scenario, year ASC)),2) as vit_a_diff
	, sum(vit_b6) / 365 as vit_b6
	, round(100*(sum(vit_b6)-(LAG(sum(vit_b6),1)         OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(vit_b6),1)     OVER (partition by country, scenario order by country, scenario, year ASC)),2) as vit_b6_diff
	, sum(vit_c) / 365 as vit_c
	, round(100*(sum(vit_c)-(LAG(sum(vit_c),1)           OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(vit_c),1)      OVER (partition by country, scenario order by country, scenario, year ASC)),2) as vit_c_diff
	, sum(zinc) / 365 as zinc
	, round(100*(sum(zinc)-(LAG(sum(zinc),1)             OVER (partition by country, scenario order by country, scenario, year ASC))) / (LAG(sum(zinc),1)       OVER (partition by country, scenario order by country, scenario, year ASC)),2) as zinc_diff


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
