CREATE OR REPLACE VIEW country_unmatched_items AS

with consumption_matches as (
select 
	cc.*
	, fg.*
	, fct_list_id
	, micronutrient_id
	, fct_used 
from country_consumption cc 
left join food_genus fg on cc.food_genus_id = fg.id 
left join fct_list_food_composition flfc on cc.food_genus_id = flfc.food_genus_id
)

select 
	micronutrient_id
	, data_source_id as consumption_data_id
	, fct_list_id as composition_data_id
	, food_genus_id
	, food_name as food_genus_name
	, description as food_genus_description
	, food_genus_confidence
	, original_id
	, original_name
	, date_consumed
	, amount_consumed_in_g 
from consumption_matches where fct_used is null;

--select * from consumption_unmatched where composition_data_id = 41 and micronutrient_id = 'B9' and consumption_data_id = 35

COMMENT ON VIEW country_unmatched_items IS 'List of food_genuses unmatched to composition data for country level consumption data';
