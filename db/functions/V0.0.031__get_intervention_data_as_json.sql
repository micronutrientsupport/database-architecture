CREATE or replace function get_intervention_data_as_json(int_id integer) returns jsonb

AS $$

declare 

cell_0  text;
cell_1  text;
cell_2  text;
cell_3  text;
cell_4  text;
cell_5  text;
cell_6  text;
cell_7  text;
cell_8  text;
cell_9  text;
cells_all jsonb;

calc_val numeric;

data_cur cursor for
select * from intervention_data
where intervention_id = int_id;

begin
	
	cells_all := '{"foo":null}'; -- this is required because if the variable is null, appending it to anything else reults in null

	for data_rec in data_cur loop
			
		-- null in postgres and null in json are slightly differnt so need precise handling. Coelesce didn't work.
		if data_rec.year_0 is null then
			cell_0 := '{"' || data_rec.row_index || '_0":null}';
		else
			cell_0 := '{"' || data_rec.row_index || '_0":' || data_rec.year_0 || '}';
		end if; 
		
		if data_rec.year_1 is null then
			cell_1 := '{"' || data_rec.row_index || '_1":null}';
		else
			cell_1 := '{"' || data_rec.row_index || '_1":' || data_rec.year_1 || '}';
		end if;
		
		if data_rec.year_2 is null then
			cell_2 := '{"' || data_rec.row_index || '_2":null}';
		else
			cell_2 := '{"' || data_rec.row_index || '_2":' || data_rec.year_2 || '}';
		end if;
		
		if data_rec.year_3 is null then
			cell_3 := '{"' || data_rec.row_index || '_3":null}';
		else
			cell_3 := '{"' || data_rec.row_index || '_3":' || data_rec.year_3 || '}';
		end if;
		
		if data_rec.year_4 is null then
			cell_4 := '{"' || data_rec.row_index || '_4":null}';
		else
			cell_4 := '{"' || data_rec.row_index || '_4":' || data_rec.year_4 || '}';
		end if;
		
		if data_rec.year_5 is null then
			cell_5 := '{"' || data_rec.row_index || '_5":null}';
		else
			cell_5 := '{"' || data_rec.row_index || '_5":' || data_rec.year_5 || '}';
		end if;
		
		if data_rec.year_6 is null then
			cell_6 := '{"' || data_rec.row_index || '_6":null}';
		else
			cell_6 := '{"' || data_rec.row_index || '_6":' || data_rec.year_6 || '}';
		end if;
		
		if data_rec.year_7 is null then
			cell_7 := '{"' || data_rec.row_index || '_7":null}';
		else
			cell_7 := '{"' || data_rec.row_index || '_7":' || data_rec.year_7 || '}';
		end if;
		
		if data_rec.year_8 is null then
			cell_8 := '{"' || data_rec.row_index || '_8":null}';
		else
			cell_8 := '{"' || data_rec.row_index || '_8":' || data_rec.year_8 || '}';
		end if;
		
		if data_rec.year_9 is null then
			cell_9 := '{"' || data_rec.row_index || '_9":null}';
		else
			cell_9 := '{"' || data_rec.row_index || '_9":' || data_rec.year_9 || '}';
		end if;
		
		cells_all := cells_all || cell_0::jsonb || cell_1::jsonb || cell_2::jsonb || cell_3::jsonb || cell_4::jsonb
		|| cell_5::jsonb || cell_6::jsonb || cell_7::jsonb || cell_8::jsonb || cell_9::jsonb;
		
	end loop;
    
    return cells_all;
    
end;

$$ LANGUAGE plpgsql;