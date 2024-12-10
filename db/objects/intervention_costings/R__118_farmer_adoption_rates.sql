create or replace view intervention_farmer_adoption_rates as



with baseline_assumptions as 
(
select 
	intervention_id
	, json_array_elements(data)->>'rowName' as row_name
	, json_array_elements(data) as data
from intervention_values_json ivj
where header1 = 'Farmer adoption rates'
),
adoption_local AS (
	select
		intervention_id
	   	, data as adoption_rate_local
	from baseline_assumptions ba
	where ba.row_name = 'farmer_adoption_rate_local'
),
adoption_hybrid as (
	select
		intervention_id
	   	, data as adoption_rate_hybrid
	from baseline_assumptions ba
	where ba.row_name = 'farmer_adoption_rate_hybrid'
),
adoption_recycled as (
	select
		intervention_id
	   	, data as adoption_rate_recycled
	from baseline_assumptions ba
	where ba.row_name = 'farmer_adoption_rate_recycled'
)

select
    al.intervention_id,
    json_build_object(
        'adoptionRateLocal',
        adoption_rate_local,
        'adoptionRateHybrid',
        adoption_rate_hybrid,
        'adoptionRateRecycled',
        adoption_rate_recycled
	) as farmer_adoption_rates
from
    adoption_local al
    join adoption_hybrid ah on al.intervention_id = ah.intervention_id
    join adoption_recycled ar on al.intervention_id = ar.intervention_id;
