
CREATE or replace function update_intervention_data_totals(int_id integer) returns void

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

	  -- raise notice '%' , cells_all;
	  raise notice '%' , cells_all -> '4_0';
	  raise notice '%' , cells_all -> '256_9';
	  raise notice '%' , cells_all -> '265_0';
	

	-- update row 136 total premix cost
	/*
		C118 ='Premix - wheat flour'!I35
		C119 0.1
		C120 ='National Data'!B17
		C121 ='National Data'!B12
		C122 0.2
		C123 =C118*(1+C119+C120+C121)+C122
		C124 26.49
		C125 =C26
		C126 =Demographics!D3
		C127 =((C124*C125*C126)*365)/1000000
		C128 =C36
		C129 =IF(C128=0,0,C27)
		C130 =C127*C129*C128
		C131 =C123*C130
		C132 =C37
		C133 =IF(C132=0,0,C27)
		C134 =C127*C132*C133
		C135 =C123*C134
		C136 =C131+C135
		C137 =C136
	*/
	

	
/**		
	UPDATE intervention_data 
	SET 
	year_0 =  cells_all -> 
	year_1 =  R131[1] + R135[1],
	year_2 =  R131[2] + R135[2],
	year_3 =  R131[3] + R135[3],
	year_4 =  R131[4] + R135[4],
	year_5 =  R131[5] + R135[5],
	year_6 =  R131[6] + R135[6],
	year_7 =  R131[7] + R135[7],
	year_8 =  R131[8] + R135[8],
	year_9 =  R131[9] + R135[9]
	WHERE row_index = 137
	and intervention_id = int_id;

*/
end;

$$ LANGUAGE plpgsql;

-- select update_intervention_data_totals(1);

