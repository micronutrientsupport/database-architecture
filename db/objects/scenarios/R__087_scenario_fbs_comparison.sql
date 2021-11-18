create or replace function create_scenario_fbs_comparison(_country_consumption_source_id numeric, _food_genus text[], _field text, _new_food_genus text[])

returns setof country_consumption as
$$
DECLARE
  schema text := current_schema();
  mn_field text := (SELECT LOWER(fooditem_column) FROM micronutrient WHERE id=_field);
  the_query text := '';
BEGIN
	
   FOR i IN 1 .. array_upper(_food_genus, 1)
   loop
      RAISE NOTICE 'Replacing consumption of food genus % with %', _food_genus[i], _new_food_genus[i];
     	
      if i != 1 then
        the_query := the_query || 'UNION ';
      end if;
     
     
      the_query := the_query || 'SELECT ' || replace(
	 -- QUERY information schema table to get list of column names as a string seperated by comma
	 array_to_string(ARRAY(SELECT c.column_name
        FROM information_schema.columns As c
            WHERE table_name = 'country_consumption' and table_schema = schema
    	), ',')
   		-- replace <field> with '<newvalue> as <field>' in query text
    , 'food_genus_id', '''' || _new_food_genus[i] || ''' as food_genus_id') 
   || ' FROM "' || schema || '".country_consumption WHERE data_source_id=' || _country_consumption_source_id || ' AND food_genus_id=''' || _food_genus[i] || '''';

   END LOOP;
	
  
  	the_query := the_query || 'UNION SELECT * from "' || schema || '".country_consumption WHERE data_source_id=' || _country_consumption_source_id || ' AND NOT food_genus_id = ANY(ARRAY[''' || array_to_string(_food_genus, ''',''') || '''])';
	
  
    RAISE NOTICE 'Query: %', the_query;
 
   
	return query execute the_query;

  return;

END
$$
language plpgsql;

--select * from create_scenario_fbs_comparison(1, ARRAY ['23110.02'], 'Mg'::text, ARRAY ['1594.01']) where food_genus_id = '1594.01';