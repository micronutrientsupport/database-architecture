create or replace view household_consumption_fctlist_matches
as

with
household_consumption_totals as (
 select 
    h.survey_id as data_source_id
 	, count(amount_consumed_in_g) as total_count
 	, sum(amount_consumed_in_g) as total_weight
 from household_consumption hc
 join household h on hc.household_id = h.id 
 group by h.survey_id 
)
--select * from household_consumption_totals
,
foo as (
select h.survey_id, hc.food_genus_id, hc.amount_consumed_in_g, flfc.micronutrient_id, flfc.micronutrient_composition, flfc.fct_used, fs2."name"  as fct_used_name 
from
household_consumption hc
join household h on hc.household_id = h.id
join household_fct_list hfl on hfl.household_id = h.id
join fct_list_food_composition flfc on flfc.food_genus_id = hc.food_genus_id and flfc.fct_list_id = hfl.fct_list_id 
join fct_source fs2 on flfc.fct_used = fs2.id 
where fct_used is not NULL
),
agg as 
(select 
survey_id as consumption_data_id
, micronutrient_id
, -1 as composition_list_id
, fct_used as composition_source_id
, fct_used_name as composition_source_name
, count(amount_consumed_in_g) as consumption_matched_count
, total_count as consumption_total_count
, round((count(*)::numeric / total_count)*100,2) as consumption_matched_count_percentage
, sum(amount_consumed_in_g) as consumption_matched_weight
, total_weight as consumption_total_weight
, round(sum((amount_consumed_in_g) / total_weight )*100,2) as consumption_matched_weight_percentage
from foo
join household_consumption_totals hct on foo.survey_id = hct.data_source_id
group by survey_id, micronutrient_id, fct_used, fct_used_name, total_weight, total_count
)
select * from agg order by consumption_data_id, composition_list_id asc, consumption_matched_count DESC;