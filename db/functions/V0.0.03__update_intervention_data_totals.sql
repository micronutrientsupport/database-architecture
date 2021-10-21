
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

	  -- raise notice '%' , cells_all;
	  /** test fetching specific cell values
	  raise notice '%' , cells_all -> '4_0';
	  raise notice '%' , cells_all -> '256_9';
	  raise notice '%' , cells_all -> '265_0';
	  */
	
-- formulae for intervention_id = 1
	
-- 	C31	=ROUNDUP(C27*C30, 0)

 --calc_val := (cells_all->>'27_0')::numeric * 3 + 1000000;
 --raise notice '%', calc_val;

	UPDATE intervention_data 
	SET 
	year_0 = round((cells_all->>'27_0')::numeric * (cells_all->>'30_0')::numeric)
	,year_1 = round((cells_all->>'27_1')::numeric * (cells_all->>'30_1')::numeric)
	,year_2 = round((cells_all->>'27_2')::numeric * (cells_all->>'30_2')::numeric)
	,year_3 = round((cells_all->>'27_3')::numeric * (cells_all->>'30_3')::numeric)
	,year_4 = round((cells_all->>'27_4')::numeric * (cells_all->>'30_4')::numeric)
	,year_5 = round((cells_all->>'27_5')::numeric * (cells_all->>'30_5')::numeric)
	,year_6 = round((cells_all->>'27_6')::numeric * (cells_all->>'30_6')::numeric)
	,year_7 = round((cells_all->>'27_7')::numeric * (cells_all->>'30_7')::numeric)
	,year_8 = round((cells_all->>'27_8')::numeric * (cells_all->>'30_8')::numeric)
	,year_9 = round((cells_all->>'27_9')::numeric * (cells_all->>'30_9')::numeric)
	WHERE row_index = 31
	and intervention_id = int_id;

-- 	C33	=IF(OR(C13>0,C14>0),3,0)
-- 	C34	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)
-- 	C37	=1-C36
-- 	C40	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))
-- 	C41	=IF(OR(C13>0, C14>0),3,0)
-- 	C42	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)
-- 	C44	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),6,IF(AND(C$27>=0.25,C$27<0.5),12,IF(AND(C$27>=0.5,C$27<0.75),18,24))))
-- 	C45	=IF(OR(C13>0,C14>0),2,0)
-- 	C46	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),2,0)
-- 	C48	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))
-- 	C49	=IF(OR(C13>0,C14>0),5,0)
-- 	C50	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),5,0)
-- 	C91	=IF(C4="SU",200000*'GDP Deflators'!$G$38,0)
-- 	C92	=IF(C4="SU",15000,0)
-- 	C93	=IF(C4="SU",20000,0)
-- 	C94	=IF(C4="SU", 10000,IF(C4="SC",5000,0))
-- 	C95	=SUM(C91:C94)
-- 	C108	=IF(C4="BAU",0,IF(C4="SU",50000,25000))
-- 	C109	=C108
-- 	C114	=C95+C106+C109+C113
-- 	C118	='Premix - wheat flour'!I35
-- 	C120	='National Data'!B17
-- 	C121	='National Data'!B12
-- 	C123	=C118*(1+C119+C120+C121)+C122
-- 	C125	=C26
-- 	C126	=Demographics!D3
-- 	C127	=((C124*C125*C126)*365)/1000000
-- 	C128	=C36
-- 	C129	=IF(C128=0,0,C27)
-- 	C130	=C127*C129*C128
-- 	C131	=C123*C130
-- 	C132	=C37
-- 	C133	=IF(C132=0,0,C27)
-- 	C134	=C127*C132*C133
-- 	C135	=C123*C134
-- 	C136	=C131+C135
-- 	C137	=C136
-- 	C142	='National Data'!B6*2
-- 	C143	=C31*C142*C141
-- 	C145	=C31*C144*($D$54)
-- 	C146	=C143+C145
-- 	C148	=816.62/100
-- 	C150	='National Data'!B16
-- 	C151	='National Data'!B11
-- 	C152	=C148*(1+C149+C150+C151)
-- 	C153	=C33
-- 	C154	=673.19/100
-- 	C156	='National Data'!B16
-- 	C157	='National Data'!B11
-- 	C158	=C154*(1+C155+C156+C157)
-- 	C159	=C34
-- 	C160	=(C152*C153+C158*C159)*C31*C32
-- 	C162	='National Data'!B6*2.5
-- 	C163	=C161*C162*C31
-- 	C164	=C160+C163
-- 	C166	=50*'GDP Deflators'!$G$38
-- 	C168	=C166*C167*C31
-- 	C170	=200*'GDP Deflators'!F38
-- 	C172	=C170*C171*C31
-- 	C175	=C174*(C146+C164+C168+C172)
-- 	C176	=C146+C164+C168+C172+C175
-- 	C180	=130*'GDP Deflators'!$G$38
-- 	C181	=C30*C40
-- 	C182	=C180*C181
-- 	C183	=816.62/100
-- 	C185	=C183*(1+C184)
-- 	C186	=C41
-- 	C187	=673.19/100
-- 	C189	=C187*(1+C188)
-- 	C190	=C42
-- 	C191	=(C185*C186+C189*C190)*C30*C40
-- 	C192	=C182+C191
-- 	C195	='National Data'!B6*2.5
-- 	C196	=C194*C43*C195
-- 	C197	=816.62/100
-- 	C199	=C197*(1+C198)
-- 	C200	=C45
-- 	C201	=673.19/100
-- 	C203	=C201*(1+C202)
-- 	C204	=C46
-- 	C205	=(C199*C200+C203*C204)*C43*C44
-- 	C206	=C196+C205
-- 	C209	='National Data'!B6*2.5
-- 	C210	=C208*C209
-- 	C211	=816.62/100
-- 	C213	=C211*(1+C212)
-- 	C214	=C49
-- 	C215	=673.19/100
-- 	C217	=C215*(1+C216)
-- 	C218	=C50
-- 	C219	=(C213*C214+C217*C218)*(C47*C48)
-- 	C220	=C210+C219
-- 	C227	=IF(C4="BAU",C226,0)
-- 	C231	=IF(C4="BAU",C229*C230,0)
-- 	C234	=C233*(C192+C206+C220+C224)
-- 	C235	=C192+C206+C220+C224+C227+C231+C234
-- 	C242	=C241
-- 	C246	=C87
-- 	C247	=C114
-- 	C248	=C246+C247
-- 	C250	=C137
-- 	C251	=C176
-- 	C252	=C235
-- 	C253	=C242
-- 	C254	=SUM(C250:C253)
-- 	C256	=C248+C254
-- 	C259	=SUM(C256:L256)
-- 	C260	='National Data'!B9
-- 	C263	=PV($C$260,C$262,0,C256)*-1
-- 	C265	=SUM(C263:L263)
	

end;

$$ LANGUAGE plpgsql;

-- select update_intervention_data_totals(1);

