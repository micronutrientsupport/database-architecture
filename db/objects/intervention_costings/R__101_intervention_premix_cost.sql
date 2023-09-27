create or replace view intervention_premix_cost as

with excipient_config as (
	select 
		0.25 as filler_percentage
		, 1.5 as filler_price
		, 1 as upcharge
),
totals as (
select 
	intervention_id
	, sum(fortificant_amount) as nutrients_subtotal
	, sum(fortificant_proportion) as fortificant_proportion 
	, sum(fortificant_price * fortificant_proportion) as fortificant_cost
from fortification_level fl 
group by intervention_id 
),
excipient as (
select 
	intervention_id,
	nutrients_subtotal
	, fortificant_proportion
	, case 
		when filler_percentage = 0 then nutrients_subtotal	
		else round(((1+filler_percentage)*nutrients_subtotal) / 50) * 50
	  end as addition_rate
	, fortificant_cost
	  	
	from totals, excipient_config
),
filler_totals as (
	select 
		intervention_id
		, nutrients_subtotal
		, addition_rate
		, addition_rate - nutrients_subtotal as filler
		, greatest(1 - fortificant_proportion, 0) as filler_proportion
		, filler_price * greatest(1 - fortificant_proportion, 0) as filler_cost
		, fortificant_cost
	from excipient, excipient_config
)

select 
	intervention_id
--	, (fortificant_cost+filler_cost) as premix_cost
--	, (fortificant_cost+filler_cost+upcharge) as total_premix_cost
	, ((fortificant_cost+filler_cost+upcharge) * addition_rate)/1000 as premix_cost_per_mt
from filler_totals, excipient_config;
	
	

