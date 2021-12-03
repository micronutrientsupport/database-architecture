create or replace function create_scenario_fct(_fct_source_id numeric, _food_genus text[], _field text, _new_value numeric[])

returns setof fooditem as
$$
DECLARE
  schema text := current_schema();
  mn_field text := (SELECT LOWER(fooditem_column) FROM micronutrient WHERE id=_field);
  the_query text := '';
BEGIN
	
   FOR i IN 1 .. array_upper(_food_genus, 1)
   loop
      RAISE NOTICE 'Replacing % in consumption of food genus % to %', _field, _food_genus[i], _new_value[i];
     	
      if i != 1 then
        the_query := the_query || 'UNION ';
      end if;
     
     
      the_query := the_query || 'SELECT ' || replace(
	 -- QUERY information schema table to get list of column names as a string seperated by comma
	 array_to_string(ARRAY(SELECT c.column_name
        FROM information_schema.columns As c
            WHERE table_name = 'fooditem' and table_schema = schema
           -- AND  c.column_name NOT IN('ca_in_mg')
    	), ',')
   		-- replace <field> with '<newvalue> as <field>' in query text
    , '' || mn_field || '', '' || _new_value[i] || '::numeric(20,10) as ' || mn_field || '') 
   || ' FROM "' || schema || '".fooditem WHERE fct_source_id=' || _fct_source_id || ' AND food_genus_id=''' || _food_genus[i] || '''';

   END LOOP;
	
  
  	the_query := the_query || 'UNION SELECT * from "' || schema || '".fooditem WHERE fct_source_id=' || _fct_source_id || ' AND NOT food_genus_id = ANY(ARRAY[''' || array_to_string(_food_genus, ''',''') || '''])';
	
  
    RAISE NOTICE 'Query: %', the_query;
 
   
	return query execute the_query;

  return;

END
$$
language plpgsql;

--select * from create_scenario_fct(24, ARRAY ['1341.01', '1594.01', '1312.01'], 'Mg'::text, ARRAY [5000, 75, 20]);