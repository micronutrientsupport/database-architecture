create or replace function create_scenario_fct(_fct_source_id numeric, _food_genus text, _field text, _new_value numeric)

returns setof fooditem as
$$
DECLARE
  schema text := current_schema();
BEGIN

	return QUERY EXECUTE 
	 'SELECT ' || replace(
	 -- QUERY information schema table to get list of column names as a string seperated by comma
	 array_to_string(ARRAY(SELECT c.column_name
        FROM information_schema.columns As c
            WHERE table_name = 'fooditem' and table_schema = schema
           -- AND  c.column_name NOT IN('ca_in_mg')
    	), ',')
   		-- replace <field> with '<newvalue> as <field>' in query text
    , '' || _field || '', '' || _new_value || '::numeric(20,10) as ' || _field || '') 
   || ' FROM ' || schema || '.fooditem WHERE fct_source_id=' || _fct_source_id || ' AND food_genus_id=''' || _food_genus || '''
    UNION SELECT * from ' || schema || '.fooditem WHERE fct_source_id=' || _fct_source_id || ' AND food_genus_id!=''' || _food_genus || ''''
	;

END
$$
language plpgsql;

select 'fn' as source, * from do_scenario(10, 'andy94', 'fe_in_mg', 5000)