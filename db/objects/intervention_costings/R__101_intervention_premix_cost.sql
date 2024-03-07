create or replace view intervention_premix_cost as
-- Food Vehicle Standards from main data for targets
with fvs as 
(select 
	intervention_id
	, unnest(food_vehicle_standard)->>'micronutrient' as micronutrient_id
	, json_array_elements(unnest(food_vehicle_standard)->'compounds')->>'compound' as compound
	, json_array_elements(unnest(food_vehicle_standard)->'compounds')->>'targetVal' as target_val
from intervention_vehicle_standard)
-- Intervention specific fortification levels
, fl as (
select 
	fl.row_index
	, fl.intervention_id
	, fl.fortificant_id
	, fl.year
	, fl.fortificant_activity
	, fvs.target_val::numeric  as fortification_level
	, fl.fortificant_overage
	, ((1+fl.fortificant_overage)*fvs.target_val::numeric)/(fl.fortificant_activity) as fortificant_amount
	, fl.fortificant_price

from fortification_level fl 
join
	fortificant f on f.id = fl.fortificant_id 
left join fvs 
	on fvs.intervention_id = fl.intervention_id
	and fvs.micronutrient_id = f.micronutrient_id 
	and lower(fvs.compound) = lower(f.name)
)
-- Sub-total nutrient vals
, totals as (
select 
	intervention_id
	, sum(fortificant_amount) as nutrients_subtotal
from fl 
group by intervention_id 
)
-- Excipient Values
, excipient_config as (
	select 
		0.25 as filler_percentage
		, 1 as upcharge
)
-- Addition Rate
, addition_rate as (
select 
	intervention_id
	, (1+filler_percentage)*nutrients_subtotal as nutrient_and_excipient
	, case 
		when filler_percentage = 0 then nutrients_subtotal	
		else ceiling(((1+filler_percentage)*nutrients_subtotal) / 50) * 50
	  end as addition_rate
from totals, excipient_config
)
-- Grab cost values for the excipient also
, excipient as (
	select 
		fl.row_index
		, fl.intervention_id
		, fl.fortificant_id
		, fl.year
		, fl.fortificant_activity
		, 0  as fortification_level
		, fl.fortificant_overage
		, (addition_rate - nutrients_subtotal) as fortificant_amount
		, fl.fortificant_price
		from 
	fortification_level fl
	join fortificant f on fl.fortificant_id = f.id
	join addition_rate on fl.intervention_id = addition_rate.intervention_id
	join totals on fl.intervention_id = totals.intervention_id
	where f."name" = 'Excipient'
)
, fla as (
select
	fl.*,
	case 
		when addition_rate = 0 then fl.fortificant_amount	
		else fl.fortificant_amount * (1/addition_rate)
	  end as fortificant_proportion
from fl
join addition_rate ar on ar.intervention_id = fl.intervention_id

union

select
	e.*,
	case 
		when addition_rate = 0 then e.fortificant_amount	
		else e.fortificant_amount * (1/addition_rate)
	  end as fortificant_proportion
from excipient e
join addition_rate ar on ar.intervention_id = e.intervention_id

)
-- Calculate fortificant costs
, flc as (
select 
	fla.*
	, fla.fortificant_price * fla.fortificant_proportion as fortificant_cost
from fla
)
select 
	flc.intervention_id
	, ((sum(fortificant_cost)+upcharge)*addition_rate)/1000 as premix_cost_per_mt
from flc
join addition_rate ar on ar.intervention_id = flc.intervention_id 
, excipient_config
group by flc.intervention_id, upcharge, addition_rate;
	
	
create or replace view intervention_premix_calculator as

with fvs as 
(select 
	intervention_id
	, unnest(food_vehicle_standard)->>'micronutrient' as micronutrient_id
	, json_array_elements(unnest(food_vehicle_standard)->'compounds')->>'compound' as compound
	, json_array_elements(unnest(food_vehicle_standard)->'compounds')->>'targetVal' as target_val
from intervention_vehicle_standard)

select
	fl.intervention_id
	, fl.row_index
	, f.micronutrient_id as fortificant_micronutrient
	, f."name" as fortificant_compound
	, fl.fortificant_id
	, fvs.target_val::numeric  as fortification_level
	, fl.fortificant_activity as fortificant_activity
	, fl.fortificant_overage
	, fl.fortificant_price 
from 
	fortification_level fl 
join
	fortificant f on f.id = fl.fortificant_id 
left join fvs 
	on fvs.intervention_id = fl.intervention_id
	and fvs.micronutrient_id = f.micronutrient_id 
	and lower(fvs.compound) = lower(f.name)
order by fl.intervention_id, f.micronutrient_id asc;