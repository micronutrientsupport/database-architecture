CREATE or replace function test_json_vals(int_id integer) returns void

AS $$

declare 

cells_all jsonb;

 i record;
value_2 text;

begin
	
RAISE NOTICE '%', 'start checking...';

cells_all := get_intervention_data_as_json(int_id);

  FOR i IN select * from jsonb_each_text(cells_all)
  loop
  
  	select intervention_data ->> i.key into value_2
 	from intervention_data_json
 	where intervention_id = int_id;
  
 	if (round(i.value::numeric,2) <> round(value_2::numeric,2))
 	or (i.value is null and value_2 is not null)
 	or (i.value is not null and value_2 is null) then
	    RAISE NOTICE 'key %', i.key;
	    RAISE NOTICE 'value 1: %', i.value;
	   	RAISE NOTICE 'value 2: %', value_2;
	end if;

  END LOOP;

RAISE NOTICE '%', 'checking ended.';
 
end;

$$ LANGUAGE plpgsql;
