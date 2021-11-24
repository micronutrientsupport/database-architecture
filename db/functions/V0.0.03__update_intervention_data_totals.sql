
-- drop function update_intervention_data_totals;

CREATE or replace function update_intervention_data_totals(int_id integer) returns void

AS $$

declare 

cells_all jsonb;

begin
	
cells_all := get_intervention_data_as_json(int_id);

-- Raise Notice'1.cells_all: %',cells_all->>'4_0';

-- formulae for intervention_id = 1
	
-- 	C31	=ROUNDUP(C27*C30, 0)

    cells_all := cells_all || to_json_null('31_0'::text,round((cells_all->>'27_0')::numeric * (cells_all->>'30_0')::numeric));
    cells_all := cells_all || to_json_null('31_1'::text,round((cells_all->>'27_1')::numeric * (cells_all->>'30_1')::numeric));
	cells_all := cells_all || to_json_null('31_2'::text,round((cells_all->>'27_2')::numeric * (cells_all->>'30_2')::numeric));
	cells_all := cells_all || to_json_null('31_3'::text,round((cells_all->>'27_3')::numeric * (cells_all->>'30_3')::numeric));
	cells_all := cells_all || to_json_null('31_4'::text,round((cells_all->>'27_4')::numeric * (cells_all->>'30_4')::numeric));
	cells_all := cells_all || to_json_null('31_5'::text,round((cells_all->>'27_5')::numeric * (cells_all->>'30_5')::numeric));
	cells_all := cells_all || to_json_null('31_6'::text,round((cells_all->>'27_6')::numeric * (cells_all->>'30_6')::numeric));
	cells_all := cells_all || to_json_null('31_7'::text,round((cells_all->>'27_7')::numeric * (cells_all->>'30_7')::numeric));
	cells_all := cells_all || to_json_null('31_8'::text,round((cells_all->>'27_8')::numeric * (cells_all->>'30_8')::numeric));
	cells_all := cells_all || to_json_null('31_9'::text,round((cells_all->>'27_9')::numeric * (cells_all->>'30_9')::numeric));

-- 	C33	=IF(OR(C13>0,C14>0),3,0)
    
     cells_all := cells_all || ('{"33_0":' || case when (cells_all->>'13_0')::numeric > 0 or (cells_all->>'14_0')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_1":' || case when (cells_all->>'13_1')::numeric > 0 or (cells_all->>'14_1')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_2":' || case when (cells_all->>'13_2')::numeric > 0 or (cells_all->>'14_2')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_3":' || case when (cells_all->>'13_3')::numeric > 0 or (cells_all->>'14_3')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_4":' || case when (cells_all->>'13_4')::numeric > 0 or (cells_all->>'14_4')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_5":' || case when (cells_all->>'13_5')::numeric > 0 or (cells_all->>'14_5')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_6":' || case when (cells_all->>'13_6')::numeric > 0 or (cells_all->>'14_6')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_7":' || case when (cells_all->>'13_7')::numeric > 0 or (cells_all->>'14_7')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_8":' || case when (cells_all->>'13_8')::numeric > 0 or (cells_all->>'14_8')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	 cells_all := cells_all || ('{"33_9":' || case when (cells_all->>'13_9')::numeric > 0 or (cells_all->>'14_9')::numeric > 0 then 3 else 0 end || '}')::jsonb;
    

-- 	C34	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)
 
	cells_all := cells_all || ('{"34_0":' || case when (cells_all->>'6_0')::numeric > 0 or (cells_all->>'7_0')::numeric > 0 or (cells_all->>'8_0')::numeric > 0 or (cells_all->>'9_0')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_1":' || case when (cells_all->>'6_1')::numeric > 0 or (cells_all->>'7_1')::numeric > 0 or (cells_all->>'8_1')::numeric > 0 or (cells_all->>'9_1')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_2":' || case when (cells_all->>'6_2')::numeric > 0 or (cells_all->>'7_2')::numeric > 0 or (cells_all->>'8_2')::numeric > 0 or (cells_all->>'9_2')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_3":' || case when (cells_all->>'6_3')::numeric > 0 or (cells_all->>'7_3')::numeric > 0 or (cells_all->>'8_3')::numeric > 0 or (cells_all->>'9_3')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_4":' || case when (cells_all->>'6_4')::numeric > 0 or (cells_all->>'7_4')::numeric > 0 or (cells_all->>'8_4')::numeric > 0 or (cells_all->>'9_4')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_5":' || case when (cells_all->>'6_5')::numeric > 0 or (cells_all->>'7_5')::numeric > 0 or (cells_all->>'8_5')::numeric > 0 or (cells_all->>'9_5')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_6":' || case when (cells_all->>'6_6')::numeric > 0 or (cells_all->>'7_6')::numeric > 0 or (cells_all->>'8_6')::numeric > 0 or (cells_all->>'9_6')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_7":' || case when (cells_all->>'6_7')::numeric > 0 or (cells_all->>'7_7')::numeric > 0 or (cells_all->>'8_7')::numeric > 0 or (cells_all->>'9_7')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_8":' || case when (cells_all->>'6_8')::numeric > 0 or (cells_all->>'7_8')::numeric > 0 or (cells_all->>'8_8')::numeric > 0 or (cells_all->>'9_8')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"34_9":' || case when (cells_all->>'6_9')::numeric > 0 or (cells_all->>'7_9')::numeric > 0 or (cells_all->>'8_9')::numeric > 0 or (cells_all->>'9_9')::numeric > 0 then 3 else 0 end || '}')::jsonb;

-- 	C37	=1-C36

 
	cells_all := cells_all || ('{"37_0":' ||  1 - (cells_all->>'36_0')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_1":' ||  1 - (cells_all->>'36_1')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_2":' ||  1 - (cells_all->>'36_2')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_3":' ||  1 - (cells_all->>'36_3')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_4":' ||  1 - (cells_all->>'36_4')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_5":' ||  1 - (cells_all->>'36_5')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_6":' ||  1 - (cells_all->>'36_6')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_7":' ||  1 - (cells_all->>'36_7')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_8":' ||  1 - (cells_all->>'36_8')::numeric || '}')::jsonb;
	cells_all := cells_all || ('{"37_9":' ||  1 - (cells_all->>'36_9')::numeric || '}')::jsonb;


