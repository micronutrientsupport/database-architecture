CREATE or replace function get_intervention_data_as_json(int_id integer) returns jsonb

AS $$

declare 

cells_all jsonb;

calc_val numeric;

data_cur cursor for
select * from intervention_data
where intervention_id = int_id;

begin
	
	cells_all := '{"foo":null}'; -- this is required because if the variable is null, appending it to anything else reults in null

	for data_rec in data_cur loop
			
		-- null in postgres and null in json are slightly differnt so need precise handling. Coelesce didn't work.

			cells_all := cells_all || to_json_null(data_rec.row_index || '_0', data_rec.year_0);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_1', data_rec.year_1);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_2', data_rec.year_2);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_3', data_rec.year_3);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_4', data_rec.year_4);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_5', data_rec.year_5);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_6', data_rec.year_6);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_7', data_rec.year_7);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_8', data_rec.year_8);
			cells_all := cells_all || to_json_null(data_rec.row_index || '_9', data_rec.year_9);
		
	end loop;
    
    return cells_all;
    
end;

$$ LANGUAGE plpgsql;