create or replace view household_details as
select
	h.survey_id 
	, h.id as household_id
	, ST_X(ST_Centroid(ST_Transform(location, 4326))) AS longitude
	, ST_Y(ST_Centroid(ST_Transform(location, 4326))) AS latitude
	, lvl0.id as admin0_id
	, lvl0."name" as admin0_name
	, lvl1.id as admin1_id
	, lvl1."name" as admin1_name
	, lvl2.id as admin2_id
	, lvl2.name as admin2_name
	, h.urbanity
	, h.household_expenditure
	, h.wealth_quintile
	, hn.afe_factor
	, hn.member_count
	, hfl.fct_list_id
	from household h 
	left join aggregation_area lvl0 on st_contains(lvl0.geometry, h.location) AND (lvl0.id IS NULL OR (lvl0.type='country' AND lvl0.admin_level=0))
	left join aggregation_area lvl1 on st_contains(lvl1.geometry, h.location) AND (lvl1.id IS NULL OR (lvl1.type='admin' AND lvl1.admin_level=1))
	left join aggregation_area lvl2 on st_contains(lvl2.geometry, h.location) AND (lvl2.id IS NULL OR (lvl2.type='admin' AND lvl2.admin_level=2))
	left join household_normalisation hn on hn.household_id = h.id
	left join household_fct_list hfl on hfl.household_id = h.id;