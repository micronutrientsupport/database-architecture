CREATE OR REPLACE VIEW country_unmatched_items AS

with country_consumption_fct_matches as (
select data_source_id, amount_consumed_in_g as amount_consumed_in_g, f.food_genus_id, ARRAY_AGG(fct_source_id) as included_fcts
from country_consumption cc join fooditem f on f.food_genus_id = cc.food_genus_id group by data_source_id, f.food_genus_id, amount_consumed_in_g)

select 
	cft.data_source_id as consumption_data_id
	, fct.id as composition_data_id
	, cft.amount_consumed_in_g
	, cft.food_genus_id
	, fg.food_name as food_genus_name
	from country_consumption_fct_matches cft
	join fct_source fct on fct.id != all (included_fcts)
	join food_genus fg on cft.food_genus_id = fg.id
	group by cft.data_source_id, fct.id, amount_consumed_in_g, food_genus_id, food_name, included_fcts
order by cft.data_source_id, food_genus_id, composition_data_id;

COMMENT ON VIEW country_unmatched_items IS 'List of food_genuses unmatched to composition data for country level consumption data';