-- 	C40	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))


	cells_all := cells_all || ('{"40_0":' || case when (cells_all->>'27_0')::numeric = 0 then 1
					when (cells_all->>'27_0')::numeric > 0 and (cells_all->>'27_0')::numeric < 0.25 then 1 
					when (cells_all->>'27_0')::numeric >= 0.25 and (cells_all->>'27_0')::numeric < 0.5 then 2
					when (cells_all->>'27_0')::numeric >= 0.5 and (cells_all->>'27_0')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_1":' || case when (cells_all->>'27_1')::numeric = 0 then 1
					when (cells_all->>'27_1')::numeric > 0 and (cells_all->>'27_1')::numeric < 0.25 then 1 
					when (cells_all->>'27_1')::numeric >= 0.25 and (cells_all->>'27_1')::numeric < 0.5 then 2
					when (cells_all->>'27_1')::numeric >= 0.5 and (cells_all->>'27_1')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_2":' || case when (cells_all->>'27_2')::numeric = 0 then 1
					when (cells_all->>'27_2')::numeric > 0 and (cells_all->>'27_2')::numeric < 0.25 then 1 
					when (cells_all->>'27_2')::numeric >= 0.25 and (cells_all->>'27_2')::numeric < 0.5 then 2
					when (cells_all->>'27_2')::numeric >= 0.5 and (cells_all->>'27_2')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_3":' || case when (cells_all->>'27_3')::numeric = 0 then 1
					when (cells_all->>'27_3')::numeric > 0 and (cells_all->>'27_3')::numeric < 0.25 then 1 
					when (cells_all->>'27_3')::numeric >= 0.25 and (cells_all->>'27_3')::numeric < 0.5 then 2
					when (cells_all->>'27_3')::numeric >= 0.5 and (cells_all->>'27_3')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_4":' || case when (cells_all->>'27_4')::numeric = 0 then 1
					when (cells_all->>'27_4')::numeric > 0 and (cells_all->>'27_4')::numeric < 0.25 then 1 
					when (cells_all->>'27_4')::numeric >= 0.25 and (cells_all->>'27_4')::numeric < 0.5 then 2
					when (cells_all->>'27_4')::numeric >= 0.5 and (cells_all->>'27_4')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_5":' || case when (cells_all->>'27_5')::numeric = 0 then 1
					when (cells_all->>'27_5')::numeric > 0 and (cells_all->>'27_5')::numeric < 0.25 then 1 
					when (cells_all->>'27_5')::numeric >= 0.25 and (cells_all->>'27_5')::numeric < 0.5 then 2
					when (cells_all->>'27_5')::numeric >= 0.5 and (cells_all->>'27_5')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_6":' || case when (cells_all->>'27_6')::numeric = 0 then 1
					when (cells_all->>'27_6')::numeric > 0 and (cells_all->>'27_6')::numeric < 0.25 then 1 
					when (cells_all->>'27_6')::numeric >= 0.25 and (cells_all->>'27_6')::numeric < 0.5 then 2
					when (cells_all->>'27_6')::numeric >= 0.5 and (cells_all->>'27_6')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_7":' || case when (cells_all->>'27_7')::numeric = 0 then 1
					when (cells_all->>'27_7')::numeric > 0 and (cells_all->>'27_7')::numeric < 0.25 then 1 
					when (cells_all->>'27_7')::numeric >= 0.25 and (cells_all->>'27_7')::numeric < 0.5 then 2
					when (cells_all->>'27_7')::numeric >= 0.5 and (cells_all->>'27_7')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_8":' || case when (cells_all->>'27_8')::numeric = 0 then 1
					when (cells_all->>'27_8')::numeric > 0 and (cells_all->>'27_8')::numeric < 0.25 then 1 
					when (cells_all->>'27_8')::numeric >= 0.25 and (cells_all->>'27_8')::numeric < 0.5 then 2
					when (cells_all->>'27_8')::numeric >= 0.5 and (cells_all->>'27_8')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"40_9":' || case when (cells_all->>'27_9')::numeric = 0 then 1
					when (cells_all->>'27_9')::numeric > 0 and (cells_all->>'27_9')::numeric < 0.25 then 1 
					when (cells_all->>'27_9')::numeric >= 0.25 and (cells_all->>'27_9')::numeric < 0.5 then 2
					when (cells_all->>'27_9')::numeric >= 0.5 and (cells_all->>'27_9')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;

-- 	C41	=IF(OR(C13>0, C14>0),3,0)
	 
	cells_all := cells_all || ('{"41_0":' || case when (cells_all->>'13_0')::numeric > 0 or (cells_all->>'14_0')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_1":' || case when (cells_all->>'13_1')::numeric > 0 or (cells_all->>'14_1')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_2":' || case when (cells_all->>'13_2')::numeric > 0 or (cells_all->>'14_2')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_3":' || case when (cells_all->>'13_3')::numeric > 0 or (cells_all->>'14_3')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_4":' || case when (cells_all->>'13_4')::numeric > 0 or (cells_all->>'14_4')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_5":' || case when (cells_all->>'13_5')::numeric > 0 or (cells_all->>'14_5')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_6":' || case when (cells_all->>'13_6')::numeric > 0 or (cells_all->>'14_6')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_7":' || case when (cells_all->>'13_7')::numeric > 0 or (cells_all->>'14_7')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_8":' || case when (cells_all->>'13_8')::numeric > 0 or (cells_all->>'14_8')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"41_9":' || case when (cells_all->>'13_9')::numeric > 0 or (cells_all->>'14_9')::numeric > 0 then 3 else 0 end || '}')::jsonb;


-- 	C42	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)

	cells_all := cells_all || ('{"42_0":' || case when (cells_all->>'6_0')::numeric > 0 or (cells_all->>'7_0')::numeric > 0 or (cells_all->>'8_0')::numeric > 0 or (cells_all->>'9_0')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_1":' || case when (cells_all->>'6_1')::numeric > 0 or (cells_all->>'7_1')::numeric > 0 or (cells_all->>'8_1')::numeric > 0 or (cells_all->>'9_1')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_2":' || case when (cells_all->>'6_2')::numeric > 0 or (cells_all->>'7_2')::numeric > 0 or (cells_all->>'8_2')::numeric > 0 or (cells_all->>'9_2')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_3":' || case when (cells_all->>'6_3')::numeric > 0 or (cells_all->>'7_3')::numeric > 0 or (cells_all->>'8_3')::numeric > 0 or (cells_all->>'9_3')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_4":' || case when (cells_all->>'6_4')::numeric > 0 or (cells_all->>'7_4')::numeric > 0 or (cells_all->>'8_4')::numeric > 0 or (cells_all->>'9_4')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_5":' || case when (cells_all->>'6_5')::numeric > 0 or (cells_all->>'7_5')::numeric > 0 or (cells_all->>'8_5')::numeric > 0 or (cells_all->>'9_5')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_6":' || case when (cells_all->>'6_6')::numeric > 0 or (cells_all->>'7_6')::numeric > 0 or (cells_all->>'8_6')::numeric > 0 or (cells_all->>'9_6')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_7":' || case when (cells_all->>'6_7')::numeric > 0 or (cells_all->>'7_7')::numeric > 0 or (cells_all->>'8_7')::numeric > 0 or (cells_all->>'9_7')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_8":' || case when (cells_all->>'6_8')::numeric > 0 or (cells_all->>'7_8')::numeric > 0 or (cells_all->>'8_8')::numeric > 0 or (cells_all->>'9_8')::numeric > 0 then 3 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"42_9":' || case when (cells_all->>'6_9')::numeric > 0 or (cells_all->>'7_9')::numeric > 0 or (cells_all->>'8_9')::numeric > 0 or (cells_all->>'9_9')::numeric > 0 then 3 else 0 end || '}')::jsonb;

