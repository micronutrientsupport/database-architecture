CREATE OR REPLACE FUNCTION create_derived_intervention(_parent_id numeric, _new_name text, _new_description text, _new_country text, _new_focus_micronutrient text, _new_focus_geography text, _user_id text, _new_status integer, _new_nature integer)
RETURNS setof intervention_list AS

-- Creates a new record in the intervention table with data copied from the provided
-- intervention id

-- Duplicates all rows from the intervention_data table with the intervention_id of
-- the new intervention

$$
DECLARE
   _new_id   numeric;  -- id of new intervention
   _new_food_vehicle_id  numeric;  -- id of food vehicle
begin
	
-- Create new intervention in intervention table
insert into intervention (
	intervention_name
	, description
	, country_id
	, app_user_id
	, data_citation_id
	, focus_micronutrient
	, focus_geography
	, food_vehicle_id
	, fortification_type_id
	, program_status
	, file_name 
	, base_year 
	, is_premade 
	, is_locked
	, parent_intervention 
	, template_intervention
	, last_edited
	, intervention_status
	, intervention_nature
)
select 
	_new_name
	, _new_description
	, COALESCE(NULLIF(_new_country,''),country_id)
	, _user_id
	, data_citation_id
	, COALESCE(NULLIF(_new_focus_micronutrient,''),focus_micronutrient)
	, COALESCE(NULLIF(_new_focus_geography,''),focus_geography)
	, food_vehicle_id
	, fortification_type_id
	, program_status
	, 'User Defined' as file_name
	, coalesce(base_year,2023)
	, false as is_premade 
	, false as is_locked
	, _parent_id as parent_intervention
	, get_intervention_template_parent_id(_parent_id::int) as template_intervention
	, NOW()
	, _new_status as intervention_status
	, _new_nature as intervention_nature
from intervention where id = _parent_id
returning id INTO _new_id
;

-- Lock the parent intervention
-- update intervention set is_locked = '1' where id = _parent_id;

-- Duplicate intervention_data rows from
-- parent intervention with the new intervention_id
insert into intervention_data (
	intervention_id
	, row_index
	, row_name
	, header1 
	, header2 
	, factor_text 
	, year_0 
	, year_1 
	, year_2 
	, year_3 
	, year_4 
	, year_5 
	, year_6 
	, year_7 
	, year_8 
	, year_9
	, notes
	, source
	, units
	, is_user_editable
	, is_calculated
	, intervention_status
	, intervention_nature
)
select 
	_new_id as intervention_id,
	row_index,
	row_name,
	header1,
	header2,
	factor_text,
	year_0,
	year_1,
	year_2,
	year_3,
	year_4,
	year_5,
	year_6,
	year_7,
	year_8,
	year_9,
	notes,
	source,
	units,
	is_user_editable,
	is_calculated,
	intervention_status,
	intervention_nature
from intervention_data 
where intervention_id = _parent_id and intervention_status = _new_status and intervention_nature = _new_nature;

-- Duplicate intervention_targeting rows from
-- parent intervention with the new intervention_id
insert into fortification_level (
	intervention_id
	, fortificant_id
	, year
	, fortificant_activity
	, fortificant_overage 
	, fortificant_price
)
select 
	_new_id as intervention_id
	, fortificant_id
	, year
	, fortificant_activity 
	, fortificant_overage
	, fortificant_price
from fortification_level 
where intervention_id = _parent_id;

-- Duplicate relevant reference thresholds from intake_thresholds
-- into intervention specific threshold record in intervention_thresholds
insert into intervention_thresholds (
	intervention_id
	, nutrient
	, unit_adequacy
	, unit_excess
	, reference_person
	, ear
	, ear_default
	, ul
	, ul_default
	, energy
	, energy_default
	, notes
	, source
)
select 
	_new_id as intervention_id
	, nutrient
	, unit_adequacy
	, unit_excess
	, reference_person
	, ear
	, ear
	, ul
	, ul
	, 2100
	, 2100
	, notes
	, source
from intake_threshold 

where nutrient = (select focus_micronutrient from intervention i where id = _new_id);

-- Duplicate relevant reference taregting from fortification_targeting
-- into intervention specific threshold record in intervention_targeting
with ft_normalised as (
	select 
		food_vehicle_id
		,lower(targeting_type) as targeting_type
		,region
		,is_region_targeted
		,zones_targeted
		,cultivation_area_ha
		,targeted_area_ha
		,regional_share_pc
		, case when file_name like '%Malawi%' then 'MWI'
			when file_name like '%Ethiopia%' then 'ETH'
			else ''
		  end as country_id
	from fortification_targeting ft
)
insert into intervention_targetting (
	intervention_id
	, region
	, is_region_targeted
	, zones_targeted
	, cultivation_area_ha
	, targeted_area_ha
	, regional_share_pc
)
select i.id as intervention_id
	, ft.region
	, ft.is_region_targeted
	, ft.zones_targeted
	, ft.cultivation_area_ha
	, ft.targeted_area_ha
	, ft.regional_share_pc
from intervention i 
join fortification_type f on f.id = i.fortification_type_id
join ft_normalised ft on ft.food_vehicle_id = i.food_vehicle_id and ft.country_id = i.country_id and ft.targeting_type = lower(f.name) 
where 
	(i.fortification_type_id = 'BF' or i.fortification_type_id = 'AF')
	and i.id = _new_id;


-- Duplicate relevant reference expected losses from expected_losses
-- into intervention specific threshold record in intervention_thresholds

select 
	food_vehicle_id into _new_food_vehicle_id
from intervention where id = _new_id
;

with food_vehicle_standards as (
select 
	unnest(food_vehicle_standard)->>'micronutrient' as micronutrient, 
	json_array_elements((unnest(food_vehicle_standard)->>'compounds')::json) as compounds
from intervention_vehicle_standard ivs 
where ivs.intervention_id = _new_id
),
intervention_premix as (
select array_agg(micronutrient) as premix_micronutrients from food_vehicle_standards
where (compounds->>'targetVal')::numeric > 0)


insert into intervention_expected_losses (
	intervention_id
	, micronutrient_id
	, expected_losses
	, expected_losses_default
	, source
)

select 
	_new_id as intervention_id
	, micronutrient_id
	, expected_losses
	, expected_losses 
	, source
from expected_losses, intervention_premix
where micronutrient_id = ANY(premix_micronutrients)
and food_vehicle_id = _new_food_vehicle_id;

return query select * from intervention_list where id = _new_id;

END
$$
language plpgsql;

comment on function create_derived_intervention is 'Create a new intervention, derived from an existing intervention id';

--select * from create_derived_intervention(1,1);
