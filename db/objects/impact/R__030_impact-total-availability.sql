CREATE OR REPLACE VIEW IMPACT_TOTAL_FOOD_AVAILABILITY AS

select 
    country
	, year
	, scenario
	, sum(calcium) as calcium 
	, sum(folate) as folate
	, sum(iron) as iron
	, sum(magnesium) as magnesium
	, sum(niacin) as niacin
	, sum(phosphorus) as phosphorus
	, sum(potassium) as potassium
	, sum(protein) as protein
	, sum(riboflavin) as riboflavin
	, sum(thiamin) as thiamin
	, sum(vit_a) as vit_a
	, sum(vit_b6) as vit_b6
	, sum(vit_c) as vit_c
	, sum(zinc) as zinc

from impact_food_availability

group by 
	country
	, scenario
	, year 
	
order by 
	country
	, year
	, scenario
	ASC