-- 	C44	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),6,IF(AND(C$27>=0.25,C$27<0.5),12,IF(AND(C$27>=0.5,C$27<0.75),18,24))))

	cells_all := cells_all || ('{"44_0":' || case when (cells_all->>'27_0')::numeric = 0 then 0
					when (cells_all->>'27_0')::numeric > 0 and (cells_all->>'27_0')::numeric < 0.25 then 6 
					when (cells_all->>'27_0')::numeric >= 0.25 and (cells_all->>'27_0')::numeric < 0.5 then 12
					when (cells_all->>'27_0')::numeric >= 0.5 and (cells_all->>'27_0')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_1":' || case when (cells_all->>'27_1')::numeric = 0 then 0
					when (cells_all->>'27_1')::numeric > 0 and (cells_all->>'27_1')::numeric < 0.25 then 6 
					when (cells_all->>'27_1')::numeric >= 0.25 and (cells_all->>'27_1')::numeric < 0.5 then 12
					when (cells_all->>'27_1')::numeric >= 0.5 and (cells_all->>'27_1')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_2":' || case when (cells_all->>'27_2')::numeric = 0 then 0
					when (cells_all->>'27_2')::numeric > 0 and (cells_all->>'27_2')::numeric < 0.25 then 6 
					when (cells_all->>'27_2')::numeric >= 0.25 and (cells_all->>'27_2')::numeric < 0.5 then 12
					when (cells_all->>'27_2')::numeric >= 0.5 and (cells_all->>'27_2')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_3":' || case when (cells_all->>'27_3')::numeric = 0 then 0
					when (cells_all->>'27_3')::numeric > 0 and (cells_all->>'27_3')::numeric < 0.25 then 6 
					when (cells_all->>'27_3')::numeric >= 0.25 and (cells_all->>'27_3')::numeric < 0.5 then 12
					when (cells_all->>'27_3')::numeric >= 0.5 and (cells_all->>'27_3')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_4":' || case when (cells_all->>'27_4')::numeric = 0 then 0
					when (cells_all->>'27_4')::numeric > 0 and (cells_all->>'27_4')::numeric < 0.25 then 6 
					when (cells_all->>'27_4')::numeric >= 0.25 and (cells_all->>'27_4')::numeric < 0.5 then 12
					when (cells_all->>'27_4')::numeric >= 0.5 and (cells_all->>'27_4')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_5":' || case when (cells_all->>'27_5')::numeric = 0 then 0
					when (cells_all->>'27_5')::numeric > 0 and (cells_all->>'27_5')::numeric < 0.25 then 6 
					when (cells_all->>'27_5')::numeric >= 0.25 and (cells_all->>'27_5')::numeric < 0.5 then 12
					when (cells_all->>'27_5')::numeric >= 0.5 and (cells_all->>'27_5')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_6":' || case when (cells_all->>'27_6')::numeric = 0 then 0
					when (cells_all->>'27_6')::numeric > 0 and (cells_all->>'27_6')::numeric < 0.25 then 6 
					when (cells_all->>'27_6')::numeric >= 0.25 and (cells_all->>'27_6')::numeric < 0.5 then 12
					when (cells_all->>'27_6')::numeric >= 0.5 and (cells_all->>'27_6')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_7":' || case when (cells_all->>'27_7')::numeric = 0 then 0
					when (cells_all->>'27_7')::numeric > 0 and (cells_all->>'27_7')::numeric < 0.25 then 6 
					when (cells_all->>'27_7')::numeric >= 0.25 and (cells_all->>'27_7')::numeric < 0.5 then 12
					when (cells_all->>'27_7')::numeric >= 0.5 and (cells_all->>'27_7')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_8":' || case when (cells_all->>'27_8')::numeric = 0 then 0
					when (cells_all->>'27_8')::numeric > 0 and (cells_all->>'27_8')::numeric < 0.25 then 6 
					when (cells_all->>'27_8')::numeric >= 0.25 and (cells_all->>'27_8')::numeric < 0.5 then 12
					when (cells_all->>'27_8')::numeric >= 0.5 and (cells_all->>'27_8')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;
	cells_all := cells_all || ('{"44_9":' || case when (cells_all->>'27_9')::numeric = 0 then 0
					when (cells_all->>'27_9')::numeric > 0 and (cells_all->>'27_9')::numeric < 0.25 then 6 
					when (cells_all->>'27_9')::numeric >= 0.25 and (cells_all->>'27_9')::numeric < 0.5 then 12
					when (cells_all->>'27_9')::numeric >= 0.5 and (cells_all->>'27_9')::numeric < 0.75 then 18
					else 24 end || '}')::jsonb;

-- 	C45	=IF(OR(C13>0,C14>0),2,0)

	cells_all := cells_all || ('{"45_0":' || case when (cells_all->>'13_0')::numeric > 0 or (cells_all->>'14_0')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_1":' || case when (cells_all->>'13_1')::numeric > 0 or (cells_all->>'14_1')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_2":' || case when (cells_all->>'13_2')::numeric > 0 or (cells_all->>'14_2')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_3":' || case when (cells_all->>'13_3')::numeric > 0 or (cells_all->>'14_3')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_4":' || case when (cells_all->>'13_4')::numeric > 0 or (cells_all->>'14_4')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_5":' || case when (cells_all->>'13_5')::numeric > 0 or (cells_all->>'14_5')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_6":' || case when (cells_all->>'13_6')::numeric > 0 or (cells_all->>'14_6')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_7":' || case when (cells_all->>'13_7')::numeric > 0 or (cells_all->>'14_7')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_8":' || case when (cells_all->>'13_8')::numeric > 0 or (cells_all->>'14_8')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"45_9":' || case when (cells_all->>'13_9')::numeric > 0 or (cells_all->>'14_9')::numeric > 0 then 2 else 0 end || '}')::jsonb;

-- 	C46	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),2,0)

	cells_all := cells_all || ('{"46_0":' || case when (cells_all->>'6_0')::numeric > 0 or (cells_all->>'7_0')::numeric > 0 or (cells_all->>'8_0')::numeric > 0 or (cells_all->>'9_0')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_1":' || case when (cells_all->>'6_1')::numeric > 0 or (cells_all->>'7_1')::numeric > 0 or (cells_all->>'8_1')::numeric > 0 or (cells_all->>'9_1')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_2":' || case when (cells_all->>'6_2')::numeric > 0 or (cells_all->>'7_2')::numeric > 0 or (cells_all->>'8_2')::numeric > 0 or (cells_all->>'9_2')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_3":' || case when (cells_all->>'6_3')::numeric > 0 or (cells_all->>'7_3')::numeric > 0 or (cells_all->>'8_3')::numeric > 0 or (cells_all->>'9_3')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_4":' || case when (cells_all->>'6_4')::numeric > 0 or (cells_all->>'7_4')::numeric > 0 or (cells_all->>'8_4')::numeric > 0 or (cells_all->>'9_4')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_5":' || case when (cells_all->>'6_5')::numeric > 0 or (cells_all->>'7_5')::numeric > 0 or (cells_all->>'8_5')::numeric > 0 or (cells_all->>'9_5')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_6":' || case when (cells_all->>'6_6')::numeric > 0 or (cells_all->>'7_6')::numeric > 0 or (cells_all->>'8_6')::numeric > 0 or (cells_all->>'9_6')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_7":' || case when (cells_all->>'6_7')::numeric > 0 or (cells_all->>'7_7')::numeric > 0 or (cells_all->>'8_7')::numeric > 0 or (cells_all->>'9_7')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_8":' || case when (cells_all->>'6_8')::numeric > 0 or (cells_all->>'7_8')::numeric > 0 or (cells_all->>'8_8')::numeric > 0 or (cells_all->>'9_8')::numeric > 0 then 2 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"46_9":' || case when (cells_all->>'6_9')::numeric > 0 or (cells_all->>'7_9')::numeric > 0 or (cells_all->>'8_9')::numeric > 0 or (cells_all->>'9_9')::numeric > 0 then 2 else 0 end || '}')::jsonb;

