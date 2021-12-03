CREATE OR REPLACE VIEW household_unmatched_items AS

with household_fooditems as (
select 
	distinct(hc.food_genus_id)
        --, sum(amount_consumed_in_g) as amount_consumed_in_g
        , h.survey_id 
        --, sum(hn.afe_factor) 
        , count(h.id) as household_count
        , sum(amount_consumed_in_g) / sum(hn.afe_factor) as amount_consumed_in_g -- per AFE
    from household_consumption hc
    join household h on hc.household_id = h.id 
    join household_normalisation hn on hn.household_id = h.id
    group by hc.food_genus_id, h.survey_id
),
household_consumption_fct_matches as (
	select 
		hf.survey_id
		, hf.amount_consumed_in_g
		, hf.food_genus_id
		, hf.household_count
		, ARRAY_AGG(fct_source_id) as included_fcts
	from household_fooditems hf 
	join fooditem f on f.food_genus_id = hf.food_genus_id 
	group by survey_id, hf.food_genus_id, household_count, amount_consumed_in_g
)

select
	hft.survey_id as consumption_data_id
	, fct.id as composition_data_id
	, hft.amount_consumed_in_g
	, hft.household_count
	, hft.food_genus_id
    , fg.food_name as food_genus_name
	from household_consumption_fct_matches hft
	join fct_source fct on fct.id != all (included_fcts)
    join food_genus fg on hft.food_genus_id = fg.id
	group by hft.survey_id, fct.id, amount_consumed_in_g, household_count, food_genus_id, food_name, included_fcts
order by hft.survey_id, food_genus_id, composition_data_id;

COMMENT ON VIEW household_unmatched_items IS 'List of food_genuses unmatched to composition data for household level consumption data';
