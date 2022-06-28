CREATE OR REPLACE FUNCTION create_derived_intervention(_parent_id numeric, _new_name text, _new_description text, _user_id numeric)
RETURNS setof intervention_list AS

-- Creates a new record in the intervention table with data copied from the provided
-- intervention id

-- Duplicates all rows from the intervention_data table with the intervention_id of
-- the new intervention

$$
DECLARE
   _new_id   numeric;  -- id of new intervention
begin
	
-- Create new intervention in intervention table
insert into intervention (
	intervention_name
	, description
	, country_id
	, app_user_id
	, data_citation_id
	, food_vehicle_id
	, fortification_type_id
	, program_status
	, file_name 
	, base_year 
	, is_premade 
	, is_locked
	, parent_intervention 
)
select 
	_new_name
	, _new_description
	, country_id
	, _user_id
	, data_citation_id
	, food_vehicle_id
	, fortification_type_id
	, program_status
	, 'User Defined' as file_name
	, base_year
	, false as is_premade 
	, false as is_locked
	, _parent_id as parent_intervention
from intervention where id = _parent_id
returning id INTO _new_id
;

-- Lock the parent intervention
update intervention set is_locked = '1' where id = _parent_id;

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
	, units
	, is_user_editable
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
	units,
	is_user_editable
from intervention_data 
where intervention_id = _parent_id;


return query select * from intervention_list where id = _new_id;

END
$$
language plpgsql;

comment on function create_derived_intervention is 'Create a new intervention, derived from an existing intervention id';

--select * from create_derived_intervention(1,1);