-- 	C48	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))

	 cells_all := cells_all || ('{"48_0":' || case when (cells_all->>'27_0')::numeric = 0 then 1 					
                    when (cells_all->>'27_0')::numeric > 0 and (cells_all->>'27_0')::numeric < 0.25 then 1 					
                    when (cells_all->>'27_0')::numeric >= 0.25 and (cells_all->>'27_0')::numeric < 0.5 then 2 					
                    when (cells_all->>'27_0')::numeric >= 0.5 and (cells_all->>'27_0')::numeric < 0.75 then 3 					
                    else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_1":' || case when (cells_all->>'27_1')::numeric = 0 then 1
					when (cells_all->>'27_1')::numeric > 0 and (cells_all->>'27_1')::numeric < 0.25 then 1 
					when (cells_all->>'27_1')::numeric >= 0.25 and (cells_all->>'27_1')::numeric < 0.5 then 2
					when (cells_all->>'27_1')::numeric >= 0.5 and (cells_all->>'27_1')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_2":' || case when (cells_all->>'27_2')::numeric = 0 then 1
					when (cells_all->>'27_2')::numeric > 0 and (cells_all->>'27_2')::numeric < 0.25 then 1 
					when (cells_all->>'27_2')::numeric >= 0.25 and (cells_all->>'27_2')::numeric < 0.5 then 2
					when (cells_all->>'27_2')::numeric >= 0.5 and (cells_all->>'27_2')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_3":' || case when (cells_all->>'27_3')::numeric = 0 then 1
					when (cells_all->>'27_3')::numeric > 0 and (cells_all->>'27_3')::numeric < 0.25 then 1 
					when (cells_all->>'27_3')::numeric >= 0.25 and (cells_all->>'27_3')::numeric < 0.5 then 2
					when (cells_all->>'27_3')::numeric >= 0.5 and (cells_all->>'27_3')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_4":' || case when (cells_all->>'27_4')::numeric = 0 then 1
					when (cells_all->>'27_4')::numeric > 0 and (cells_all->>'27_4')::numeric < 0.25 then 1 
					when (cells_all->>'27_4')::numeric >= 0.25 and (cells_all->>'27_4')::numeric < 0.5 then 2
					when (cells_all->>'27_4')::numeric >= 0.5 and (cells_all->>'27_4')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_5":' || case when (cells_all->>'27_5')::numeric = 0 then 1
					when (cells_all->>'27_5')::numeric > 0 and (cells_all->>'27_5')::numeric < 0.25 then 1 
					when (cells_all->>'27_5')::numeric >= 0.25 and (cells_all->>'27_5')::numeric < 0.5 then 2
					when (cells_all->>'27_5')::numeric >= 0.5 and (cells_all->>'27_5')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_6":' || case when (cells_all->>'27_6')::numeric = 0 then 1
					when (cells_all->>'27_6')::numeric > 0 and (cells_all->>'27_6')::numeric < 0.25 then 1 
					when (cells_all->>'27_6')::numeric >= 0.25 and (cells_all->>'27_6')::numeric < 0.5 then 2
					when (cells_all->>'27_6')::numeric >= 0.5 and (cells_all->>'27_6')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_7":' || case when (cells_all->>'27_7')::numeric = 0 then 1
					when (cells_all->>'27_7')::numeric > 0 and (cells_all->>'27_7')::numeric < 0.25 then 1 
					when (cells_all->>'27_7')::numeric >= 0.25 and (cells_all->>'27_7')::numeric < 0.5 then 2
					when (cells_all->>'27_7')::numeric >= 0.5 and (cells_all->>'27_7')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_8":' || case when (cells_all->>'27_8')::numeric = 0 then 1
					when (cells_all->>'27_8')::numeric > 0 and (cells_all->>'27_8')::numeric < 0.25 then 1 
					when (cells_all->>'27_8')::numeric >= 0.25 and (cells_all->>'27_8')::numeric < 0.5 then 2
					when (cells_all->>'27_8')::numeric >= 0.5 and (cells_all->>'27_8')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;
	cells_all := cells_all || ('{"48_9":' || case when (cells_all->>'27_9')::numeric = 0 then 1
					when (cells_all->>'27_9')::numeric > 0 and (cells_all->>'27_9')::numeric < 0.25 then 1 
					when (cells_all->>'27_9')::numeric >= 0.25 and (cells_all->>'27_9')::numeric < 0.5 then 2
					when (cells_all->>'27_9')::numeric >= 0.5 and (cells_all->>'27_9')::numeric < 0.75 then 3
					else 4 end || '}')::jsonb;

-- 	C49	=IF(OR(C13>0,C14>0),5,0)

	cells_all := cells_all || ('{"49_0":' || case when (cells_all->>'13_0')::numeric > 0 or (cells_all->>'14_0')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_1":' || case when (cells_all->>'13_1')::numeric > 0 or (cells_all->>'14_1')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_2":' || case when (cells_all->>'13_2')::numeric > 0 or (cells_all->>'14_2')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_3":' || case when (cells_all->>'13_3')::numeric > 0 or (cells_all->>'14_3')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_4":' || case when (cells_all->>'13_4')::numeric > 0 or (cells_all->>'14_4')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_5":' || case when (cells_all->>'13_5')::numeric > 0 or (cells_all->>'14_5')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_6":' || case when (cells_all->>'13_6')::numeric > 0 or (cells_all->>'14_6')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_7":' || case when (cells_all->>'13_7')::numeric > 0 or (cells_all->>'14_7')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_8":' || case when (cells_all->>'13_8')::numeric > 0 or (cells_all->>'14_8')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"49_9":' || case when (cells_all->>'13_9')::numeric > 0 or (cells_all->>'14_9')::numeric > 0 then 5 else 0 end || '}')::jsonb;

-- 	C50	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),5,0)

	cells_all := cells_all || ('{"50_0":' || case when (cells_all->>'6_0')::numeric > 0 or (cells_all->>'7_0')::numeric > 0 or (cells_all->>'8_0')::numeric > 0 or (cells_all->>'9_0')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_1":' || case when (cells_all->>'6_1')::numeric > 0 or (cells_all->>'7_1')::numeric > 0 or (cells_all->>'8_1')::numeric > 0 or (cells_all->>'9_1')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_2":' || case when (cells_all->>'6_2')::numeric > 0 or (cells_all->>'7_2')::numeric > 0 or (cells_all->>'8_2')::numeric > 0 or (cells_all->>'9_2')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_3":' || case when (cells_all->>'6_3')::numeric > 0 or (cells_all->>'7_3')::numeric > 0 or (cells_all->>'8_3')::numeric > 0 or (cells_all->>'9_3')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_4":' || case when (cells_all->>'6_4')::numeric > 0 or (cells_all->>'7_4')::numeric > 0 or (cells_all->>'8_4')::numeric > 0 or (cells_all->>'9_4')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_5":' || case when (cells_all->>'6_5')::numeric > 0 or (cells_all->>'7_5')::numeric > 0 or (cells_all->>'8_5')::numeric > 0 or (cells_all->>'9_5')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_6":' || case when (cells_all->>'6_6')::numeric > 0 or (cells_all->>'7_6')::numeric > 0 or (cells_all->>'8_6')::numeric > 0 or (cells_all->>'9_6')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_7":' || case when (cells_all->>'6_7')::numeric > 0 or (cells_all->>'7_7')::numeric > 0 or (cells_all->>'8_7')::numeric > 0 or (cells_all->>'9_7')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_8":' || case when (cells_all->>'6_8')::numeric > 0 or (cells_all->>'7_8')::numeric > 0 or (cells_all->>'8_8')::numeric > 0 or (cells_all->>'9_8')::numeric > 0 then 5 else 0 end || '}')::jsonb;
	cells_all := cells_all || ('{"50_9":' || case when (cells_all->>'6_9')::numeric > 0 or (cells_all->>'7_9')::numeric > 0 or (cells_all->>'8_9')::numeric > 0 or (cells_all->>'9_9')::numeric > 0 then 5 else 0 end || '}')::jsonb;

-- 	C91	=IF(C4="SU",200000*'GDP Deflators'!$G$38,0)

    -- TODO

