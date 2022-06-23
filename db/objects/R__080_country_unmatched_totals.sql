
CREATE OR REPLACE VIEW country_unmatched_totals AS

with country_consumption_fct_matches as (
select 
data_source_id
, fct_list_id
, amount_consumed_in_g as amount_consumed_in_g
, cc.food_genus_id
, ARRAY_AGG(distinct fct_list_id) as included_fcts
from country_consumption cc 
join fct_list_food_composition f on f.food_genus_id = cc.food_genus_id 
group by 
data_source_id, 
fct_list_id, 
cc.food_genus_id, 
amount_consumed_in_g
order by food_genus_id, data_source_id 
),
country_consumption_totals as (
 select 
    data_source_id
 	, count(amount_consumed_in_g) as total_count
 	, sum(amount_consumed_in_g) as total_weight
 from country_consumption cc
 group by cc.data_source_id 
)

select 
	cft.data_source_id as consumption_data_id
	, fct_list_id as composition_data_id
	, total_count as consumption_total_items
	, count(amount_consumed_in_g) as consumption_unmatched_count
	, round((count(amount_consumed_in_g)::numeric / total_count)*100,2) as consumption_unmatched_count_percentage
	, total_weight as consumption_total_weight
	, sum(amount_consumed_in_g) as consumption_unmatched_weight
	, round(sum((amount_consumed_in_g) / total_weight)*100,2) as consumption_unmatched_weight_percentage
	--, cft.amount_consumed_in_g
	--, cft.food_genus_id
	from country_consumption_fct_matches cft
	--join fct_source fct on fct.id != all (included_fcts)
	join country_consumption_totals cct on cct.data_source_id = cft.data_source_id
	group by cft.data_source_id, 
	cft.fct_list_id
	--fct.id,
	cct.total_count, cct.total_weight --, amount_consumed_in_g, food_genus_id
order by cft.data_source_id;--, composition_data_id;

COMMENT ON VIEW country_unmatched_totals IS 'Summary stats for unmatched food_genuses to composition data for country level consumption data';