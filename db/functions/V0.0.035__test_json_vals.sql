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
  
 	if (round(i.value::numeric) <> round(value_2::numeric))
 	or (i.value is null and value_2 is not null)
 	or (i.value is not null and value_2 is null) then
	    RAISE NOTICE 'key %', i.key;
	    RAISE NOTICE 'Original value: %', i.value;
	   	RAISE NOTICE 'Calculated value: %', value_2;
	end if;

  END LOOP;

RAISE NOTICE '%', 'checking ended.';
 
end;

$$ LANGUAGE plpgsql;

comment on function test_json_vals is 'This function can be used to test the function which recalculates total values ''update_intervention_data_totals'' by comparing the original values to the recalculated values. It depends on the calculated values not being saved back to the table so run the above function but do not run ''update_intervention_data_table'' until tested.';