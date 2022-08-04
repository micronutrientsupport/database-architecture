create or replace view country_consumption_fctlist_matches
as

--select * from country_consumption cc 
--join fct_list_food_composition flfc on (flfc.fct_used is null and flfc.micronutrient_id = 'Ca')

--select count(*) from country_consumption cc where cc.data_source_id = 13
with country_consumption_totals as (
 select 
    data_source_id
 	, count(amount_consumed_in_g) as total_count
 	, sum(amount_consumed_in_g) as total_weight
 from country_consumption cc
 group by cc.data_source_id 
), 
foo as (
	select 
		cc.*, 
		flfc.fct_list_id, 
		flfc.micronutrient_id , 
		flfc.fct_used as fct_used_id,
		fs2.name as fct_used_name
	from country_consumption cc
	left outer join fct_list_food_composition flfc on 
	flfc.food_genus_id = cc.food_genus_id
	join fct_source fs2 on flfc.fct_used = fs2.id 
),
agg as (
select 
	foo.data_source_id as consumption_data_id
	, micronutrient_id
	, fct_list_id as composition_list_id
	, fct_used_id as composition_source_id
	, fct_used_name as composition_source_name
	, count(*) as consumption_matched_count
	, cct.total_count as consumption_total_count
	, round((count(*)::numeric / total_count)*100,2) as consumption_matched_count_percentage
	, sum(amount_consumed_in_g) as consumption_matched_weight
	, cct.total_weight as consumption_total_weight
	, round(sum((amount_consumed_in_g) / total_weight)*100,2) as consumption_matched_weight_percentage
	from foo
join country_consumption_totals cct on foo.data_source_id = cct.data_source_id 
group by foo.data_source_id, micronutrient_id, fct_list_id, fct_used_id, fct_used_name, cct.total_count, cct.total_weight
order by foo.data_source_id, fct_list_id ASC, consumption_matched_count DESC
)
select * from agg;
--select data_source_id, fct_list_id, sum(count) from agg group by data_source_id, fct_list_id