-- 	C92	=IF(C4="SU",15000,0)

	cells_all := cells_all || to_json_null('92_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_1'::text,case when (cells_all->>'4_1')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_2'::text,case when (cells_all->>'4_2')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_3'::text,case when (cells_all->>'4_3')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_4'::text,case when (cells_all->>'4_4')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_5'::text,case when (cells_all->>'4_5')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_6'::text,case when (cells_all->>'4_6')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_7'::text,case when (cells_all->>'4_7')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_8'::text,case when (cells_all->>'4_8')::numeric = 1 then 15000 else 0 end);
	cells_all := cells_all || to_json_null('92_9'::text,case when (cells_all->>'4_9')::numeric = 1 then 15000 else 0 end);

-- 	C93	=IF(C4="SU",20000,0)

	cells_all := cells_all || to_json_null('93_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_1'::text,case when (cells_all->>'4_1')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_2'::text,case when (cells_all->>'4_2')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_3'::text,case when (cells_all->>'4_3')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_4'::text,case when (cells_all->>'4_4')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_5'::text,case when (cells_all->>'4_5')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_6'::text,case when (cells_all->>'4_6')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_7'::text,case when (cells_all->>'4_7')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_8'::text,case when (cells_all->>'4_8')::numeric = 1 then 20000 else 0 end);
	cells_all := cells_all || to_json_null('93_9'::text,case when (cells_all->>'4_9')::numeric = 1 then 20000 else 0 end);

-- 	C94	=IF(C4="SU", 10000,IF(C4="SC",5000,0))

	cells_all := cells_all || to_json_null('94_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 10000 when (cells_all->>'4_0')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_1'::text,case when (cells_all->>'4_1')::numeric = 1 then 10000 when (cells_all->>'4_1')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_2'::text,case when (cells_all->>'4_2')::numeric = 1 then 10000 when (cells_all->>'4_2')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_3'::text,case when (cells_all->>'4_3')::numeric = 1 then 10000 when (cells_all->>'4_3')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_4'::text,case when (cells_all->>'4_4')::numeric = 1 then 10000 when (cells_all->>'4_4')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_5'::text,case when (cells_all->>'4_5')::numeric = 1 then 10000 when (cells_all->>'4_5')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_6'::text,case when (cells_all->>'4_6')::numeric = 1 then 10000 when (cells_all->>'4_6')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_7'::text,case when (cells_all->>'4_7')::numeric = 1 then 10000 when (cells_all->>'4_7')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_8'::text,case when (cells_all->>'4_8')::numeric = 1 then 10000 when (cells_all->>'4_8')::numeric = 2 then 5000 else 0 end);
	cells_all := cells_all || to_json_null('94_9'::text,case when (cells_all->>'4_9')::numeric = 1 then 10000 when (cells_all->>'4_9')::numeric = 2 then 5000 else 0 end);

-- 	C95	=SUM(C91:C94)

	cells_all := cells_all || to_json_null('95_0'::text,(cells_all->>'91_0')::numeric + (cells_all->>'92_0')::numeric + (cells_all->>'93_0')::numeric + (cells_all->>'94_0')::numeric);
	cells_all := cells_all || to_json_null('95_1'::text,(cells_all->>'91_1')::numeric + (cells_all->>'92_1')::numeric + (cells_all->>'93_1')::numeric + (cells_all->>'94_1')::numeric);
	cells_all := cells_all || to_json_null('95_2'::text,(cells_all->>'91_2')::numeric + (cells_all->>'92_2')::numeric + (cells_all->>'93_2')::numeric + (cells_all->>'94_2')::numeric);
	cells_all := cells_all || to_json_null('95_3'::text,(cells_all->>'91_3')::numeric + (cells_all->>'92_3')::numeric + (cells_all->>'93_3')::numeric + (cells_all->>'94_3')::numeric);
	cells_all := cells_all || to_json_null('95_4'::text,(cells_all->>'91_4')::numeric + (cells_all->>'92_4')::numeric + (cells_all->>'93_4')::numeric + (cells_all->>'94_4')::numeric);
	cells_all := cells_all || to_json_null('95_5'::text,(cells_all->>'91_5')::numeric + (cells_all->>'92_5')::numeric + (cells_all->>'93_5')::numeric + (cells_all->>'94_5')::numeric);
	cells_all := cells_all || to_json_null('95_6'::text,(cells_all->>'91_6')::numeric + (cells_all->>'92_6')::numeric + (cells_all->>'93_6')::numeric + (cells_all->>'94_6')::numeric);
	cells_all := cells_all || to_json_null('95_7'::text,(cells_all->>'91_7')::numeric + (cells_all->>'92_7')::numeric + (cells_all->>'93_7')::numeric + (cells_all->>'94_7')::numeric);
	cells_all := cells_all || to_json_null('95_8'::text,(cells_all->>'91_8')::numeric + (cells_all->>'92_8')::numeric + (cells_all->>'93_8')::numeric + (cells_all->>'94_8')::numeric);
	cells_all := cells_all || to_json_null('95_9'::text,(cells_all->>'91_9')::numeric + (cells_all->>'92_9')::numeric + (cells_all->>'93_9')::numeric + (cells_all->>'94_9')::numeric);
	
	
    
-- 	C108	=IF(C4="BAU",0,IF(C4="SU",50000,25000))

	cells_all := cells_all || to_json_null('108_0'::text,case when (cells_all->>'4_0')::numeric = 3 then 0 when (cells_all->>'4_0')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_1'::text,case when (cells_all->>'4_1')::numeric = 3 then 0 when (cells_all->>'4_1')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_2'::text,case when (cells_all->>'4_2')::numeric = 3 then 0 when (cells_all->>'4_2')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_3'::text,case when (cells_all->>'4_3')::numeric = 3 then 0 when (cells_all->>'4_3')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_4'::text,case when (cells_all->>'4_4')::numeric = 3 then 0 when (cells_all->>'4_4')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_5'::text,case when (cells_all->>'4_5')::numeric = 3 then 0 when (cells_all->>'4_5')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_6'::text,case when (cells_all->>'4_6')::numeric = 3 then 0 when (cells_all->>'4_6')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_7'::text,case when (cells_all->>'4_7')::numeric = 3 then 0 when (cells_all->>'4_7')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_8'::text,case when (cells_all->>'4_8')::numeric = 3 then 0 when (cells_all->>'4_8')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_9'::text,case when (cells_all->>'4_9')::numeric = 3 then 0 when (cells_all->>'4_9')::numeric = 1 then  50000 else 25000 end);

-- 	C109	=C108

    cells_all := cells_all || to_json_null('109_0'::text,(cells_all->>'108_0')::numeric);
	cells_all := cells_all || to_json_null('109_1'::text,(cells_all->>'108_1')::numeric);
	cells_all := cells_all || to_json_null('109_2'::text,(cells_all->>'108_2')::numeric);
	cells_all := cells_all || to_json_null('109_3'::text,(cells_all->>'108_3')::numeric);
	cells_all := cells_all || to_json_null('109_4'::text,(cells_all->>'108_4')::numeric);
	cells_all := cells_all || to_json_null('109_5'::text,(cells_all->>'108_5')::numeric);
	cells_all := cells_all || to_json_null('109_6'::text,(cells_all->>'108_6')::numeric);
	cells_all := cells_all || to_json_null('109_7'::text,(cells_all->>'108_7')::numeric);
	cells_all := cells_all || to_json_null('109_8'::text,(cells_all->>'108_8')::numeric);
	cells_all := cells_all || to_json_null('109_9'::text,(cells_all->>'108_9')::numeric);

-- 	C114	=C95+C106+C109+C113

	cells_all := cells_all || to_json_null('114_0'::text,(cells_all->>'95_0')::numeric + (cells_all->>'106_0')::numeric + (cells_all->>'109_0')::numeric + (cells_all->>'113_0')::numeric);
	cells_all := cells_all || to_json_null('114_1'::text,(cells_all->>'95_1')::numeric + (cells_all->>'106_1')::numeric + (cells_all->>'109_1')::numeric + (cells_all->>'113_1')::numeric);
	cells_all := cells_all || to_json_null('114_2'::text,(cells_all->>'95_2')::numeric + (cells_all->>'106_2')::numeric + (cells_all->>'109_2')::numeric + (cells_all->>'113_2')::numeric);
	cells_all := cells_all || to_json_null('114_3'::text,(cells_all->>'95_3')::numeric + (cells_all->>'106_3')::numeric + (cells_all->>'109_3')::numeric + (cells_all->>'113_3')::numeric);
	cells_all := cells_all || to_json_null('114_4'::text,(cells_all->>'95_4')::numeric + (cells_all->>'106_4')::numeric + (cells_all->>'109_4')::numeric + (cells_all->>'113_4')::numeric);
	cells_all := cells_all || to_json_null('114_5'::text,(cells_all->>'95_5')::numeric + (cells_all->>'106_5')::numeric + (cells_all->>'109_5')::numeric + (cells_all->>'113_5')::numeric);
	cells_all := cells_all || to_json_null('114_6'::text,(cells_all->>'95_6')::numeric + (cells_all->>'106_6')::numeric + (cells_all->>'109_6')::numeric + (cells_all->>'113_6')::numeric);
	cells_all := cells_all || to_json_null('114_7'::text,(cells_all->>'95_7')::numeric + (cells_all->>'106_7')::numeric + (cells_all->>'109_7')::numeric + (cells_all->>'113_7')::numeric);
	cells_all := cells_all || to_json_null('114_8'::text,(cells_all->>'95_8')::numeric + (cells_all->>'106_8')::numeric + (cells_all->>'109_8')::numeric + (cells_all->>'113_8')::numeric);
	cells_all := cells_all || to_json_null('114_9'::text,(cells_all->>'95_9')::numeric + (cells_all->>'106_9')::numeric + (cells_all->>'109_9')::numeric + (cells_all->>'113_9')::numeric);

-- 	C118	='Premix - wheat flour'!I35
-- 	C120	='National Data'!B17                    TODO
-- 	C121	='National Data'!B12

-- 	C123	=C118*(1+C119+C120+C121)+C122

	cells_all := cells_all || to_json_null('123_0'::text,(cells_all->>'18_0')::numeric * ( 1 + (cells_all->>'119_0')::numeric + (cells_all->>'120_0')::numeric + (cells_all->>'121_0')::numeric) + (cells_all->>'122_0')::numeric);
	cells_all := cells_all || to_json_null('123_1'::text,(cells_all->>'18_1')::numeric * ( 1 + (cells_all->>'119_1')::numeric + (cells_all->>'120_1')::numeric + (cells_all->>'121_1')::numeric) + (cells_all->>'122_1')::numeric);
	cells_all := cells_all || to_json_null('123_2'::text,(cells_all->>'18_2')::numeric * ( 1 + (cells_all->>'119_2')::numeric + (cells_all->>'120_2')::numeric + (cells_all->>'121_2')::numeric) + (cells_all->>'122_2')::numeric);
	cells_all := cells_all || to_json_null('123_3'::text,(cells_all->>'18_3')::numeric * ( 1 + (cells_all->>'119_3')::numeric + (cells_all->>'120_3')::numeric + (cells_all->>'121_3')::numeric) + (cells_all->>'122_3')::numeric);
	cells_all := cells_all || to_json_null('123_4'::text,(cells_all->>'18_4')::numeric * ( 1 + (cells_all->>'119_4')::numeric + (cells_all->>'120_4')::numeric + (cells_all->>'121_4')::numeric) + (cells_all->>'122_4')::numeric);
	cells_all := cells_all || to_json_null('123_5'::text,(cells_all->>'18_5')::numeric * ( 1 + (cells_all->>'119_5')::numeric + (cells_all->>'120_5')::numeric + (cells_all->>'121_5')::numeric) + (cells_all->>'122_5')::numeric);
	cells_all := cells_all || to_json_null('123_6'::text,(cells_all->>'18_6')::numeric * ( 1 + (cells_all->>'119_6')::numeric + (cells_all->>'120_6')::numeric + (cells_all->>'121_6')::numeric) + (cells_all->>'122_6')::numeric);
	cells_all := cells_all || to_json_null('123_7'::text,(cells_all->>'18_7')::numeric * ( 1 + (cells_all->>'119_7')::numeric + (cells_all->>'120_7')::numeric + (cells_all->>'121_7')::numeric) + (cells_all->>'122_7')::numeric);
	cells_all := cells_all || to_json_null('123_8'::text,(cells_all->>'18_8')::numeric * ( 1 + (cells_all->>'119_8')::numeric + (cells_all->>'120_8')::numeric + (cells_all->>'121_8')::numeric) + (cells_all->>'122_8')::numeric);
	cells_all := cells_all || to_json_null('123_9'::text,(cells_all->>'18_9')::numeric * ( 1 + (cells_all->>'119_9')::numeric + (cells_all->>'120_9')::numeric + (cells_all->>'121_9')::numeric) + (cells_all->>'122_9')::numeric);

-- 	C125	=C26
-- 	C126	=Demographics!D3

-- 	C127	=((C124*C125*C126)*365)/1000000

	cells_all := cells_all || to_json_null('127_0'::text,((cells_all->>'124_0')::numeric * (cells_all->>'125_0')::numeric * (cells_all->>'126_0')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_1'::text,((cells_all->>'124_1')::numeric * (cells_all->>'125_1')::numeric * (cells_all->>'126_1')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_2'::text,((cells_all->>'124_2')::numeric * (cells_all->>'125_2')::numeric * (cells_all->>'126_2')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_3'::text,((cells_all->>'124_3')::numeric * (cells_all->>'125_3')::numeric * (cells_all->>'126_3')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_4'::text,((cells_all->>'124_4')::numeric * (cells_all->>'125_4')::numeric * (cells_all->>'126_4')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_5'::text,((cells_all->>'124_5')::numeric * (cells_all->>'125_5')::numeric * (cells_all->>'126_5')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_6'::text,((cells_all->>'124_6')::numeric * (cells_all->>'125_6')::numeric * (cells_all->>'126_6')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_7'::text,((cells_all->>'124_7')::numeric * (cells_all->>'125_7')::numeric * (cells_all->>'126_7')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_8'::text,((cells_all->>'124_8')::numeric * (cells_all->>'125_8')::numeric * (cells_all->>'126_8')::numeric * 365) / 1000000);
	cells_all := cells_all || to_json_null('127_9'::text,((cells_all->>'124_9')::numeric * (cells_all->>'125_9')::numeric * (cells_all->>'126_9')::numeric * 365) / 1000000);

-- 	C128	=C36

-- 	C129	=IF(C128=0,0,C27)

	cells_all := cells_all || to_json_null('129_0'::text,case when (cells_all->>'128_0')::numeric = 0 then 0 else (cells_all->>'27_0')::numeric end);
	cells_all := cells_all || to_json_null('129_1'::text,case when (cells_all->>'128_1')::numeric = 0 then 0 else (cells_all->>'27_1')::numeric end);
	cells_all := cells_all || to_json_null('129_2'::text,case when (cells_all->>'128_2')::numeric = 0 then 0 else (cells_all->>'27_2')::numeric end);
	cells_all := cells_all || to_json_null('129_3'::text,case when (cells_all->>'128_3')::numeric = 0 then 0 else (cells_all->>'27_3')::numeric end);
	cells_all := cells_all || to_json_null('129_4'::text,case when (cells_all->>'128_4')::numeric = 0 then 0 else (cells_all->>'27_4')::numeric end);
	cells_all := cells_all || to_json_null('129_5'::text,case when (cells_all->>'128_5')::numeric = 0 then 0 else (cells_all->>'27_5')::numeric end);
	cells_all := cells_all || to_json_null('129_6'::text,case when (cells_all->>'128_6')::numeric = 0 then 0 else (cells_all->>'27_6')::numeric end);
	cells_all := cells_all || to_json_null('129_7'::text,case when (cells_all->>'128_7')::numeric = 0 then 0 else (cells_all->>'27_7')::numeric end);
	cells_all := cells_all || to_json_null('129_8'::text,case when (cells_all->>'128_8')::numeric = 0 then 0 else (cells_all->>'27_8')::numeric end);
	cells_all := cells_all || to_json_null('129_9'::text,case when (cells_all->>'128_9')::numeric = 0 then 0 else (cells_all->>'27_9')::numeric end);

-- 	C130	=C127*C129*C128
 
	cells_all := cells_all || to_json_null('130_0'::text,(cells_all->>'127_0')::numeric * (cells_all->>'129_0')::numeric * (cells_all->>'128_0')::numeric);
	cells_all := cells_all || to_json_null('130_1'::text,(cells_all->>'127_1')::numeric * (cells_all->>'129_1')::numeric * (cells_all->>'128_1')::numeric);
	cells_all := cells_all || to_json_null('130_2'::text,(cells_all->>'127_2')::numeric * (cells_all->>'129_2')::numeric * (cells_all->>'128_2')::numeric);
	cells_all := cells_all || to_json_null('130_3'::text,(cells_all->>'127_3')::numeric * (cells_all->>'129_3')::numeric * (cells_all->>'128_3')::numeric);
	cells_all := cells_all || to_json_null('130_4'::text,(cells_all->>'127_4')::numeric * (cells_all->>'129_4')::numeric * (cells_all->>'128_4')::numeric);
	cells_all := cells_all || to_json_null('130_5'::text,(cells_all->>'127_5')::numeric * (cells_all->>'129_5')::numeric * (cells_all->>'128_5')::numeric);
	cells_all := cells_all || to_json_null('130_6'::text,(cells_all->>'127_6')::numeric * (cells_all->>'129_6')::numeric * (cells_all->>'128_6')::numeric);
	cells_all := cells_all || to_json_null('130_7'::text,(cells_all->>'127_7')::numeric * (cells_all->>'129_7')::numeric * (cells_all->>'128_7')::numeric);
	cells_all := cells_all || to_json_null('130_8'::text,(cells_all->>'127_8')::numeric * (cells_all->>'129_8')::numeric * (cells_all->>'128_8')::numeric);
	cells_all := cells_all || to_json_null('130_9'::text,(cells_all->>'127_9')::numeric * (cells_all->>'129_9')::numeric * (cells_all->>'128_9')::numeric);

-- 	C131	=C123*C130

	cells_all := cells_all || to_json_null('131_0'::text,(cells_all->>'127_0')::numeric * (cells_all->>'129_0')::numeric * (cells_all->>'128_0')::numeric * (cells_all->>'123_0')::numeric);
	cells_all := cells_all || to_json_null('131_1'::text,(cells_all->>'127_1')::numeric * (cells_all->>'129_1')::numeric * (cells_all->>'128_1')::numeric * (cells_all->>'123_1')::numeric);
	cells_all := cells_all || to_json_null('131_2'::text,(cells_all->>'127_2')::numeric * (cells_all->>'129_2')::numeric * (cells_all->>'128_2')::numeric * (cells_all->>'123_2')::numeric);
	cells_all := cells_all || to_json_null('131_3'::text,(cells_all->>'127_3')::numeric * (cells_all->>'129_3')::numeric * (cells_all->>'128_3')::numeric * (cells_all->>'123_3')::numeric);
	cells_all := cells_all || to_json_null('131_4'::text,(cells_all->>'127_4')::numeric * (cells_all->>'129_4')::numeric * (cells_all->>'128_4')::numeric * (cells_all->>'123_4')::numeric);
	cells_all := cells_all || to_json_null('131_5'::text,(cells_all->>'127_5')::numeric * (cells_all->>'129_5')::numeric * (cells_all->>'128_5')::numeric * (cells_all->>'123_5')::numeric);
	cells_all := cells_all || to_json_null('131_6'::text,(cells_all->>'127_6')::numeric * (cells_all->>'129_6')::numeric * (cells_all->>'128_6')::numeric * (cells_all->>'123_6')::numeric);
	cells_all := cells_all || to_json_null('131_7'::text,(cells_all->>'127_7')::numeric * (cells_all->>'129_7')::numeric * (cells_all->>'128_7')::numeric * (cells_all->>'123_7')::numeric);
	cells_all := cells_all || to_json_null('131_8'::text,(cells_all->>'127_8')::numeric * (cells_all->>'129_8')::numeric * (cells_all->>'128_8')::numeric * (cells_all->>'123_8')::numeric);
	cells_all := cells_all || to_json_null('131_9'::text,(cells_all->>'127_9')::numeric * (cells_all->>'129_9')::numeric * (cells_all->>'128_9')::numeric * (cells_all->>'123_9')::numeric);

-- 	C132	=C37

-- 	C133	=IF(C132=0,0,C27)

	cells_all := cells_all || to_json_null('133_0'::text,case when (cells_all->>'132_0')::numeric = 0 then 0 else (cells_all->>'27_0')::numeric end);
	cells_all := cells_all || to_json_null('133_1'::text,case when (cells_all->>'132_1')::numeric = 0 then 0 else (cells_all->>'27_1')::numeric end);
	cells_all := cells_all || to_json_null('133_2'::text,case when (cells_all->>'132_2')::numeric = 0 then 0 else (cells_all->>'27_2')::numeric end);
	cells_all := cells_all || to_json_null('133_3'::text,case when (cells_all->>'132_3')::numeric = 0 then 0 else (cells_all->>'27_3')::numeric end);
	cells_all := cells_all || to_json_null('133_4'::text,case when (cells_all->>'132_4')::numeric = 0 then 0 else (cells_all->>'27_4')::numeric end);
	cells_all := cells_all || to_json_null('133_5'::text,case when (cells_all->>'132_5')::numeric = 0 then 0 else (cells_all->>'27_5')::numeric end);
	cells_all := cells_all || to_json_null('133_6'::text,case when (cells_all->>'132_6')::numeric = 0 then 0 else (cells_all->>'27_6')::numeric end);
	cells_all := cells_all || to_json_null('133_7'::text,case when (cells_all->>'132_7')::numeric = 0 then 0 else (cells_all->>'27_7')::numeric end);
	cells_all := cells_all || to_json_null('133_8'::text,case when (cells_all->>'132_8')::numeric = 0 then 0 else (cells_all->>'27_8')::numeric end);
	cells_all := cells_all || to_json_null('133_9'::text,case when (cells_all->>'132_9')::numeric = 0 then 0 else (cells_all->>'27_9')::numeric end);

-- 	C134	=C127*C132*C133

	cells_all := cells_all || to_json_null('134_0'::text,(cells_all->>'127_0')::numeric * (cells_all->>'132_0')::numeric * (cells_all->>'133_0')::numeric);
	cells_all := cells_all || to_json_null('134_1'::text,(cells_all->>'127_1')::numeric * (cells_all->>'132_1')::numeric * (cells_all->>'133_1')::numeric);
	cells_all := cells_all || to_json_null('134_2'::text,(cells_all->>'127_2')::numeric * (cells_all->>'132_2')::numeric * (cells_all->>'133_2')::numeric);
	cells_all := cells_all || to_json_null('134_3'::text,(cells_all->>'127_3')::numeric * (cells_all->>'132_3')::numeric * (cells_all->>'133_3')::numeric);
	cells_all := cells_all || to_json_null('134_4'::text,(cells_all->>'127_4')::numeric * (cells_all->>'132_4')::numeric * (cells_all->>'133_4')::numeric);
	cells_all := cells_all || to_json_null('134_5'::text,(cells_all->>'127_5')::numeric * (cells_all->>'132_5')::numeric * (cells_all->>'133_5')::numeric);
	cells_all := cells_all || to_json_null('134_6'::text,(cells_all->>'127_6')::numeric * (cells_all->>'132_6')::numeric * (cells_all->>'133_6')::numeric);
	cells_all := cells_all || to_json_null('134_7'::text,(cells_all->>'127_7')::numeric * (cells_all->>'132_7')::numeric * (cells_all->>'133_7')::numeric);
	cells_all := cells_all || to_json_null('134_8'::text,(cells_all->>'127_8')::numeric * (cells_all->>'132_8')::numeric * (cells_all->>'133_8')::numeric);
	cells_all := cells_all || to_json_null('134_9'::text,(cells_all->>'127_9')::numeric * (cells_all->>'132_9')::numeric * (cells_all->>'133_9')::numeric);

-- 	C135	=C123*C134

	cells_all := cells_all || to_json_null('135_0'::text,(cells_all->>'123_0')::numeric * (cells_all->>'127_0')::numeric * (cells_all->>'132_0')::numeric * (cells_all->>'133_0')::numeric);
	cells_all := cells_all || to_json_null('135_1'::text,(cells_all->>'123_1')::numeric * (cells_all->>'127_1')::numeric * (cells_all->>'132_1')::numeric * (cells_all->>'133_1')::numeric);
	cells_all := cells_all || to_json_null('135_2'::text,(cells_all->>'123_2')::numeric * (cells_all->>'127_2')::numeric * (cells_all->>'132_2')::numeric * (cells_all->>'133_2')::numeric);
	cells_all := cells_all || to_json_null('135_3'::text,(cells_all->>'123_3')::numeric * (cells_all->>'127_3')::numeric * (cells_all->>'132_3')::numeric * (cells_all->>'133_3')::numeric);
	cells_all := cells_all || to_json_null('135_4'::text,(cells_all->>'123_4')::numeric * (cells_all->>'127_4')::numeric * (cells_all->>'132_4')::numeric * (cells_all->>'133_4')::numeric);
	cells_all := cells_all || to_json_null('135_5'::text,(cells_all->>'123_5')::numeric * (cells_all->>'127_5')::numeric * (cells_all->>'132_5')::numeric * (cells_all->>'133_5')::numeric);
	cells_all := cells_all || to_json_null('135_6'::text,(cells_all->>'123_6')::numeric * (cells_all->>'127_6')::numeric * (cells_all->>'132_6')::numeric * (cells_all->>'133_6')::numeric);
	cells_all := cells_all || to_json_null('135_7'::text,(cells_all->>'123_7')::numeric * (cells_all->>'127_7')::numeric * (cells_all->>'132_7')::numeric * (cells_all->>'133_7')::numeric);
	cells_all := cells_all || to_json_null('135_8'::text,(cells_all->>'123_8')::numeric * (cells_all->>'127_8')::numeric * (cells_all->>'132_8')::numeric * (cells_all->>'133_8')::numeric);
	cells_all := cells_all || to_json_null('135_9'::text,(cells_all->>'123_9')::numeric * (cells_all->>'127_9')::numeric * (cells_all->>'132_9')::numeric * (cells_all->>'133_9')::numeric);

-- 	C136	=C131+C135

	cells_all := cells_all || to_json_null('136_0'::text,(cells_all->>'131_0')::numeric + ((cells_all->>'123_0')::numeric * (cells_all->>'127_0')::numeric * (cells_all->>'132_0')::numeric * (cells_all->>'133_0')::numeric));
	cells_all := cells_all || to_json_null('136_1'::text,(cells_all->>'131_1')::numeric + ((cells_all->>'123_1')::numeric * (cells_all->>'127_1')::numeric * (cells_all->>'132_1')::numeric * (cells_all->>'133_1')::numeric));
	cells_all := cells_all || to_json_null('136_2'::text,(cells_all->>'131_2')::numeric + ((cells_all->>'123_2')::numeric * (cells_all->>'127_2')::numeric * (cells_all->>'132_2')::numeric * (cells_all->>'133_2')::numeric));
	cells_all := cells_all || to_json_null('136_3'::text,(cells_all->>'131_3')::numeric + ((cells_all->>'123_3')::numeric * (cells_all->>'127_3')::numeric * (cells_all->>'132_3')::numeric * (cells_all->>'133_3')::numeric));
	cells_all := cells_all || to_json_null('136_4'::text,(cells_all->>'131_4')::numeric + ((cells_all->>'123_4')::numeric * (cells_all->>'127_4')::numeric * (cells_all->>'132_4')::numeric * (cells_all->>'133_4')::numeric));
	cells_all := cells_all || to_json_null('136_5'::text,(cells_all->>'131_5')::numeric + ((cells_all->>'123_5')::numeric * (cells_all->>'127_5')::numeric * (cells_all->>'132_5')::numeric * (cells_all->>'133_5')::numeric));
	cells_all := cells_all || to_json_null('136_6'::text,(cells_all->>'131_6')::numeric + ((cells_all->>'123_6')::numeric * (cells_all->>'127_6')::numeric * (cells_all->>'132_6')::numeric * (cells_all->>'133_6')::numeric));
	cells_all := cells_all || to_json_null('136_7'::text,(cells_all->>'131_7')::numeric + ((cells_all->>'123_7')::numeric * (cells_all->>'127_7')::numeric * (cells_all->>'132_7')::numeric * (cells_all->>'133_7')::numeric));
	cells_all := cells_all || to_json_null('136_8'::text,(cells_all->>'131_8')::numeric + ((cells_all->>'123_8')::numeric * (cells_all->>'127_8')::numeric * (cells_all->>'132_8')::numeric * (cells_all->>'133_8')::numeric));
	cells_all := cells_all || to_json_null('136_9'::text,(cells_all->>'131_9')::numeric + ((cells_all->>'123_9')::numeric * (cells_all->>'127_9')::numeric * (cells_all->>'132_9')::numeric * (cells_all->>'133_9')::numeric));

-- 	C137	=C136

	cells_all := cells_all || to_json_null('137_0'::text,(cells_all->>'136_0')::numeric);
	cells_all := cells_all || to_json_null('137_1'::text,(cells_all->>'136_1')::numeric);
	cells_all := cells_all || to_json_null('137_2'::text,(cells_all->>'136_2')::numeric);
	cells_all := cells_all || to_json_null('137_3'::text,(cells_all->>'136_3')::numeric);
	cells_all := cells_all || to_json_null('137_4'::text,(cells_all->>'136_4')::numeric);
	cells_all := cells_all || to_json_null('137_5'::text,(cells_all->>'136_5')::numeric);
	cells_all := cells_all || to_json_null('137_6'::text,(cells_all->>'136_6')::numeric);
	cells_all := cells_all || to_json_null('137_7'::text,(cells_all->>'136_7')::numeric);
	cells_all := cells_all || to_json_null('137_8'::text,(cells_all->>'136_8')::numeric);
	cells_all := cells_all || to_json_null('137_9'::text,(cells_all->>'136_9')::numeric);
    
-- 	C142	='National Data'!B6*2

-- 	C143	=C31*C142*C141

	cells_all := cells_all || to_json_null('143_0'::text,(cells_all->>'31_0')::numeric * (cells_all->>'142_0')::numeric * (cells_all->>'141_0')::numeric);
	cells_all := cells_all || to_json_null('143_1'::text,(cells_all->>'31_1')::numeric * (cells_all->>'142_1')::numeric * (cells_all->>'141_1')::numeric);
	cells_all := cells_all || to_json_null('143_2'::text,(cells_all->>'31_2')::numeric * (cells_all->>'142_2')::numeric * (cells_all->>'141_2')::numeric);
	cells_all := cells_all || to_json_null('143_3'::text,(cells_all->>'31_3')::numeric * (cells_all->>'142_3')::numeric * (cells_all->>'141_3')::numeric);
	cells_all := cells_all || to_json_null('143_4'::text,(cells_all->>'31_4')::numeric * (cells_all->>'142_4')::numeric * (cells_all->>'141_4')::numeric);
	cells_all := cells_all || to_json_null('143_5'::text,(cells_all->>'31_5')::numeric * (cells_all->>'142_5')::numeric * (cells_all->>'141_5')::numeric);
	cells_all := cells_all || to_json_null('143_6'::text,(cells_all->>'31_6')::numeric * (cells_all->>'142_6')::numeric * (cells_all->>'141_6')::numeric);
	cells_all := cells_all || to_json_null('143_7'::text,(cells_all->>'31_7')::numeric * (cells_all->>'142_7')::numeric * (cells_all->>'141_7')::numeric);
	cells_all := cells_all || to_json_null('143_8'::text,(cells_all->>'31_8')::numeric * (cells_all->>'142_8')::numeric * (cells_all->>'141_8')::numeric);
	cells_all := cells_all || to_json_null('143_9'::text,(cells_all->>'31_9')::numeric * (cells_all->>'142_9')::numeric * (cells_all->>'141_9')::numeric);

-- 	C145	=C31*C144*($D$54)

	cells_all := cells_all || to_json_null('145_0'::text,(cells_all->>'31_0')::numeric * (cells_all->>'144_0')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_1'::text,(cells_all->>'31_1')::numeric * (cells_all->>'144_1')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_2'::text,(cells_all->>'31_2')::numeric * (cells_all->>'144_2')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_3'::text,(cells_all->>'31_3')::numeric * (cells_all->>'144_3')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_4'::text,(cells_all->>'31_4')::numeric * (cells_all->>'144_4')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_5'::text,(cells_all->>'31_5')::numeric * (cells_all->>'144_5')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_6'::text,(cells_all->>'31_6')::numeric * (cells_all->>'144_6')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_7'::text,(cells_all->>'31_7')::numeric * (cells_all->>'144_7')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_8'::text,(cells_all->>'31_8')::numeric * (cells_all->>'144_8')::numeric * (cells_all->>'54_1')::numeric);
	cells_all := cells_all || to_json_null('145_9'::text,(cells_all->>'31_9')::numeric * (cells_all->>'144_9')::numeric * (cells_all->>'54_1')::numeric);

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

-- Raise Notice'2.cells_all: %',cells_all;

delete from intervention_data_json
where intervention_id = int_id;

insert into intervention_data_json
(intervention_id, intervention_data)
values
(int_id, cells_all);	

end;

$$ LANGUAGE plpgsql;

-- select update_intervention_data_totals(1);

