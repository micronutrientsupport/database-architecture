create or replace view country_consumption_fctlist_matches
as

with country_consumption_totals as (
 select 
    data_source_id
 	, count(amount_consumed_in_g) as total_count
 	, sum(amount_consumed_in_g) as total_weight
 from country_consumption cc
 group by cc.data_source_id 
)

select 
cc.data_source_id
, micronutrient_id
, flfc.fct_used
, flfc.fct_list_id
, sum(amount_consumed_in_g) as weight
, cct.total_weight as weight_total
, round(((sum(amount_consumed_in_g)) / (cct.total_weight)) * 100,2) as weight_percentage
, count(cc.food_genus_id) as count
, cct.total_count as count_total
, round(((count(cc.food_genus_id))::numeric / (cct.total_count::numeric)) * 100,2) as count_percentage

from country_consumption cc 
left outer join fct_list_food_composition flfc on cc.food_genus_id = flfc.food_genus_id 
join country_consumption_totals cct on cct.data_source_id = cc.data_source_id 
--where data_source_id = 1 and cc.food_genus_id = '1501.02' and micronutrient_id = 'Ca'
group by cc.data_source_id, micronutrient_id, flfc.fct_used, flfc.fct_list_id, cct.total_weight, cct.total_count  

order by data_source_id, micronutrient_id, flfc.fct_used

