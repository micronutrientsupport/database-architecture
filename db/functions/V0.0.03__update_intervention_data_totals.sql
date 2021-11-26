
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

    for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('31_' || i::text,round((cells_all->>'27_' || i)::numeric * (cells_all->>'30_' || i )::numeric));
    
    end loop;


-- 	C33	=IF(OR(C13>0,C14>0),3,0)

    for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('33__' || i::text, case when (cells_all->>'13_' || i)::numeric > 0 or (cells_all->>'14_' || i)::numeric > 0 then 3 else 0 end);
    
    end loop;

-- 	C34	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)

    for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('34__' || i::text, case when 
        (cells_all->>'6_' || i)::numeric > 0 or 
        (cells_all->>'7_' || i)::numeric > 0 or
        (cells_all->>'8_' || i)::numeric > 0 or
        (cells_all->>'9_' || i)::numeric > 0
      	then 3 else 0 end);
    
    end loop;  
 
-- 	C37	=1-C36

 	for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('37__' || i::text, 1 - (cells_all->>'36_' || i)::numeric);
    
    end loop;

-- 	C40	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))

 	for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('40__' || i::text, 
		case when (cells_all->>'27_' || i)::numeric = 0 then 1
			when (cells_all->>'27_' || i)::numeric > 0 and (cells_all->>'27_' || i)::numeric < 0.25 then 1 
			when (cells_all->>'27_' || i)::numeric >= 0.25 and (cells_all->>'27_' || i)::numeric < 0.5 then 2
			when (cells_all->>'27_' || i)::numeric >= 0.5 and (cells_all->>'27_' || i)::numeric < 0.75 then 3
					else 4 end
        );
    
    end loop;
   
   
	

-- 	C41	=IF(OR(C13>0, C14>0),3,0)

 	for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('41_' || i::text, case when (cells_all->>'13_' || i::text)::numeric > 0 or (cells_all->>'14_' || i::text)::numeric > 0 then 3 else 0 end);
    
    end loop;


-- 	C42	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)

 	for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('42_' || i::text, case when 
        (cells_all->>'6_' || i)::numeric > 0 or 
        (cells_all->>'7_' || i)::numeric > 0 or 
        (cells_all->>'8_' || i)::numeric > 0 or 
        (cells_all->>'9_' || i)::numeric > 0 then 3 else 0 end);
    
    end loop;

-- 	C44	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),6,IF(AND(C$27>=0.25,C$27<0.5),12,IF(AND(C$27>=0.5,C$27<0.75),18,24))))

 	for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('44_' || i::text, case when (cells_all->>'27_0')::numeric = 0 then 0
					when (cells_all->>'27_' || i)::numeric > 0 and (cells_all->>'27_' || i)::numeric < 0.25 then 6 
					when (cells_all->>'27_' || i)::numeric >= 0.25 and (cells_all->>'27_' || i)::numeric < 0.5 then 12
					when (cells_all->>'27_' || i)::numeric >= 0.5 and (cells_all->>'27_' || i)::numeric < 0.75 then 18
					else 24 end);
    
    end loop;

-- 	C45	=IF(OR(C13>0,C14>0),2,0)

    for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('45_' || i::text, case when (cells_all->>'13_' || i)::numeric > 0 or (cells_all->>'14_' || i)::numeric > 0 then 2 else 0 end );
    
    end loop;


-- 	C46	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),2,0)

   for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('46_' || i::text, case when 
        (cells_all->>'6_' || i)::numeric > 0 or 
        (cells_all->>'7_' || i)::numeric > 0 or 
        (cells_all->>'8_' || i)::numeric > 0 or 
        (cells_all->>'9_' || i)::numeric > 0 then 2 else 0 end );
    
    end loop;
    
-- 	C48	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))

   for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('48_' || i::text, case when (cells_all->>'27_0')::numeric = 0 then 1 					
                    when (cells_all->>'27_' || i)::numeric > 0 
                     and (cells_all->>'27_' || i)::numeric < 0.25 then 1 					
                    when (cells_all->>'27_' || i)::numeric >= 0.25 
                     and (cells_all->>'27_' || i)::numeric < 0.5 then 2 					
                    when (cells_all->>'27_' || i)::numeric >= 0.5 
                     and (cells_all->>'27_' || i)::numeric < 0.75 then 3 					
                    else 4 end );
    
    end loop;

-- 	C49	=IF(OR(C13>0,C14>0),5,0)

   for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('49_' || i::text, case when 
        (cells_all->>'13_' || i)::numeric > 0 or 
        (cells_all->>'14_' || i)::numeric > 0 then 5 else 0 end );
    
    end loop;

-- 	C50	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),5,0)

   for i in 1 .. 9 loop
    
        cells_all := cells_all || to_json_null('50_' || i::text, case when 
        (cells_all->>'6_' || i)::numeric > 0 or 
        (cells_all->>'7_' || i)::numeric > 0 or 
        (cells_all->>'8_' || i)::numeric > 0 or 
        (cells_all->>'9_' || i)::numeric > 0 then 5 else 0 end );
    
    end loop;

-- D54 =10000+0.15*10000	

-- D55 =MAX(C31:L31)-C31

   cells_all := cells_all || to_json_null('55_1'::text, 
   greatest((cells_all->>'31_0')::numeric, 
       (cells_all->>'31_1')::numeric,
       (cells_all->>'31_2')::numeric,
       (cells_all->>'31_3')::numeric,
       (cells_all->>'31_4')::numeric,
       (cells_all->>'31_5')::numeric,
       (cells_all->>'31_6')::numeric,
       (cells_all->>'31_7')::numeric,
       (cells_all->>'31_8')::numeric,
       (cells_all->>'31_9')::numeric) - (cells_all->>'31_0')::numeric);

-- D56 =D54*D55

   cells_all := cells_all || to_json_null('56_1'::text, (cells_all->>'54_1')::numeric *(cells_all->>'55_1')::numeric);

-- D57 =500*'GDP Deflators'!$H$38
-- D58 =200*'GDP Deflators'!$H$38
-- D59 =850*'GDP Deflators'!$H$38

-- D61 =SUM(D57:D59)*D60

   cells_all := cells_all || to_json_null('61_1'::text, ((cells_all->>'57_1')::numeric + (cells_all->>'57_8')::numeric + (cells_all->>'59_1')::numeric) * (cells_all->>'60_1')::numeric );

-- D63 =IF(C13>0,MAX(C31:L31)-C31,0)

    cells_all := cells_all || to_json_null('63_1'::text, case when (cells_all->>'13_0')::numeric > 0 then 
    greatest((cells_all->>'31_0')::numeric, 
       (cells_all->>'31_1')::numeric,
       (cells_all->>'31_2')::numeric,
       (cells_all->>'31_3')::numeric,
       (cells_all->>'31_4')::numeric,
       (cells_all->>'31_5')::numeric,
       (cells_all->>'31_6')::numeric,
       (cells_all->>'31_7')::numeric,
       (cells_all->>'31_8')::numeric,
       (cells_all->>'31_9')::numeric) - (cells_all->>'31_0')::numeric else 0 end );

-- D65 =IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),MAX(C31:L31)-C31,0)

    cells_all := cells_all || to_json_null('65_1'::text, case when 
    (cells_all->>'6_0')::numeric > 0 or   
    (cells_all->>'7_0')::numeric > 0 or 
    (cells_all->>'8_0')::numeric > 0 or 
    (cells_all->>'9_0')::numeric > 0 
    then 
    greatest((cells_all->>'31_0')::numeric, 
       (cells_all->>'31_1')::numeric,
       (cells_all->>'31_2')::numeric,
       (cells_all->>'31_3')::numeric,
       (cells_all->>'31_4')::numeric,
       (cells_all->>'31_5')::numeric,
       (cells_all->>'31_6')::numeric,
       (cells_all->>'31_7')::numeric,
       (cells_all->>'31_8')::numeric,
       (cells_all->>'31_9')::numeric) - (cells_all->>'31_0')::numeric else 0 end ); 

-- D67 =D65

    cells_all := cells_all || to_json_null('67_1'::text, (cells_all->>'65_1')::numeric);

-- D68 =D62*D63 + D64*D65+D66*D67

    cells_all := cells_all || to_json_null('68_1'::text, (cells_all->>'62_1')::numeric * (cells_all->>'63_1')::numeric + (cells_all->>'64_1')::numeric 
    * (cells_all->>'65_1')::numeric + (cells_all->>'66_1')::numeric * (cells_all->>'67_1')::numeric );

-- D70 =(D68+D56)*D69

    cells_all := cells_all || to_json_null('70_1'::text, 
    ((cells_all->>'68_1')::numeric + 
    (cells_all->>'56_1')::numeric) * 
    (cells_all->>'69_1')::numeric );

-- D71 ='National Data'!B15
-- D72 ='National Data'!B16

-- D73 =(D56+D61)*D71+D68*D72

    cells_all := cells_all || to_json_null('73_1'::text, 
    ((cells_all->>'56_1')::numeric + 
    (cells_all->>'61_1')::numeric) * 
    (cells_all->>'71_1')::numeric + 
    (cells_all->>'68_1')::numeric * 
    (cells_all->>'72_1')::numeric);

-- D74 ='National Data'!B10
-- D75 ='National Data'!B11

-- D76 =(D56+D61)*D74+D68*D75

   cells_all := cells_all || to_json_null('76_1'::text, 
   ((cells_all->>'56_1')::numeric + 
   (cells_all->>'61_1')::numeric) * 
   (cells_all->>'74_1')::numeric + 
   (cells_all->>'68_1')::numeric * 
   (cells_all->>'75_1')::numeric);

-- D77 =IF(C4="BAU",0,D56+D68+D70+D73+D76)

    cells_all := cells_all || to_json_null('77_1'::text,case when (cells_all->>'4_0')::numeric = 3 then 0 else
    (cells_all->>'56_1')::numeric +
    (cells_all->>'68_1')::numeric +
    (cells_all->>'70_1')::numeric +
    (cells_all->>'73_1')::numeric +
    (cells_all->>'76_1')::numeric end );

-- D79 =262.6*'GDP Deflators'!$G$38

-- D80 =MAX(C31:L31)-C31

    cells_all := cells_all || to_json_null('80_1'::text,
    greatest((cells_all->>'31_0')::numeric, 
       (cells_all->>'31_1')::numeric,
       (cells_all->>'31_2')::numeric,
       (cells_all->>'31_3')::numeric,
       (cells_all->>'31_4')::numeric,
       (cells_all->>'31_5')::numeric,
       (cells_all->>'31_6')::numeric,
       (cells_all->>'31_7')::numeric,
       (cells_all->>'31_8')::numeric,
       (cells_all->>'31_9')::numeric) - (cells_all->>'31_0')::numeric ); 

-- D81 =IF(C4="BAU",0,D79*D80)

    cells_all := cells_all || to_json_null('81_1'::text,case when (cells_all->>'4_0')::numeric = 3 then 0 else
    (cells_all->>'79_1')::numeric *
    (cells_all->>'80_1')::numeric end );

-- D83 =400*'GDP Deflators'!$G$38

-- D85 =MAX(C31:L31)-C31

    cells_all := cells_all || to_json_null('85_1'::text,
    greatest((cells_all->>'31_0')::numeric, 
       (cells_all->>'31_1')::numeric,
       (cells_all->>'31_2')::numeric,
       (cells_all->>'31_3')::numeric,
       (cells_all->>'31_4')::numeric,
       (cells_all->>'31_5')::numeric,
       (cells_all->>'31_6')::numeric,
       (cells_all->>'31_7')::numeric,
       (cells_all->>'31_8')::numeric,
       (cells_all->>'31_9')::numeric) - (cells_all->>'31_0')::numeric ); 

-- D86 =IF(C4="BAU",0,D83*D84*D85)

    cells_all := cells_all || to_json_null('81_1'::text,case when (cells_all->>'4_0')::numeric = 3 then 0 else
    (cells_all->>'83_1')::numeric *
    (cells_all->>'84_1')::numeric *
    (cells_all->>'85_1')::numeric end );

-- D87 =D77+D81+D86 

    cells_all := cells_all || to_json_null('87_1'::text,
    (cells_all->>'77_1')::numeric +
    (cells_all->>'81_1')::numeric +
    (cells_all->>'86_1')::numeric );

-- 	C91	=IF(C4="SU",200000*'GDP Deflators'!$G$38,0)

    -- TODO

-- 	C92	=IF(C4="SU",15000,0)

	cells_all := cells_all || to_json_null('92_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 15000 else 0 end);
	
-- 	C93	=IF(C4="SU",20000,0)

	cells_all := cells_all || to_json_null('93_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 20000 else 0 end);
	
-- 	C94	=IF(C4="SU", 10000,IF(C4="SC",5000,0))

	cells_all := cells_all || to_json_null('94_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 10000 when (cells_all->>'4_0')::numeric = 2 then 5000 else 0 end);
	
-- 	C95	=SUM(C91:C94)

	cells_all := cells_all || to_json_null('95_0'::text,(cells_all->>'91_0')::numeric + (cells_all->>'92_0')::numeric + (cells_all->>'93_0')::numeric + (cells_all->>'94_0')::numeric);
    
-- D98 =IF(C4="SU",IF(C13>0,D43+1+1,0),0)

    cells_all := cells_all || to_json_null('98_1'::text,
    case when (cells_all->>'4_0')::numeric = 1 then 
        case when (cells_all->>'13_0')::numeric > 0 then (cells_all->>'43_1')::numeric + 1 + 1 else 0 end
    else 0 end);

-- D100 =IF(C4="SU",IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),D43+1+1,0),0)

    cells_all := cells_all || to_json_null('100_1'::text,
    case when (cells_all->>'4_0')::numeric = 1 then 
        case when 
            (cells_all->>'6_0')::numeric > 0 or   
            (cells_all->>'7_0')::numeric > 0 or 
            (cells_all->>'8_0')::numeric > 0 or 
            (cells_all->>'9_0')::numeric > 0 
        then (cells_all->>'43_1')::numeric + 1 + 1 else 0 end
    else 0 end);

-- D102 =D100

    cells_all := cells_all || to_json_null('102_1'::text, (cells_all->>'100_1')::numeric);

-- D103 =D97*D98+D99*D100+D101*D102

    cells_all := cells_all || to_json_null('103_1'::text, 
   (cells_all->>'97_1')::numeric * 
   (cells_all->>'98_1')::numeric + 
   (cells_all->>'99_1')::numeric * 
   (cells_all->>'100_1')::numeric +
   (cells_all->>'101_1')::numeric *
   (cells_all->>'102_1')::numeric   );

-- D105 =D103*D104

    cells_all := cells_all || to_json_null('105_1'::text, 
   (cells_all->>'103_1')::numeric * 
   (cells_all->>'104_1')::numeric );

-- D106 =D103+D105   

    cells_all := cells_all || to_json_null('106_1'::text, 
   (cells_all->>'103_1')::numeric +
   (cells_all->>'105_1')::numeric );

-- 	C108	=IF(C4="BAU",0,IF(C4="SU",50000,25000))

	cells_all := cells_all || to_json_null('108_0'::text,case when (cells_all->>'4_0')::numeric = 3 then 0 when (cells_all->>'4_0')::numeric = 1 then  50000 else 25000 end);
	cells_all := cells_all || to_json_null('108_1'::text,case when (cells_all->>'4_1')::numeric = 3 then 0 when (cells_all->>'4_1')::numeric = 1 then  50000 else 25000 end);
	

-- 	C109	=C108

    cells_all := cells_all || to_json_null('109_0'::text,(cells_all->>'108_0')::numeric);
	cells_all := cells_all || to_json_null('109_1'::text,(cells_all->>'108_1')::numeric);
    
-- D111 =4000*'GDP Deflators'!$G$38

-- D112 =IF(C4="BAU",0,4)

    cells_all := cells_all || to_json_null('112_1'::text,case when (cells_all->>'4_0')::numeric = 3 then 0 else 4 end);

-- D113 =D111*D112

    cells_all := cells_all || to_json_null('113_1'::text, 
   (cells_all->>'111_1')::numeric *
   (cells_all->>'112_1')::numeric );

-- 	C114	=C95+C106+C109+C113

	cells_all := cells_all || to_json_null('114_0'::text,(cells_all->>'95_0')::numeric + (cells_all->>'106_0')::numeric + (cells_all->>'109_0')::numeric + (cells_all->>'113_0')::numeric);
	cells_all := cells_all || to_json_null('114_1'::text,(cells_all->>'95_1')::numeric + (cells_all->>'106_1')::numeric + (cells_all->>'109_1')::numeric + (cells_all->>'113_1')::numeric);
	
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

    cells_all := cells_all || to_json_null('146_0'::text,(cells_all->>'143_0')::numeric + (cells_all->>'145_0')::numeric);
	cells_all := cells_all || to_json_null('146_1'::text,(cells_all->>'143_1')::numeric + (cells_all->>'145_1')::numeric);
	cells_all := cells_all || to_json_null('146_2'::text,(cells_all->>'143_2')::numeric + (cells_all->>'145_2')::numeric);
	cells_all := cells_all || to_json_null('146_3'::text,(cells_all->>'143_3')::numeric + (cells_all->>'145_3')::numeric);
	cells_all := cells_all || to_json_null('146_4'::text,(cells_all->>'143_4')::numeric + (cells_all->>'145_4')::numeric);
	cells_all := cells_all || to_json_null('146_5'::text,(cells_all->>'143_5')::numeric + (cells_all->>'145_5')::numeric);
	cells_all := cells_all || to_json_null('146_6'::text,(cells_all->>'143_6')::numeric + (cells_all->>'145_6')::numeric);
	cells_all := cells_all || to_json_null('146_7'::text,(cells_all->>'143_7')::numeric + (cells_all->>'145_7')::numeric);
	cells_all := cells_all || to_json_null('146_8'::text,(cells_all->>'143_8')::numeric + (cells_all->>'145_8')::numeric);
	cells_all := cells_all || to_json_null('146_9'::text,(cells_all->>'143_9')::numeric + (cells_all->>'145_9')::numeric);

-- 	C148	=816.62/100
-- 	C150	='National Data'!B16
-- 	C151	='National Data'!B11

-- 	C152	=C148*(1+C149+C150+C151)

    cells_all := cells_all || to_json_null('152_0'::text, (cells_all->>'148_0')::numeric * (1 + (cells_all->>'149_0')::numeric + (cells_all->>'150_0')::numeric + (cells_all->>'151_0')::numeric));
	cells_all := cells_all || to_json_null('152_1'::text, (cells_all->>'148_1')::numeric * (1 + (cells_all->>'149_1')::numeric + (cells_all->>'150_1')::numeric + (cells_all->>'151_1')::numeric));
	cells_all := cells_all || to_json_null('152_2'::text, (cells_all->>'148_2')::numeric * (1 + (cells_all->>'149_2')::numeric + (cells_all->>'150_2')::numeric + (cells_all->>'151_2')::numeric));
	cells_all := cells_all || to_json_null('152_3'::text, (cells_all->>'148_3')::numeric * (1 + (cells_all->>'149_3')::numeric + (cells_all->>'150_3')::numeric + (cells_all->>'151_3')::numeric));
	cells_all := cells_all || to_json_null('152_4'::text, (cells_all->>'148_4')::numeric * (1 + (cells_all->>'149_4')::numeric + (cells_all->>'150_4')::numeric + (cells_all->>'151_4')::numeric));
	cells_all := cells_all || to_json_null('152_5'::text, (cells_all->>'148_5')::numeric * (1 + (cells_all->>'149_5')::numeric + (cells_all->>'150_5')::numeric + (cells_all->>'151_5')::numeric));
	cells_all := cells_all || to_json_null('152_6'::text, (cells_all->>'148_6')::numeric * (1 + (cells_all->>'149_6')::numeric + (cells_all->>'150_6')::numeric + (cells_all->>'151_6')::numeric));
	cells_all := cells_all || to_json_null('152_7'::text, (cells_all->>'148_7')::numeric * (1 + (cells_all->>'149_7')::numeric + (cells_all->>'150_7')::numeric + (cells_all->>'151_7')::numeric));
	cells_all := cells_all || to_json_null('152_8'::text, (cells_all->>'148_8')::numeric * (1 + (cells_all->>'149_8')::numeric + (cells_all->>'150_8')::numeric + (cells_all->>'151_8')::numeric));
	cells_all := cells_all || to_json_null('152_9'::text, (cells_all->>'148_9')::numeric * (1 + (cells_all->>'149_9')::numeric + (cells_all->>'150_9')::numeric + (cells_all->>'151_9')::numeric));

-- 	C153	=C33

    cells_all := cells_all || to_json_null('153_0'::text, (cells_all->>'33_0')::numeric);
	cells_all := cells_all || to_json_null('153_1'::text, (cells_all->>'33_1')::numeric);
	cells_all := cells_all || to_json_null('153_2'::text, (cells_all->>'33_2')::numeric);
	cells_all := cells_all || to_json_null('153_3'::text, (cells_all->>'33_3')::numeric);
	cells_all := cells_all || to_json_null('153_4'::text, (cells_all->>'33_4')::numeric);
	cells_all := cells_all || to_json_null('153_5'::text, (cells_all->>'33_5')::numeric);
	cells_all := cells_all || to_json_null('153_6'::text, (cells_all->>'33_6')::numeric);
	cells_all := cells_all || to_json_null('153_7'::text, (cells_all->>'33_7')::numeric);
	cells_all := cells_all || to_json_null('153_8'::text, (cells_all->>'33_8')::numeric);
	cells_all := cells_all || to_json_null('153_9'::text, (cells_all->>'33_9')::numeric);

-- 	C154	=673.19/100
-- 	C156	='National Data'!B16
-- 	C157	='National Data'!B11

-- 	C158	=C154*(1+C155+C156+C157)

    cells_all := cells_all || to_json_null('158_0'::text, (cells_all->>'154_0')::numeric * (1 + (cells_all->>'155_0')::numeric + (cells_all->>'156_0')::numeric + (cells_all->>'157_0')::numeric));
	cells_all := cells_all || to_json_null('158_1'::text, (cells_all->>'154_1')::numeric * (1 + (cells_all->>'155_1')::numeric + (cells_all->>'156_1')::numeric + (cells_all->>'157_1')::numeric));
	cells_all := cells_all || to_json_null('158_2'::text, (cells_all->>'154_2')::numeric * (1 + (cells_all->>'155_2')::numeric + (cells_all->>'156_2')::numeric + (cells_all->>'157_2')::numeric));
	cells_all := cells_all || to_json_null('158_3'::text, (cells_all->>'154_3')::numeric * (1 + (cells_all->>'155_3')::numeric + (cells_all->>'156_3')::numeric + (cells_all->>'157_3')::numeric));
	cells_all := cells_all || to_json_null('158_4'::text, (cells_all->>'154_4')::numeric * (1 + (cells_all->>'155_4')::numeric + (cells_all->>'156_4')::numeric + (cells_all->>'157_4')::numeric));
	cells_all := cells_all || to_json_null('158_5'::text, (cells_all->>'154_5')::numeric * (1 + (cells_all->>'155_5')::numeric + (cells_all->>'156_5')::numeric + (cells_all->>'157_5')::numeric));
	cells_all := cells_all || to_json_null('158_6'::text, (cells_all->>'154_6')::numeric * (1 + (cells_all->>'155_6')::numeric + (cells_all->>'156_6')::numeric + (cells_all->>'157_6')::numeric));
	cells_all := cells_all || to_json_null('158_7'::text, (cells_all->>'154_7')::numeric * (1 + (cells_all->>'155_7')::numeric + (cells_all->>'156_7')::numeric + (cells_all->>'157_7')::numeric));
	cells_all := cells_all || to_json_null('158_8'::text, (cells_all->>'154_8')::numeric * (1 + (cells_all->>'155_8')::numeric + (cells_all->>'156_8')::numeric + (cells_all->>'157_8')::numeric));
	cells_all := cells_all || to_json_null('158_9'::text, (cells_all->>'154_9')::numeric * (1 + (cells_all->>'155_9')::numeric + (cells_all->>'156_9')::numeric + (cells_all->>'157_9')::numeric));

-- 	C159	=C34

    cells_all := cells_all || to_json_null('159_0'::text, (cells_all->>'34_0')::numeric);
	cells_all := cells_all || to_json_null('159_1'::text, (cells_all->>'34_1')::numeric);
	cells_all := cells_all || to_json_null('159_2'::text, (cells_all->>'34_2')::numeric);
	cells_all := cells_all || to_json_null('159_3'::text, (cells_all->>'34_3')::numeric);
	cells_all := cells_all || to_json_null('159_4'::text, (cells_all->>'34_4')::numeric);
	cells_all := cells_all || to_json_null('159_5'::text, (cells_all->>'34_5')::numeric);
	cells_all := cells_all || to_json_null('159_6'::text, (cells_all->>'34_6')::numeric);
	cells_all := cells_all || to_json_null('159_7'::text, (cells_all->>'34_7')::numeric);
	cells_all := cells_all || to_json_null('159_8'::text, (cells_all->>'34_8')::numeric);
	cells_all := cells_all || to_json_null('159_9'::text, (cells_all->>'34_9')::numeric);

-- 	C160	=(C152*C153+C158*C159)*C31*C32

    cells_all := cells_all || to_json_null('160_0'::text, ((cells_all->>'152_0')::numeric * (cells_all->>'153_0')::numeric + (cells_all->>'158_0')::numeric * (cells_all->>'159_0')::numeric) * (cells_all->>'31_0')::numeric * (cells_all->>'32_0')::numeric);
	cells_all := cells_all || to_json_null('160_1'::text, ((cells_all->>'152_1')::numeric * (cells_all->>'153_1')::numeric + (cells_all->>'158_1')::numeric * (cells_all->>'159_1')::numeric) * (cells_all->>'31_1')::numeric * (cells_all->>'32_1')::numeric);
	cells_all := cells_all || to_json_null('160_2'::text, ((cells_all->>'152_2')::numeric * (cells_all->>'153_2')::numeric + (cells_all->>'158_2')::numeric * (cells_all->>'159_2')::numeric) * (cells_all->>'31_2')::numeric * (cells_all->>'32_2')::numeric);
	cells_all := cells_all || to_json_null('160_3'::text, ((cells_all->>'152_3')::numeric * (cells_all->>'153_3')::numeric + (cells_all->>'158_3')::numeric * (cells_all->>'159_3')::numeric) * (cells_all->>'31_3')::numeric * (cells_all->>'32_3')::numeric);
	cells_all := cells_all || to_json_null('160_4'::text, ((cells_all->>'152_4')::numeric * (cells_all->>'153_4')::numeric + (cells_all->>'158_4')::numeric * (cells_all->>'159_4')::numeric) * (cells_all->>'31_4')::numeric * (cells_all->>'32_4')::numeric);
	cells_all := cells_all || to_json_null('160_5'::text, ((cells_all->>'152_5')::numeric * (cells_all->>'153_5')::numeric + (cells_all->>'158_5')::numeric * (cells_all->>'159_5')::numeric) * (cells_all->>'31_5')::numeric * (cells_all->>'32_5')::numeric);
	cells_all := cells_all || to_json_null('160_6'::text, ((cells_all->>'152_6')::numeric * (cells_all->>'153_6')::numeric + (cells_all->>'158_6')::numeric * (cells_all->>'159_6')::numeric) * (cells_all->>'31_6')::numeric * (cells_all->>'32_6')::numeric);
	cells_all := cells_all || to_json_null('160_7'::text, ((cells_all->>'152_7')::numeric * (cells_all->>'153_7')::numeric + (cells_all->>'158_7')::numeric * (cells_all->>'159_7')::numeric) * (cells_all->>'31_7')::numeric * (cells_all->>'32_7')::numeric);
	cells_all := cells_all || to_json_null('160_8'::text, ((cells_all->>'152_8')::numeric * (cells_all->>'153_8')::numeric + (cells_all->>'158_8')::numeric * (cells_all->>'159_8')::numeric) * (cells_all->>'31_8')::numeric * (cells_all->>'32_8')::numeric);
	cells_all := cells_all || to_json_null('160_9'::text, ((cells_all->>'152_9')::numeric * (cells_all->>'153_9')::numeric + (cells_all->>'158_9')::numeric * (cells_all->>'159_9')::numeric) * (cells_all->>'31_9')::numeric * (cells_all->>'32_9')::numeric);

-- 	C162	='National Data'!B6*2.5

-- 	C163	=C161*C162*C31

	cells_all := cells_all || to_json_null('163_0'::text,(cells_all->>'161_0')::numeric * (cells_all->>'162_0')::numeric * (cells_all->>'31_0')::numeric);
	cells_all := cells_all || to_json_null('163_1'::text,(cells_all->>'161_1')::numeric * (cells_all->>'162_1')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('163_2'::text,(cells_all->>'161_2')::numeric * (cells_all->>'162_2')::numeric * (cells_all->>'31_2')::numeric);
	cells_all := cells_all || to_json_null('163_3'::text,(cells_all->>'161_3')::numeric * (cells_all->>'162_3')::numeric * (cells_all->>'31_3')::numeric);
	cells_all := cells_all || to_json_null('163_4'::text,(cells_all->>'161_4')::numeric * (cells_all->>'162_4')::numeric * (cells_all->>'31_4')::numeric);
	cells_all := cells_all || to_json_null('163_5'::text,(cells_all->>'161_5')::numeric * (cells_all->>'162_5')::numeric * (cells_all->>'31_5')::numeric);
	cells_all := cells_all || to_json_null('163_6'::text,(cells_all->>'161_6')::numeric * (cells_all->>'162_6')::numeric * (cells_all->>'31_6')::numeric);
	cells_all := cells_all || to_json_null('163_7'::text,(cells_all->>'161_7')::numeric * (cells_all->>'162_7')::numeric * (cells_all->>'31_7')::numeric);
	cells_all := cells_all || to_json_null('163_8'::text,(cells_all->>'161_8')::numeric * (cells_all->>'162_8')::numeric * (cells_all->>'31_8')::numeric);
	cells_all := cells_all || to_json_null('163_9'::text,(cells_all->>'161_9')::numeric * (cells_all->>'162_9')::numeric * (cells_all->>'31_9')::numeric);

-- 	C164	=C160+C163

    cells_all := cells_all || to_json_null('164_0'::text, (cells_all->>'160_0')::numeric + (cells_all->>'163_0')::numeric);
	cells_all := cells_all || to_json_null('164_1'::text, (cells_all->>'160_1')::numeric + (cells_all->>'163_1')::numeric);
	cells_all := cells_all || to_json_null('164_2'::text, (cells_all->>'160_2')::numeric + (cells_all->>'163_2')::numeric);
	cells_all := cells_all || to_json_null('164_3'::text, (cells_all->>'160_3')::numeric + (cells_all->>'163_3')::numeric);
	cells_all := cells_all || to_json_null('164_4'::text, (cells_all->>'160_4')::numeric + (cells_all->>'163_4')::numeric);
	cells_all := cells_all || to_json_null('164_5'::text, (cells_all->>'160_5')::numeric + (cells_all->>'163_5')::numeric);
	cells_all := cells_all || to_json_null('164_6'::text, (cells_all->>'160_6')::numeric + (cells_all->>'163_6')::numeric);
	cells_all := cells_all || to_json_null('164_7'::text, (cells_all->>'160_7')::numeric + (cells_all->>'163_7')::numeric);
	cells_all := cells_all || to_json_null('164_8'::text, (cells_all->>'160_8')::numeric + (cells_all->>'163_8')::numeric);
	cells_all := cells_all || to_json_null('164_9'::text, (cells_all->>'160_9')::numeric + (cells_all->>'163_9')::numeric);

-- 	C166	=50*'GDP Deflators'!$G$38

-- 	C168	=C166*C167*C31

	cells_all := cells_all || to_json_null('168_0'::text,(cells_all->>'166_0')::numeric * (cells_all->>'167_0')::numeric * (cells_all->>'31_0')::numeric);
	cells_all := cells_all || to_json_null('168_1'::text,(cells_all->>'166_1')::numeric * (cells_all->>'167_1')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('168_2'::text,(cells_all->>'166_2')::numeric * (cells_all->>'167_2')::numeric * (cells_all->>'31_2')::numeric);
	cells_all := cells_all || to_json_null('168_3'::text,(cells_all->>'166_3')::numeric * (cells_all->>'167_3')::numeric * (cells_all->>'31_3')::numeric);
	cells_all := cells_all || to_json_null('168_4'::text,(cells_all->>'166_4')::numeric * (cells_all->>'167_4')::numeric * (cells_all->>'31_4')::numeric);
	cells_all := cells_all || to_json_null('168_5'::text,(cells_all->>'166_5')::numeric * (cells_all->>'167_5')::numeric * (cells_all->>'31_5')::numeric);
	cells_all := cells_all || to_json_null('168_6'::text,(cells_all->>'166_6')::numeric * (cells_all->>'167_6')::numeric * (cells_all->>'31_6')::numeric);
	cells_all := cells_all || to_json_null('168_7'::text,(cells_all->>'166_7')::numeric * (cells_all->>'167_7')::numeric * (cells_all->>'31_7')::numeric);
	cells_all := cells_all || to_json_null('168_8'::text,(cells_all->>'166_8')::numeric * (cells_all->>'167_8')::numeric * (cells_all->>'31_8')::numeric);
	cells_all := cells_all || to_json_null('168_9'::text,(cells_all->>'166_9')::numeric * (cells_all->>'167_9')::numeric * (cells_all->>'31_9')::numeric);

-- 	C170	=200*'GDP Deflators'!F38

-- 	C172	=C170*C171*C31

	cells_all := cells_all || to_json_null('172_0'::text,(cells_all->>'170_0')::numeric * (cells_all->>'171_0')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_1'::text,(cells_all->>'170_1')::numeric * (cells_all->>'171_1')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_2'::text,(cells_all->>'170_2')::numeric * (cells_all->>'171_2')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_3'::text,(cells_all->>'170_3')::numeric * (cells_all->>'171_3')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_4'::text,(cells_all->>'170_4')::numeric * (cells_all->>'171_4')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_5'::text,(cells_all->>'170_5')::numeric * (cells_all->>'171_5')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_6'::text,(cells_all->>'170_6')::numeric * (cells_all->>'171_6')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_7'::text,(cells_all->>'170_7')::numeric * (cells_all->>'171_7')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_8'::text,(cells_all->>'170_8')::numeric * (cells_all->>'171_8')::numeric * (cells_all->>'31_1')::numeric);
	cells_all := cells_all || to_json_null('172_9'::text,(cells_all->>'170_9')::numeric * (cells_all->>'171_9')::numeric * (cells_all->>'31_1')::numeric);

-- 	C175	=C174*(C146+C164+C168+C172)

    cells_all := cells_all || to_json_null('175_0'::text, (cells_all->>'174_0')::numeric * ((cells_all->>'146_0')::numeric + (cells_all->>'164_0')::numeric + (cells_all->>'168_0')::numeric + (cells_all->>'172_0')::numeric));
	cells_all := cells_all || to_json_null('175_1'::text, (cells_all->>'174_1')::numeric * ((cells_all->>'146_1')::numeric + (cells_all->>'164_1')::numeric + (cells_all->>'168_1')::numeric + (cells_all->>'172_1')::numeric));
	cells_all := cells_all || to_json_null('175_2'::text, (cells_all->>'174_2')::numeric * ((cells_all->>'146_2')::numeric + (cells_all->>'164_2')::numeric + (cells_all->>'168_2')::numeric + (cells_all->>'172_2')::numeric));
	cells_all := cells_all || to_json_null('175_3'::text, (cells_all->>'174_3')::numeric * ((cells_all->>'146_3')::numeric + (cells_all->>'164_3')::numeric + (cells_all->>'168_3')::numeric + (cells_all->>'172_3')::numeric));
	cells_all := cells_all || to_json_null('175_4'::text, (cells_all->>'174_4')::numeric * ((cells_all->>'146_4')::numeric + (cells_all->>'164_4')::numeric + (cells_all->>'168_4')::numeric + (cells_all->>'172_4')::numeric));
	cells_all := cells_all || to_json_null('175_5'::text, (cells_all->>'174_5')::numeric * ((cells_all->>'146_5')::numeric + (cells_all->>'164_5')::numeric + (cells_all->>'168_5')::numeric + (cells_all->>'172_5')::numeric));
	cells_all := cells_all || to_json_null('175_6'::text, (cells_all->>'174_6')::numeric * ((cells_all->>'146_6')::numeric + (cells_all->>'164_6')::numeric + (cells_all->>'168_6')::numeric + (cells_all->>'172_6')::numeric));
	cells_all := cells_all || to_json_null('175_7'::text, (cells_all->>'174_7')::numeric * ((cells_all->>'146_7')::numeric + (cells_all->>'164_7')::numeric + (cells_all->>'168_7')::numeric + (cells_all->>'172_7')::numeric));
	cells_all := cells_all || to_json_null('175_8'::text, (cells_all->>'174_8')::numeric * ((cells_all->>'146_8')::numeric + (cells_all->>'164_8')::numeric + (cells_all->>'168_8')::numeric + (cells_all->>'172_8')::numeric));
	cells_all := cells_all || to_json_null('175_9'::text, (cells_all->>'174_9')::numeric * ((cells_all->>'146_9')::numeric + (cells_all->>'164_9')::numeric + (cells_all->>'168_9')::numeric + (cells_all->>'172_9')::numeric));

-- 	C176	=C146+C164+C168+C172+C175

    cells_all := cells_all || to_json_null('176_0'::text, (cells_all->>'146_0')::numeric + (cells_all->>'164_0')::numeric + (cells_all->>'168_0')::numeric + (cells_all->>'172_0')::numeric + (cells_all->>'175_0')::numeric);
	cells_all := cells_all || to_json_null('176_1'::text, (cells_all->>'146_1')::numeric + (cells_all->>'164_1')::numeric + (cells_all->>'168_1')::numeric + (cells_all->>'172_1')::numeric + (cells_all->>'175_1')::numeric);
	cells_all := cells_all || to_json_null('176_2'::text, (cells_all->>'146_2')::numeric + (cells_all->>'164_2')::numeric + (cells_all->>'168_2')::numeric + (cells_all->>'172_2')::numeric + (cells_all->>'175_2')::numeric);
	cells_all := cells_all || to_json_null('176_3'::text, (cells_all->>'146_3')::numeric + (cells_all->>'164_3')::numeric + (cells_all->>'168_3')::numeric + (cells_all->>'172_3')::numeric + (cells_all->>'175_3')::numeric);
	cells_all := cells_all || to_json_null('176_4'::text, (cells_all->>'146_4')::numeric + (cells_all->>'164_4')::numeric + (cells_all->>'168_4')::numeric + (cells_all->>'172_4')::numeric + (cells_all->>'175_4')::numeric);
	cells_all := cells_all || to_json_null('176_5'::text, (cells_all->>'146_5')::numeric + (cells_all->>'164_5')::numeric + (cells_all->>'168_5')::numeric + (cells_all->>'172_5')::numeric + (cells_all->>'175_5')::numeric);
	cells_all := cells_all || to_json_null('176_6'::text, (cells_all->>'146_6')::numeric + (cells_all->>'164_6')::numeric + (cells_all->>'168_6')::numeric + (cells_all->>'172_6')::numeric + (cells_all->>'175_6')::numeric);
	cells_all := cells_all || to_json_null('176_7'::text, (cells_all->>'146_7')::numeric + (cells_all->>'164_7')::numeric + (cells_all->>'168_7')::numeric + (cells_all->>'172_7')::numeric + (cells_all->>'175_7')::numeric);
	cells_all := cells_all || to_json_null('176_8'::text, (cells_all->>'146_8')::numeric + (cells_all->>'164_8')::numeric + (cells_all->>'168_8')::numeric + (cells_all->>'172_8')::numeric + (cells_all->>'175_8')::numeric);
	cells_all := cells_all || to_json_null('176_9'::text, (cells_all->>'146_9')::numeric + (cells_all->>'164_9')::numeric + (cells_all->>'168_9')::numeric + (cells_all->>'172_9')::numeric + (cells_all->>'175_9')::numeric);


-- 	C180	=130*'GDP Deflators'!$G$38

-- 	C181	=C30*C40

	cells_all := cells_all || to_json_null('181_0'::text,(cells_all->>'30_0')::numeric * (cells_all->>'40_0')::numeric);
	cells_all := cells_all || to_json_null('181_1'::text,(cells_all->>'30_1')::numeric * (cells_all->>'40_1')::numeric);
	cells_all := cells_all || to_json_null('181_2'::text,(cells_all->>'30_2')::numeric * (cells_all->>'40_2')::numeric);
	cells_all := cells_all || to_json_null('181_3'::text,(cells_all->>'30_3')::numeric * (cells_all->>'40_3')::numeric);
	cells_all := cells_all || to_json_null('181_4'::text,(cells_all->>'30_4')::numeric * (cells_all->>'40_4')::numeric);
	cells_all := cells_all || to_json_null('181_5'::text,(cells_all->>'30_5')::numeric * (cells_all->>'40_5')::numeric);
	cells_all := cells_all || to_json_null('181_6'::text,(cells_all->>'30_6')::numeric * (cells_all->>'40_6')::numeric);
	cells_all := cells_all || to_json_null('181_7'::text,(cells_all->>'30_7')::numeric * (cells_all->>'40_7')::numeric);
	cells_all := cells_all || to_json_null('181_8'::text,(cells_all->>'30_8')::numeric * (cells_all->>'40_8')::numeric);
	cells_all := cells_all || to_json_null('181_9'::text,(cells_all->>'30_9')::numeric * (cells_all->>'40_9')::numeric);

-- 	C182	=C180*C181

	cells_all := cells_all || to_json_null('182_0'::text,(cells_all->>'180_0')::numeric * (cells_all->>'181_0')::numeric);
	cells_all := cells_all || to_json_null('182_1'::text,(cells_all->>'180_1')::numeric * (cells_all->>'181_1')::numeric);
	cells_all := cells_all || to_json_null('182_2'::text,(cells_all->>'180_2')::numeric * (cells_all->>'181_2')::numeric);
	cells_all := cells_all || to_json_null('182_3'::text,(cells_all->>'180_3')::numeric * (cells_all->>'181_3')::numeric);
	cells_all := cells_all || to_json_null('182_4'::text,(cells_all->>'180_4')::numeric * (cells_all->>'181_4')::numeric);
	cells_all := cells_all || to_json_null('182_5'::text,(cells_all->>'180_5')::numeric * (cells_all->>'181_5')::numeric);
	cells_all := cells_all || to_json_null('182_6'::text,(cells_all->>'180_6')::numeric * (cells_all->>'181_6')::numeric);
	cells_all := cells_all || to_json_null('182_7'::text,(cells_all->>'180_7')::numeric * (cells_all->>'181_7')::numeric);
	cells_all := cells_all || to_json_null('182_8'::text,(cells_all->>'180_8')::numeric * (cells_all->>'181_8')::numeric);
	cells_all := cells_all || to_json_null('182_9'::text,(cells_all->>'180_9')::numeric * (cells_all->>'181_9')::numeric);


-- 	C183	=816.62/100

-- 	C185	=C183*(1+C184)

	cells_all := cells_all || to_json_null('185_0'::text, (cells_all->>'183_0')::numeric * (1 + (cells_all->>'184_0')::numeric));
	cells_all := cells_all || to_json_null('185_1'::text, (cells_all->>'183_1')::numeric * (1 + (cells_all->>'184_1')::numeric));
	cells_all := cells_all || to_json_null('185_2'::text, (cells_all->>'183_2')::numeric * (1 + (cells_all->>'184_2')::numeric));
	cells_all := cells_all || to_json_null('185_3'::text, (cells_all->>'183_3')::numeric * (1 + (cells_all->>'184_3')::numeric));
	cells_all := cells_all || to_json_null('185_4'::text, (cells_all->>'183_4')::numeric * (1 + (cells_all->>'184_4')::numeric));
	cells_all := cells_all || to_json_null('185_5'::text, (cells_all->>'183_5')::numeric * (1 + (cells_all->>'184_5')::numeric));
	cells_all := cells_all || to_json_null('185_6'::text, (cells_all->>'183_6')::numeric * (1 + (cells_all->>'184_6')::numeric));
	cells_all := cells_all || to_json_null('185_7'::text, (cells_all->>'183_7')::numeric * (1 + (cells_all->>'184_7')::numeric));
	cells_all := cells_all || to_json_null('185_8'::text, (cells_all->>'183_8')::numeric * (1 + (cells_all->>'184_8')::numeric));
	cells_all := cells_all || to_json_null('185_9'::text, (cells_all->>'183_9')::numeric * (1 + (cells_all->>'184_9')::numeric));

-- 	C186	=C41

	cells_all := cells_all || to_json_null('186_0'::text, (cells_all->>'41_0')::numeric);
	cells_all := cells_all || to_json_null('186_1'::text, (cells_all->>'41_1')::numeric);
	cells_all := cells_all || to_json_null('186_2'::text, (cells_all->>'41_2')::numeric);
	cells_all := cells_all || to_json_null('186_3'::text, (cells_all->>'41_3')::numeric);
	cells_all := cells_all || to_json_null('186_4'::text, (cells_all->>'41_4')::numeric);
	cells_all := cells_all || to_json_null('186_5'::text, (cells_all->>'41_5')::numeric);
	cells_all := cells_all || to_json_null('186_6'::text, (cells_all->>'41_6')::numeric);
	cells_all := cells_all || to_json_null('186_7'::text, (cells_all->>'41_7')::numeric);
	cells_all := cells_all || to_json_null('186_8'::text, (cells_all->>'41_8')::numeric);
	cells_all := cells_all || to_json_null('186_9'::text, (cells_all->>'41_9')::numeric);

-- 	C187	=673.19/100

-- 	C189	=C187*(1+C188)

	cells_all := cells_all || to_json_null('189_0'::text, (cells_all->>'187_0')::numeric * (1 + (cells_all->>'188_0')::numeric));
	cells_all := cells_all || to_json_null('189_1'::text, (cells_all->>'187_1')::numeric * (1 + (cells_all->>'188_1')::numeric));
	cells_all := cells_all || to_json_null('189_2'::text, (cells_all->>'187_2')::numeric * (1 + (cells_all->>'188_2')::numeric));
	cells_all := cells_all || to_json_null('189_3'::text, (cells_all->>'187_3')::numeric * (1 + (cells_all->>'188_3')::numeric));
	cells_all := cells_all || to_json_null('189_4'::text, (cells_all->>'187_4')::numeric * (1 + (cells_all->>'188_4')::numeric));
	cells_all := cells_all || to_json_null('189_5'::text, (cells_all->>'187_5')::numeric * (1 + (cells_all->>'188_5')::numeric));
	cells_all := cells_all || to_json_null('189_6'::text, (cells_all->>'187_6')::numeric * (1 + (cells_all->>'188_6')::numeric));
	cells_all := cells_all || to_json_null('189_7'::text, (cells_all->>'187_7')::numeric * (1 + (cells_all->>'188_7')::numeric));
	cells_all := cells_all || to_json_null('189_8'::text, (cells_all->>'187_8')::numeric * (1 + (cells_all->>'188_8')::numeric));
	cells_all := cells_all || to_json_null('189_9'::text, (cells_all->>'187_9')::numeric * (1 + (cells_all->>'188_9')::numeric));

-- 	C190	=C42

	cells_all := cells_all || to_json_null('190_0'::text, (cells_all->>'42_0')::numeric);
	cells_all := cells_all || to_json_null('190_1'::text, (cells_all->>'42_1')::numeric);
	cells_all := cells_all || to_json_null('190_2'::text, (cells_all->>'42_2')::numeric);
	cells_all := cells_all || to_json_null('190_3'::text, (cells_all->>'42_3')::numeric);
	cells_all := cells_all || to_json_null('190_4'::text, (cells_all->>'42_4')::numeric);
	cells_all := cells_all || to_json_null('190_5'::text, (cells_all->>'42_5')::numeric);
	cells_all := cells_all || to_json_null('190_6'::text, (cells_all->>'42_6')::numeric);
	cells_all := cells_all || to_json_null('190_7'::text, (cells_all->>'42_7')::numeric);
	cells_all := cells_all || to_json_null('190_8'::text, (cells_all->>'42_8')::numeric);
	cells_all := cells_all || to_json_null('190_9'::text, (cells_all->>'42_9')::numeric);

-- 	C191	=(C185*C186+C189*C190)*C30*C40

    cells_all := cells_all || to_json_null('191_0'::text, ((cells_all->>'185_0')::numeric * (cells_all->>'186_0')::numeric + (cells_all->>'189_0')::numeric * (cells_all->>'190_0')::numeric) * (cells_all->>'30_0')::numeric * (cells_all->>'40_0')::numeric);
	cells_all := cells_all || to_json_null('191_1'::text, ((cells_all->>'185_1')::numeric * (cells_all->>'186_1')::numeric + (cells_all->>'189_1')::numeric * (cells_all->>'190_1')::numeric) * (cells_all->>'30_1')::numeric * (cells_all->>'40_1')::numeric);
	cells_all := cells_all || to_json_null('191_2'::text, ((cells_all->>'185_2')::numeric * (cells_all->>'186_2')::numeric + (cells_all->>'189_2')::numeric * (cells_all->>'190_2')::numeric) * (cells_all->>'30_2')::numeric * (cells_all->>'40_2')::numeric);
	cells_all := cells_all || to_json_null('191_3'::text, ((cells_all->>'185_3')::numeric * (cells_all->>'186_3')::numeric + (cells_all->>'189_3')::numeric * (cells_all->>'190_3')::numeric) * (cells_all->>'30_3')::numeric * (cells_all->>'40_3')::numeric);
	cells_all := cells_all || to_json_null('191_4'::text, ((cells_all->>'185_4')::numeric * (cells_all->>'186_4')::numeric + (cells_all->>'189_4')::numeric * (cells_all->>'190_4')::numeric) * (cells_all->>'30_4')::numeric * (cells_all->>'40_4')::numeric);
	cells_all := cells_all || to_json_null('191_5'::text, ((cells_all->>'185_5')::numeric * (cells_all->>'186_5')::numeric + (cells_all->>'189_5')::numeric * (cells_all->>'190_5')::numeric) * (cells_all->>'30_5')::numeric * (cells_all->>'40_5')::numeric);
	cells_all := cells_all || to_json_null('191_6'::text, ((cells_all->>'185_6')::numeric * (cells_all->>'186_6')::numeric + (cells_all->>'189_6')::numeric * (cells_all->>'190_6')::numeric) * (cells_all->>'30_6')::numeric * (cells_all->>'40_6')::numeric);
	cells_all := cells_all || to_json_null('191_7'::text, ((cells_all->>'185_7')::numeric * (cells_all->>'186_7')::numeric + (cells_all->>'189_7')::numeric * (cells_all->>'190_7')::numeric) * (cells_all->>'30_7')::numeric * (cells_all->>'40_7')::numeric);
	cells_all := cells_all || to_json_null('191_8'::text, ((cells_all->>'185_8')::numeric * (cells_all->>'186_8')::numeric + (cells_all->>'189_8')::numeric * (cells_all->>'190_8')::numeric) * (cells_all->>'30_8')::numeric * (cells_all->>'40_8')::numeric);
	cells_all := cells_all || to_json_null('191_9'::text, ((cells_all->>'185_9')::numeric * (cells_all->>'186_9')::numeric + (cells_all->>'189_9')::numeric * (cells_all->>'190_9')::numeric) * (cells_all->>'30_9')::numeric * (cells_all->>'40_9')::numeric);


-- 	C192	=C182+C191

    cells_all := cells_all || to_json_null('192_0'::text, (cells_all->>'182_0')::numeric + (cells_all->>'191_0')::numeric);
	cells_all := cells_all || to_json_null('192_1'::text, (cells_all->>'182_1')::numeric + (cells_all->>'191_1')::numeric);
	cells_all := cells_all || to_json_null('192_2'::text, (cells_all->>'182_2')::numeric + (cells_all->>'191_2')::numeric);
	cells_all := cells_all || to_json_null('192_3'::text, (cells_all->>'182_3')::numeric + (cells_all->>'191_3')::numeric);
	cells_all := cells_all || to_json_null('192_4'::text, (cells_all->>'182_4')::numeric + (cells_all->>'191_4')::numeric);
	cells_all := cells_all || to_json_null('192_5'::text, (cells_all->>'182_5')::numeric + (cells_all->>'191_5')::numeric);
	cells_all := cells_all || to_json_null('192_6'::text, (cells_all->>'182_6')::numeric + (cells_all->>'191_6')::numeric);
	cells_all := cells_all || to_json_null('192_7'::text, (cells_all->>'182_7')::numeric + (cells_all->>'191_7')::numeric);
	cells_all := cells_all || to_json_null('192_8'::text, (cells_all->>'182_8')::numeric + (cells_all->>'191_8')::numeric);
	cells_all := cells_all || to_json_null('192_9'::text, (cells_all->>'182_9')::numeric + (cells_all->>'191_9')::numeric);

-- 	C195	='National Data'!B6*2.5

-- 	C196	=C194*C43*C195

	cells_all := cells_all || to_json_null('196_0'::text,(cells_all->>'194_0')::numeric * (cells_all->>'143_0')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_1'::text,(cells_all->>'194_1')::numeric * (cells_all->>'143_1')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_2'::text,(cells_all->>'194_2')::numeric * (cells_all->>'143_2')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_3'::text,(cells_all->>'194_3')::numeric * (cells_all->>'143_3')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_4'::text,(cells_all->>'194_4')::numeric * (cells_all->>'143_4')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_5'::text,(cells_all->>'194_5')::numeric * (cells_all->>'143_5')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_6'::text,(cells_all->>'194_6')::numeric * (cells_all->>'143_6')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_7'::text,(cells_all->>'194_7')::numeric * (cells_all->>'143_7')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_8'::text,(cells_all->>'194_8')::numeric * (cells_all->>'143_8')::numeric * (cells_all->>'195_1')::numeric);
	cells_all := cells_all || to_json_null('196_9'::text,(cells_all->>'194_9')::numeric * (cells_all->>'143_9')::numeric * (cells_all->>'195_1')::numeric);

-- 	C197	=816.62/100

-- 	C199	=C197*(1+C198)

	cells_all := cells_all || to_json_null('199_0'::text, (cells_all->>'197_0')::numeric * (1 + (cells_all->>'198_0')::numeric));
	cells_all := cells_all || to_json_null('199_1'::text, (cells_all->>'197_1')::numeric * (1 + (cells_all->>'198_1')::numeric));
	cells_all := cells_all || to_json_null('199_2'::text, (cells_all->>'197_2')::numeric * (1 + (cells_all->>'198_2')::numeric));
	cells_all := cells_all || to_json_null('199_3'::text, (cells_all->>'197_3')::numeric * (1 + (cells_all->>'198_3')::numeric));
	cells_all := cells_all || to_json_null('199_4'::text, (cells_all->>'197_4')::numeric * (1 + (cells_all->>'198_4')::numeric));
	cells_all := cells_all || to_json_null('199_5'::text, (cells_all->>'197_5')::numeric * (1 + (cells_all->>'198_5')::numeric));
	cells_all := cells_all || to_json_null('199_6'::text, (cells_all->>'197_6')::numeric * (1 + (cells_all->>'198_6')::numeric));
	cells_all := cells_all || to_json_null('199_7'::text, (cells_all->>'197_7')::numeric * (1 + (cells_all->>'198_7')::numeric));
	cells_all := cells_all || to_json_null('199_8'::text, (cells_all->>'197_8')::numeric * (1 + (cells_all->>'198_8')::numeric));
	cells_all := cells_all || to_json_null('199_9'::text, (cells_all->>'197_9')::numeric * (1 + (cells_all->>'198_9')::numeric));

-- 	C200	=C45

	cells_all := cells_all || to_json_null('200_0'::text, (cells_all->>'45_0')::numeric);
	cells_all := cells_all || to_json_null('200_1'::text, (cells_all->>'45_1')::numeric);
	cells_all := cells_all || to_json_null('200_2'::text, (cells_all->>'45_2')::numeric);
	cells_all := cells_all || to_json_null('200_3'::text, (cells_all->>'45_3')::numeric);
	cells_all := cells_all || to_json_null('200_4'::text, (cells_all->>'45_4')::numeric);
	cells_all := cells_all || to_json_null('200_5'::text, (cells_all->>'45_5')::numeric);
	cells_all := cells_all || to_json_null('200_6'::text, (cells_all->>'45_6')::numeric);
	cells_all := cells_all || to_json_null('200_7'::text, (cells_all->>'45_7')::numeric);
	cells_all := cells_all || to_json_null('200_8'::text, (cells_all->>'45_8')::numeric);
	cells_all := cells_all || to_json_null('200_9'::text, (cells_all->>'45_9')::numeric);

-- 	C201	=673.19/100

-- 	C203	=C201*(1+C202)

	cells_all := cells_all || to_json_null('203_0'::text, (cells_all->>'201_0')::numeric * (1 + (cells_all->>'202_0')::numeric));
	cells_all := cells_all || to_json_null('203_1'::text, (cells_all->>'201_1')::numeric * (1 + (cells_all->>'202_1')::numeric));
	cells_all := cells_all || to_json_null('203_2'::text, (cells_all->>'201_2')::numeric * (1 + (cells_all->>'202_2')::numeric));
	cells_all := cells_all || to_json_null('203_3'::text, (cells_all->>'201_3')::numeric * (1 + (cells_all->>'202_3')::numeric));
	cells_all := cells_all || to_json_null('203_4'::text, (cells_all->>'201_4')::numeric * (1 + (cells_all->>'202_4')::numeric));
	cells_all := cells_all || to_json_null('203_5'::text, (cells_all->>'201_5')::numeric * (1 + (cells_all->>'202_5')::numeric));
	cells_all := cells_all || to_json_null('203_6'::text, (cells_all->>'201_6')::numeric * (1 + (cells_all->>'202_6')::numeric));
	cells_all := cells_all || to_json_null('203_7'::text, (cells_all->>'201_7')::numeric * (1 + (cells_all->>'202_7')::numeric));
	cells_all := cells_all || to_json_null('203_8'::text, (cells_all->>'201_8')::numeric * (1 + (cells_all->>'202_8')::numeric));
	cells_all := cells_all || to_json_null('203_9'::text, (cells_all->>'201_9')::numeric * (1 + (cells_all->>'202_9')::numeric));

-- 	C204	=C46

	cells_all := cells_all || to_json_null('204_0'::text, (cells_all->>'46_0')::numeric);
	cells_all := cells_all || to_json_null('204_1'::text, (cells_all->>'46_1')::numeric);
	cells_all := cells_all || to_json_null('204_2'::text, (cells_all->>'46_2')::numeric);
	cells_all := cells_all || to_json_null('204_3'::text, (cells_all->>'46_3')::numeric);
	cells_all := cells_all || to_json_null('204_4'::text, (cells_all->>'46_4')::numeric);
	cells_all := cells_all || to_json_null('204_5'::text, (cells_all->>'46_5')::numeric);
	cells_all := cells_all || to_json_null('204_6'::text, (cells_all->>'46_6')::numeric);
	cells_all := cells_all || to_json_null('204_7'::text, (cells_all->>'46_7')::numeric);
	cells_all := cells_all || to_json_null('204_8'::text, (cells_all->>'46_8')::numeric);
	cells_all := cells_all || to_json_null('204_9'::text, (cells_all->>'46_9')::numeric);

-- 	C205	=(C199*C200+C203*C204)*C43*C44

    cells_all := cells_all || to_json_null('205_0'::text, ((cells_all->>'199_0')::numeric * (cells_all->>'200_0')::numeric + (cells_all->>'203_0')::numeric * (cells_all->>'204_0')::numeric) * (cells_all->>'43_0')::numeric * (cells_all->>'44_0')::numeric);
	cells_all := cells_all || to_json_null('205_1'::text, ((cells_all->>'199_1')::numeric * (cells_all->>'200_1')::numeric + (cells_all->>'203_1')::numeric * (cells_all->>'204_1')::numeric) * (cells_all->>'43_1')::numeric * (cells_all->>'44_1')::numeric);
	cells_all := cells_all || to_json_null('205_2'::text, ((cells_all->>'199_2')::numeric * (cells_all->>'200_2')::numeric + (cells_all->>'203_2')::numeric * (cells_all->>'204_2')::numeric) * (cells_all->>'43_2')::numeric * (cells_all->>'44_2')::numeric);
	cells_all := cells_all || to_json_null('205_3'::text, ((cells_all->>'199_3')::numeric * (cells_all->>'200_3')::numeric + (cells_all->>'203_3')::numeric * (cells_all->>'204_3')::numeric) * (cells_all->>'43_3')::numeric * (cells_all->>'44_3')::numeric);
	cells_all := cells_all || to_json_null('205_4'::text, ((cells_all->>'199_4')::numeric * (cells_all->>'200_4')::numeric + (cells_all->>'203_4')::numeric * (cells_all->>'204_4')::numeric) * (cells_all->>'43_4')::numeric * (cells_all->>'44_4')::numeric);
	cells_all := cells_all || to_json_null('205_5'::text, ((cells_all->>'199_5')::numeric * (cells_all->>'200_5')::numeric + (cells_all->>'203_5')::numeric * (cells_all->>'204_5')::numeric) * (cells_all->>'43_5')::numeric * (cells_all->>'44_5')::numeric);
	cells_all := cells_all || to_json_null('205_6'::text, ((cells_all->>'199_6')::numeric * (cells_all->>'200_6')::numeric + (cells_all->>'203_6')::numeric * (cells_all->>'204_6')::numeric) * (cells_all->>'43_6')::numeric * (cells_all->>'44_6')::numeric);
	cells_all := cells_all || to_json_null('205_7'::text, ((cells_all->>'199_7')::numeric * (cells_all->>'200_7')::numeric + (cells_all->>'203_7')::numeric * (cells_all->>'204_7')::numeric) * (cells_all->>'43_7')::numeric * (cells_all->>'44_7')::numeric);
	cells_all := cells_all || to_json_null('205_8'::text, ((cells_all->>'199_8')::numeric * (cells_all->>'200_8')::numeric + (cells_all->>'203_8')::numeric * (cells_all->>'204_8')::numeric) * (cells_all->>'43_8')::numeric * (cells_all->>'44_8')::numeric);
	cells_all := cells_all || to_json_null('205_9'::text, ((cells_all->>'199_9')::numeric * (cells_all->>'200_9')::numeric + (cells_all->>'203_9')::numeric * (cells_all->>'204_9')::numeric) * (cells_all->>'43_9')::numeric * (cells_all->>'44_9')::numeric);

-- 	C206	=C196+C205

    cells_all := cells_all || to_json_null('206_0'::text, (cells_all->>'196_0')::numeric + (cells_all->>'205_0')::numeric);
	cells_all := cells_all || to_json_null('206_1'::text, (cells_all->>'196_1')::numeric + (cells_all->>'205_1')::numeric);
	cells_all := cells_all || to_json_null('206_2'::text, (cells_all->>'196_2')::numeric + (cells_all->>'205_2')::numeric);
	cells_all := cells_all || to_json_null('206_3'::text, (cells_all->>'196_3')::numeric + (cells_all->>'205_3')::numeric);
	cells_all := cells_all || to_json_null('206_4'::text, (cells_all->>'196_4')::numeric + (cells_all->>'205_4')::numeric);
	cells_all := cells_all || to_json_null('206_5'::text, (cells_all->>'196_5')::numeric + (cells_all->>'205_5')::numeric);
	cells_all := cells_all || to_json_null('206_6'::text, (cells_all->>'196_6')::numeric + (cells_all->>'205_6')::numeric);
	cells_all := cells_all || to_json_null('206_7'::text, (cells_all->>'196_7')::numeric + (cells_all->>'205_7')::numeric);
	cells_all := cells_all || to_json_null('206_8'::text, (cells_all->>'196_8')::numeric + (cells_all->>'205_8')::numeric);
	cells_all := cells_all || to_json_null('206_9'::text, (cells_all->>'196_9')::numeric + (cells_all->>'205_9')::numeric);

-- 	C209	='National Data'!B6*2.5

-- 	C210	=C208*C209

    cells_all := cells_all || to_json_null('210_0'::text, (cells_all->>'208_0')::numeric * (cells_all->>'209_0')::numeric);
	cells_all := cells_all || to_json_null('210_1'::text, (cells_all->>'208_1')::numeric * (cells_all->>'209_1')::numeric);
	cells_all := cells_all || to_json_null('210_2'::text, (cells_all->>'208_2')::numeric * (cells_all->>'209_2')::numeric);
	cells_all := cells_all || to_json_null('210_3'::text, (cells_all->>'208_3')::numeric * (cells_all->>'209_3')::numeric);
	cells_all := cells_all || to_json_null('210_4'::text, (cells_all->>'208_4')::numeric * (cells_all->>'209_4')::numeric);
	cells_all := cells_all || to_json_null('210_5'::text, (cells_all->>'208_5')::numeric * (cells_all->>'209_5')::numeric);
	cells_all := cells_all || to_json_null('210_6'::text, (cells_all->>'208_6')::numeric * (cells_all->>'209_6')::numeric);
	cells_all := cells_all || to_json_null('210_7'::text, (cells_all->>'208_7')::numeric * (cells_all->>'209_7')::numeric);
	cells_all := cells_all || to_json_null('210_8'::text, (cells_all->>'208_8')::numeric * (cells_all->>'209_8')::numeric);
	cells_all := cells_all || to_json_null('210_9'::text, (cells_all->>'208_9')::numeric * (cells_all->>'209_9')::numeric);

-- 	C211	=816.62/100

-- 	C213	=C211*(1+C212)

    cells_all := cells_all || to_json_null('213_0'::text, (cells_all->>'211_0')::numeric * (1 + (cells_all->>'212_0')::numeric));
	cells_all := cells_all || to_json_null('213_1'::text, (cells_all->>'211_1')::numeric * (1 + (cells_all->>'212_1')::numeric));
	cells_all := cells_all || to_json_null('213_2'::text, (cells_all->>'211_2')::numeric * (1 + (cells_all->>'212_2')::numeric));
	cells_all := cells_all || to_json_null('213_3'::text, (cells_all->>'211_3')::numeric * (1 + (cells_all->>'212_3')::numeric));
	cells_all := cells_all || to_json_null('213_4'::text, (cells_all->>'211_4')::numeric * (1 + (cells_all->>'212_4')::numeric));
	cells_all := cells_all || to_json_null('213_5'::text, (cells_all->>'211_5')::numeric * (1 + (cells_all->>'212_5')::numeric));
	cells_all := cells_all || to_json_null('213_6'::text, (cells_all->>'211_6')::numeric * (1 + (cells_all->>'212_6')::numeric));
	cells_all := cells_all || to_json_null('213_7'::text, (cells_all->>'211_7')::numeric * (1 + (cells_all->>'212_7')::numeric));
	cells_all := cells_all || to_json_null('213_8'::text, (cells_all->>'211_8')::numeric * (1 + (cells_all->>'212_8')::numeric));
	cells_all := cells_all || to_json_null('213_9'::text, (cells_all->>'211_9')::numeric * (1 + (cells_all->>'212_9')::numeric));

-- 	C214	=C49

	cells_all := cells_all || to_json_null('214_0'::text, (cells_all->>'49_0')::numeric);
	cells_all := cells_all || to_json_null('214_1'::text, (cells_all->>'49_1')::numeric);
	cells_all := cells_all || to_json_null('214_2'::text, (cells_all->>'49_2')::numeric);
	cells_all := cells_all || to_json_null('214_3'::text, (cells_all->>'49_3')::numeric);
	cells_all := cells_all || to_json_null('214_4'::text, (cells_all->>'49_4')::numeric);
	cells_all := cells_all || to_json_null('214_5'::text, (cells_all->>'49_5')::numeric);
	cells_all := cells_all || to_json_null('214_6'::text, (cells_all->>'49_6')::numeric);
	cells_all := cells_all || to_json_null('214_7'::text, (cells_all->>'49_7')::numeric);
	cells_all := cells_all || to_json_null('214_8'::text, (cells_all->>'49_8')::numeric);
	cells_all := cells_all || to_json_null('214_9'::text, (cells_all->>'49_9')::numeric);

-- 	C215	=673.19/100

-- 	C217	=C215*(1+C216)

    cells_all := cells_all || to_json_null('217_0'::text, (cells_all->>'215_0')::numeric * (1 + (cells_all->>'216_0')::numeric));
	cells_all := cells_all || to_json_null('217_1'::text, (cells_all->>'215_1')::numeric * (1 + (cells_all->>'216_1')::numeric));
	cells_all := cells_all || to_json_null('217_2'::text, (cells_all->>'215_2')::numeric * (1 + (cells_all->>'216_2')::numeric));
	cells_all := cells_all || to_json_null('217_3'::text, (cells_all->>'215_3')::numeric * (1 + (cells_all->>'216_3')::numeric));
	cells_all := cells_all || to_json_null('217_4'::text, (cells_all->>'215_4')::numeric * (1 + (cells_all->>'216_4')::numeric));
	cells_all := cells_all || to_json_null('217_5'::text, (cells_all->>'215_5')::numeric * (1 + (cells_all->>'216_5')::numeric));
	cells_all := cells_all || to_json_null('217_6'::text, (cells_all->>'215_6')::numeric * (1 + (cells_all->>'216_6')::numeric));
	cells_all := cells_all || to_json_null('217_7'::text, (cells_all->>'215_7')::numeric * (1 + (cells_all->>'216_7')::numeric));
	cells_all := cells_all || to_json_null('217_8'::text, (cells_all->>'215_8')::numeric * (1 + (cells_all->>'216_8')::numeric));
	cells_all := cells_all || to_json_null('217_9'::text, (cells_all->>'215_9')::numeric * (1 + (cells_all->>'216_9')::numeric));

-- 	C218	=C50

	cells_all := cells_all || to_json_null('218_0'::text, (cells_all->>'50_0')::numeric);
	cells_all := cells_all || to_json_null('218_1'::text, (cells_all->>'50_1')::numeric);
	cells_all := cells_all || to_json_null('218_2'::text, (cells_all->>'50_2')::numeric);
	cells_all := cells_all || to_json_null('218_3'::text, (cells_all->>'50_3')::numeric);
	cells_all := cells_all || to_json_null('218_4'::text, (cells_all->>'50_4')::numeric);
	cells_all := cells_all || to_json_null('218_5'::text, (cells_all->>'50_5')::numeric);
	cells_all := cells_all || to_json_null('218_6'::text, (cells_all->>'50_6')::numeric);
	cells_all := cells_all || to_json_null('218_7'::text, (cells_all->>'50_7')::numeric);
	cells_all := cells_all || to_json_null('218_8'::text, (cells_all->>'50_8')::numeric);
	cells_all := cells_all || to_json_null('218_9'::text, (cells_all->>'50_9')::numeric);

-- 	C219	=(C213*C214+C217*C218)*(C47*C48)

    cells_all := cells_all || to_json_null('219_0'::text, ((cells_all->>'213_0')::numeric * (cells_all->>'214_0')::numeric + (cells_all->>'217_0')::numeric * (cells_all->>'218_0')::numeric) * ((cells_all->>'47_0')::numeric * (cells_all->>'48_0')::numeric));
	cells_all := cells_all || to_json_null('219_1'::text, ((cells_all->>'213_1')::numeric * (cells_all->>'214_1')::numeric + (cells_all->>'217_1')::numeric * (cells_all->>'218_1')::numeric) * ((cells_all->>'47_1')::numeric * (cells_all->>'48_1')::numeric));
	cells_all := cells_all || to_json_null('219_2'::text, ((cells_all->>'213_2')::numeric * (cells_all->>'214_2')::numeric + (cells_all->>'217_2')::numeric * (cells_all->>'218_2')::numeric) * ((cells_all->>'47_2')::numeric * (cells_all->>'48_2')::numeric));
	cells_all := cells_all || to_json_null('219_3'::text, ((cells_all->>'213_3')::numeric * (cells_all->>'214_3')::numeric + (cells_all->>'217_3')::numeric * (cells_all->>'218_3')::numeric) * ((cells_all->>'47_3')::numeric * (cells_all->>'48_3')::numeric));
	cells_all := cells_all || to_json_null('219_4'::text, ((cells_all->>'213_4')::numeric * (cells_all->>'214_4')::numeric + (cells_all->>'217_4')::numeric * (cells_all->>'218_4')::numeric) * ((cells_all->>'47_4')::numeric * (cells_all->>'48_4')::numeric));
	cells_all := cells_all || to_json_null('219_5'::text, ((cells_all->>'213_5')::numeric * (cells_all->>'214_5')::numeric + (cells_all->>'217_5')::numeric * (cells_all->>'218_5')::numeric) * ((cells_all->>'47_5')::numeric * (cells_all->>'48_5')::numeric));
	cells_all := cells_all || to_json_null('219_6'::text, ((cells_all->>'213_6')::numeric * (cells_all->>'214_6')::numeric + (cells_all->>'217_6')::numeric * (cells_all->>'218_6')::numeric) * ((cells_all->>'47_6')::numeric * (cells_all->>'48_6')::numeric));
	cells_all := cells_all || to_json_null('219_7'::text, ((cells_all->>'213_7')::numeric * (cells_all->>'214_7')::numeric + (cells_all->>'217_7')::numeric * (cells_all->>'218_7')::numeric) * ((cells_all->>'47_7')::numeric * (cells_all->>'48_7')::numeric));
	cells_all := cells_all || to_json_null('219_8'::text, ((cells_all->>'213_8')::numeric * (cells_all->>'214_8')::numeric + (cells_all->>'217_8')::numeric * (cells_all->>'218_8')::numeric) * ((cells_all->>'47_8')::numeric * (cells_all->>'48_8')::numeric));
	cells_all := cells_all || to_json_null('219_9'::text, ((cells_all->>'213_9')::numeric * (cells_all->>'214_9')::numeric + (cells_all->>'217_9')::numeric * (cells_all->>'218_9')::numeric) * ((cells_all->>'47_9')::numeric * (cells_all->>'48_9')::numeric));


-- 	C220	=C210+C219

    cells_all := cells_all || to_json_null('220_0'::text, (cells_all->>'210_0')::numeric + (cells_all->>'219_0')::numeric);
	cells_all := cells_all || to_json_null('220_1'::text, (cells_all->>'210_1')::numeric + (cells_all->>'219_1')::numeric);
	cells_all := cells_all || to_json_null('220_2'::text, (cells_all->>'210_2')::numeric + (cells_all->>'219_2')::numeric);
	cells_all := cells_all || to_json_null('220_3'::text, (cells_all->>'210_3')::numeric + (cells_all->>'219_3')::numeric);
	cells_all := cells_all || to_json_null('220_4'::text, (cells_all->>'210_4')::numeric + (cells_all->>'219_4')::numeric);
	cells_all := cells_all || to_json_null('220_5'::text, (cells_all->>'210_5')::numeric + (cells_all->>'219_5')::numeric);
	cells_all := cells_all || to_json_null('220_6'::text, (cells_all->>'210_6')::numeric + (cells_all->>'219_6')::numeric);
	cells_all := cells_all || to_json_null('220_7'::text, (cells_all->>'210_7')::numeric + (cells_all->>'219_7')::numeric);
	cells_all := cells_all || to_json_null('220_8'::text, (cells_all->>'210_8')::numeric + (cells_all->>'219_8')::numeric);
	cells_all := cells_all || to_json_null('220_9'::text, (cells_all->>'210_9')::numeric + (cells_all->>'219_9')::numeric);

-- 	C227	=IF(C4="BAU",C226,0)                              -- BAU = 3

	cells_all := cells_all || to_json_null('227_0'::text,case when (cells_all->>'4_0')::numeric = 3 then (cells_all->>'226_0')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_1'::text,case when (cells_all->>'4_1')::numeric = 3 then (cells_all->>'226_1')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_2'::text,case when (cells_all->>'4_2')::numeric = 3 then (cells_all->>'226_2')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_3'::text,case when (cells_all->>'4_3')::numeric = 3 then (cells_all->>'226_3')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_4'::text,case when (cells_all->>'4_4')::numeric = 3 then (cells_all->>'226_4')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_5'::text,case when (cells_all->>'4_5')::numeric = 3 then (cells_all->>'226_5')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_6'::text,case when (cells_all->>'4_6')::numeric = 3 then (cells_all->>'226_6')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_7'::text,case when (cells_all->>'4_7')::numeric = 3 then (cells_all->>'226_7')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_8'::text,case when (cells_all->>'4_8')::numeric = 3 then (cells_all->>'226_8')::numeric else 0 end);
	cells_all := cells_all || to_json_null('227_9'::text,case when (cells_all->>'4_9')::numeric = 3 then (cells_all->>'226_9')::numeric else 0 end);

-- 	C231 =IF(C4="BAU",C229*C230,0)	D231 =IF(D4="BAU",D229*D230,0)	E231 =E229*E230	F231 =F229*F230	G231 =G229*G230

	cells_all := cells_all || to_json_null('231_0'::text,case when (cells_all->>'4_0')::numeric = 3 then (cells_all->>'229_0')::numeric * (cells_all->>'230_0')::numeric else 0 end);
	cells_all := cells_all || to_json_null('231_1'::text,case when (cells_all->>'4_1')::numeric = 3 then (cells_all->>'229_1')::numeric * (cells_all->>'230_1')::numeric else 0 end);
    
	cells_all := cells_all || to_json_null('231_2'::text, (cells_all->>'229_2')::numeric * (cells_all->>'230_2')::numeric);
	cells_all := cells_all || to_json_null('231_3'::text, (cells_all->>'229_3')::numeric * (cells_all->>'230_3')::numeric);
	cells_all := cells_all || to_json_null('231_4'::text, (cells_all->>'229_4')::numeric * (cells_all->>'230_4')::numeric);
	cells_all := cells_all || to_json_null('231_5'::text, (cells_all->>'229_5')::numeric * (cells_all->>'230_5')::numeric);
	cells_all := cells_all || to_json_null('231_6'::text, (cells_all->>'229_6')::numeric * (cells_all->>'230_6')::numeric);
	cells_all := cells_all || to_json_null('231_7'::text, (cells_all->>'229_7')::numeric * (cells_all->>'230_7')::numeric);
	cells_all := cells_all || to_json_null('231_8'::text, (cells_all->>'229_8')::numeric * (cells_all->>'230_8')::numeric);
	cells_all := cells_all || to_json_null('231_9'::text, (cells_all->>'229_9')::numeric * (cells_all->>'230_9')::numeric);

-- 	C234	=C233*(C192+C206+C220+C224)

    cells_all := cells_all || to_json_null('234_0'::text, (cells_all->>'233_0')::numeric * ((cells_all->>'192_0')::numeric + (cells_all->>'206_0')::numeric + (cells_all->>'220_0')::numeric + (cells_all->>'224_0')::numeric));
	cells_all := cells_all || to_json_null('234_1'::text, (cells_all->>'233_1')::numeric * ((cells_all->>'192_1')::numeric + (cells_all->>'206_1')::numeric + (cells_all->>'220_1')::numeric + (cells_all->>'224_1')::numeric));
	cells_all := cells_all || to_json_null('234_2'::text, (cells_all->>'233_2')::numeric * ((cells_all->>'192_2')::numeric + (cells_all->>'206_2')::numeric + (cells_all->>'220_2')::numeric + (cells_all->>'224_2')::numeric));
	cells_all := cells_all || to_json_null('234_3'::text, (cells_all->>'233_3')::numeric * ((cells_all->>'192_3')::numeric + (cells_all->>'206_3')::numeric + (cells_all->>'220_3')::numeric + (cells_all->>'224_3')::numeric));
	cells_all := cells_all || to_json_null('234_4'::text, (cells_all->>'233_4')::numeric * ((cells_all->>'192_4')::numeric + (cells_all->>'206_4')::numeric + (cells_all->>'220_4')::numeric + (cells_all->>'224_4')::numeric));
	cells_all := cells_all || to_json_null('234_5'::text, (cells_all->>'233_5')::numeric * ((cells_all->>'192_5')::numeric + (cells_all->>'206_5')::numeric + (cells_all->>'220_5')::numeric + (cells_all->>'224_5')::numeric));
	cells_all := cells_all || to_json_null('234_6'::text, (cells_all->>'233_6')::numeric * ((cells_all->>'192_6')::numeric + (cells_all->>'206_6')::numeric + (cells_all->>'220_6')::numeric + (cells_all->>'224_6')::numeric));
	cells_all := cells_all || to_json_null('234_7'::text, (cells_all->>'233_7')::numeric * ((cells_all->>'192_7')::numeric + (cells_all->>'206_7')::numeric + (cells_all->>'220_7')::numeric + (cells_all->>'224_7')::numeric));
	cells_all := cells_all || to_json_null('234_8'::text, (cells_all->>'233_8')::numeric * ((cells_all->>'192_8')::numeric + (cells_all->>'206_8')::numeric + (cells_all->>'220_8')::numeric + (cells_all->>'224_8')::numeric));
	cells_all := cells_all || to_json_null('234_9'::text, (cells_all->>'233_9')::numeric * ((cells_all->>'192_9')::numeric + (cells_all->>'206_9')::numeric + (cells_all->>'220_9')::numeric + (cells_all->>'224_9')::numeric));

-- 	C235	=C192+C206+C220+C224+C227+C231+C234

    cells_all := cells_all || to_json_null('235_0'::text, (cells_all->>'192_0')::numeric + (cells_all->>'206_0')::numeric + (cells_all->>'220_0')::numeric + (cells_all->>'224_0')::numeric + (cells_all->>'227_0')::numeric + (cells_all->>'231_0')::numeric + (cells_all->>'234_0')::numeric);
	cells_all := cells_all || to_json_null('235_1'::text, (cells_all->>'192_1')::numeric + (cells_all->>'206_1')::numeric + (cells_all->>'220_1')::numeric + (cells_all->>'224_1')::numeric + (cells_all->>'227_1')::numeric + (cells_all->>'231_1')::numeric + (cells_all->>'234_1')::numeric);
	cells_all := cells_all || to_json_null('235_2'::text, (cells_all->>'192_2')::numeric + (cells_all->>'206_2')::numeric + (cells_all->>'220_2')::numeric + (cells_all->>'224_2')::numeric + (cells_all->>'227_2')::numeric + (cells_all->>'231_2')::numeric + (cells_all->>'234_2')::numeric);
	cells_all := cells_all || to_json_null('235_3'::text, (cells_all->>'192_3')::numeric + (cells_all->>'206_3')::numeric + (cells_all->>'220_3')::numeric + (cells_all->>'224_3')::numeric + (cells_all->>'227_3')::numeric + (cells_all->>'231_3')::numeric + (cells_all->>'234_3')::numeric);
	cells_all := cells_all || to_json_null('235_4'::text, (cells_all->>'192_4')::numeric + (cells_all->>'206_4')::numeric + (cells_all->>'220_4')::numeric + (cells_all->>'224_4')::numeric + (cells_all->>'227_4')::numeric + (cells_all->>'231_4')::numeric + (cells_all->>'234_4')::numeric);
	cells_all := cells_all || to_json_null('235_5'::text, (cells_all->>'192_5')::numeric + (cells_all->>'206_5')::numeric + (cells_all->>'220_5')::numeric + (cells_all->>'224_5')::numeric + (cells_all->>'227_5')::numeric + (cells_all->>'231_5')::numeric + (cells_all->>'234_5')::numeric);
	cells_all := cells_all || to_json_null('235_6'::text, (cells_all->>'192_6')::numeric + (cells_all->>'206_6')::numeric + (cells_all->>'220_6')::numeric + (cells_all->>'224_6')::numeric + (cells_all->>'227_6')::numeric + (cells_all->>'231_6')::numeric + (cells_all->>'234_6')::numeric);
	cells_all := cells_all || to_json_null('235_7'::text, (cells_all->>'192_7')::numeric + (cells_all->>'206_7')::numeric + (cells_all->>'220_7')::numeric + (cells_all->>'224_7')::numeric + (cells_all->>'227_7')::numeric + (cells_all->>'231_7')::numeric + (cells_all->>'234_7')::numeric);
	cells_all := cells_all || to_json_null('235_8'::text, (cells_all->>'192_8')::numeric + (cells_all->>'206_8')::numeric + (cells_all->>'220_8')::numeric + (cells_all->>'224_8')::numeric + (cells_all->>'227_8')::numeric + (cells_all->>'231_8')::numeric + (cells_all->>'234_8')::numeric);
	cells_all := cells_all || to_json_null('235_9'::text, (cells_all->>'192_9')::numeric + (cells_all->>'206_9')::numeric + (cells_all->>'220_9')::numeric + (cells_all->>'224_9')::numeric + (cells_all->>'227_9')::numeric + (cells_all->>'231_9')::numeric + (cells_all->>'234_9')::numeric);

-- 	C242	=C241

	cells_all := cells_all || to_json_null('242_0'::text, (cells_all->>'241_0')::numeric);
	cells_all := cells_all || to_json_null('242_1'::text, (cells_all->>'241_1')::numeric);
	cells_all := cells_all || to_json_null('242_2'::text, (cells_all->>'241_2')::numeric);
	cells_all := cells_all || to_json_null('242_3'::text, (cells_all->>'241_3')::numeric);
	cells_all := cells_all || to_json_null('242_4'::text, (cells_all->>'241_4')::numeric);
	cells_all := cells_all || to_json_null('242_5'::text, (cells_all->>'241_5')::numeric);
	cells_all := cells_all || to_json_null('242_6'::text, (cells_all->>'241_6')::numeric);
	cells_all := cells_all || to_json_null('242_7'::text, (cells_all->>'241_7')::numeric);
	cells_all := cells_all || to_json_null('242_8'::text, (cells_all->>'241_8')::numeric);
	cells_all := cells_all || to_json_null('242_9'::text, (cells_all->>'241_9')::numeric);

-- 	C246	=C87

	cells_all := cells_all || to_json_null('246_0'::text, (cells_all->>'87_0')::numeric);
	cells_all := cells_all || to_json_null('246_1'::text, (cells_all->>'87_1')::numeric);

-- 	C247	=C114

	cells_all := cells_all || to_json_null('247_0'::text, (cells_all->>'114_0')::numeric);
	cells_all := cells_all || to_json_null('247_1'::text, (cells_all->>'114_1')::numeric);
	

-- 	C248	=C246+C247

    cells_all := cells_all || to_json_null('248_0'::text, (cells_all->>'246_0')::numeric + (cells_all->>'247_0')::numeric);
	cells_all := cells_all || to_json_null('248_1'::text, (cells_all->>'246_1')::numeric + (cells_all->>'247_1')::numeric);

-- 	C250	=C137

	cells_all := cells_all || to_json_null('250_0'::text, (cells_all->>'137_0')::numeric);
	cells_all := cells_all || to_json_null('250_1'::text, (cells_all->>'137_1')::numeric);
	cells_all := cells_all || to_json_null('250_2'::text, (cells_all->>'137_2')::numeric);
	cells_all := cells_all || to_json_null('250_3'::text, (cells_all->>'137_3')::numeric);
	cells_all := cells_all || to_json_null('250_4'::text, (cells_all->>'137_4')::numeric);
	cells_all := cells_all || to_json_null('250_5'::text, (cells_all->>'137_5')::numeric);
	cells_all := cells_all || to_json_null('250_6'::text, (cells_all->>'137_6')::numeric);
	cells_all := cells_all || to_json_null('250_7'::text, (cells_all->>'137_7')::numeric);
	cells_all := cells_all || to_json_null('250_8'::text, (cells_all->>'137_8')::numeric);
	cells_all := cells_all || to_json_null('250_9'::text, (cells_all->>'137_9')::numeric);
    
-- 	C251	=C176

	cells_all := cells_all || to_json_null('251_0'::text, (cells_all->>'176_0')::numeric);
	cells_all := cells_all || to_json_null('251_1'::text, (cells_all->>'176_1')::numeric);
	cells_all := cells_all || to_json_null('251_2'::text, (cells_all->>'176_2')::numeric);
	cells_all := cells_all || to_json_null('251_3'::text, (cells_all->>'176_3')::numeric);
	cells_all := cells_all || to_json_null('251_4'::text, (cells_all->>'176_4')::numeric);
	cells_all := cells_all || to_json_null('251_5'::text, (cells_all->>'176_5')::numeric);
	cells_all := cells_all || to_json_null('251_6'::text, (cells_all->>'176_6')::numeric);
	cells_all := cells_all || to_json_null('251_7'::text, (cells_all->>'176_7')::numeric);
	cells_all := cells_all || to_json_null('251_8'::text, (cells_all->>'176_8')::numeric);
	cells_all := cells_all || to_json_null('251_9'::text, (cells_all->>'176_9')::numeric);

-- 	C252	=C235

	cells_all := cells_all || to_json_null('252_0'::text, (cells_all->>'235_0')::numeric);
	cells_all := cells_all || to_json_null('252_1'::text, (cells_all->>'235_1')::numeric);
	cells_all := cells_all || to_json_null('252_2'::text, (cells_all->>'235_2')::numeric);
	cells_all := cells_all || to_json_null('252_3'::text, (cells_all->>'235_3')::numeric);
	cells_all := cells_all || to_json_null('252_4'::text, (cells_all->>'235_4')::numeric);
	cells_all := cells_all || to_json_null('252_5'::text, (cells_all->>'235_5')::numeric);
	cells_all := cells_all || to_json_null('252_6'::text, (cells_all->>'235_6')::numeric);
	cells_all := cells_all || to_json_null('252_7'::text, (cells_all->>'235_7')::numeric);
	cells_all := cells_all || to_json_null('252_8'::text, (cells_all->>'235_8')::numeric);
	cells_all := cells_all || to_json_null('252_9'::text, (cells_all->>'235_9')::numeric);

-- 	C253	=C242

	cells_all := cells_all || to_json_null('253_0'::text, (cells_all->>'242_0')::numeric);
	cells_all := cells_all || to_json_null('253_1'::text, (cells_all->>'242_1')::numeric);
	cells_all := cells_all || to_json_null('253_2'::text, (cells_all->>'242_2')::numeric);
	cells_all := cells_all || to_json_null('253_3'::text, (cells_all->>'242_3')::numeric);
	cells_all := cells_all || to_json_null('253_4'::text, (cells_all->>'242_4')::numeric);
	cells_all := cells_all || to_json_null('253_5'::text, (cells_all->>'242_5')::numeric);
	cells_all := cells_all || to_json_null('253_6'::text, (cells_all->>'242_6')::numeric);
	cells_all := cells_all || to_json_null('253_7'::text, (cells_all->>'242_7')::numeric);
	cells_all := cells_all || to_json_null('253_8'::text, (cells_all->>'242_8')::numeric);
	cells_all := cells_all || to_json_null('253_9'::text, (cells_all->>'242_9')::numeric);

-- 	C254	=SUM(C250:C253)

    cells_all := cells_all || to_json_null('254_0'::text, (cells_all->>'250_0')::numeric + (cells_all->>'251_0')::numeric + (cells_all->>'252_0')::numeric + (cells_all->>'253_0')::numeric);
	cells_all := cells_all || to_json_null('254_1'::text, (cells_all->>'250_1')::numeric + (cells_all->>'251_1')::numeric + (cells_all->>'252_1')::numeric + (cells_all->>'253_1')::numeric);
	cells_all := cells_all || to_json_null('254_2'::text, (cells_all->>'250_2')::numeric + (cells_all->>'251_2')::numeric + (cells_all->>'252_2')::numeric + (cells_all->>'253_2')::numeric);
	cells_all := cells_all || to_json_null('254_3'::text, (cells_all->>'250_3')::numeric + (cells_all->>'251_3')::numeric + (cells_all->>'252_3')::numeric + (cells_all->>'253_3')::numeric);
	cells_all := cells_all || to_json_null('254_4'::text, (cells_all->>'250_4')::numeric + (cells_all->>'251_4')::numeric + (cells_all->>'252_4')::numeric + (cells_all->>'253_4')::numeric);
	cells_all := cells_all || to_json_null('254_5'::text, (cells_all->>'250_5')::numeric + (cells_all->>'251_5')::numeric + (cells_all->>'252_5')::numeric + (cells_all->>'253_5')::numeric);
	cells_all := cells_all || to_json_null('254_6'::text, (cells_all->>'250_6')::numeric + (cells_all->>'251_6')::numeric + (cells_all->>'252_6')::numeric + (cells_all->>'253_6')::numeric);
	cells_all := cells_all || to_json_null('254_7'::text, (cells_all->>'250_7')::numeric + (cells_all->>'251_7')::numeric + (cells_all->>'252_7')::numeric + (cells_all->>'253_7')::numeric);
	cells_all := cells_all || to_json_null('254_8'::text, (cells_all->>'250_8')::numeric + (cells_all->>'251_8')::numeric + (cells_all->>'252_8')::numeric + (cells_all->>'253_8')::numeric);
	cells_all := cells_all || to_json_null('254_9'::text, (cells_all->>'250_9')::numeric + (cells_all->>'251_9')::numeric + (cells_all->>'252_9')::numeric + (cells_all->>'253_9')::numeric);


-- 	C256	=C248+C254

    cells_all := cells_all || to_json_null('256_0'::text, (cells_all->>'248_0')::numeric + (cells_all->>'254_0')::numeric);
	cells_all := cells_all || to_json_null('256_1'::text, (cells_all->>'248_1')::numeric + (cells_all->>'254_1')::numeric);
	cells_all := cells_all || to_json_null('256_2'::text, (cells_all->>'248_2')::numeric + (cells_all->>'254_2')::numeric);
	cells_all := cells_all || to_json_null('256_3'::text, (cells_all->>'248_3')::numeric + (cells_all->>'254_3')::numeric);
	cells_all := cells_all || to_json_null('256_4'::text, (cells_all->>'248_4')::numeric + (cells_all->>'254_4')::numeric);
	cells_all := cells_all || to_json_null('256_5'::text, (cells_all->>'248_5')::numeric + (cells_all->>'254_5')::numeric);
	cells_all := cells_all || to_json_null('256_6'::text, (cells_all->>'248_6')::numeric + (cells_all->>'254_6')::numeric);
	cells_all := cells_all || to_json_null('256_7'::text, (cells_all->>'248_7')::numeric + (cells_all->>'254_7')::numeric);
	cells_all := cells_all || to_json_null('256_8'::text, (cells_all->>'248_8')::numeric + (cells_all->>'254_8')::numeric);
	cells_all := cells_all || to_json_null('256_9'::text, (cells_all->>'248_9')::numeric + (cells_all->>'254_9')::numeric);

-- 	C259	=SUM(C256:L256)

    cells_all := cells_all || to_json_null('259_0'::text, (cells_all->>'256_0')::numeric + (cells_all->>'256_1')::numeric + (cells_all->>'256_2')::numeric + (cells_all->>'256_3')::numeric
                     + (cells_all->>'256_4')::numeric + (cells_all->>'256_5')::numeric + (cells_all->>'256_6')::numeric + (cells_all->>'256_7')::numeric
                     + (cells_all->>'256_8')::numeric + (cells_all->>'256_9')::numeric);
                    
-- 	C260	='National Data'!B9

-- 	C263	=PV($C$260,C$262,0,C256)*-1
-- pv(rate, nper, fv)

    cells_all := cells_all || to_json_null('263_0'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_0')::numeric, (cells_all->>'256_0')::numeric));
    cells_all := cells_all || to_json_null('263_1'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_1')::numeric, (cells_all->>'256_1')::numeric));
    cells_all := cells_all || to_json_null('263_2'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_2')::numeric, (cells_all->>'256_2')::numeric));
    cells_all := cells_all || to_json_null('263_3'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_3')::numeric, (cells_all->>'256_3')::numeric));
    cells_all := cells_all || to_json_null('263_4'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_4')::numeric, (cells_all->>'256_4')::numeric));
    cells_all := cells_all || to_json_null('263_5'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_5')::numeric, (cells_all->>'256_5')::numeric));
    cells_all := cells_all || to_json_null('263_6'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_6')::numeric, (cells_all->>'256_6')::numeric));
    cells_all := cells_all || to_json_null('263_7'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_7')::numeric, (cells_all->>'256_7')::numeric));
    cells_all := cells_all || to_json_null('263_8'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_8')::numeric, (cells_all->>'256_8')::numeric));
    cells_all := cells_all || to_json_null('263_9'::text, pv((cells_all->>'260_0')::numeric, (cells_all->>'262_9')::numeric, (cells_all->>'256_9')::numeric));


-- 	C265	=SUM(C263:L263)

    cells_all := cells_all || to_json_null('265_0'::text, (cells_all->>'263_0')::numeric + (cells_all->>'263_1')::numeric + (cells_all->>'263_2')::numeric + (cells_all->>'263_3')::numeric
                     + (cells_all->>'263_4')::numeric + (cells_all->>'263_5')::numeric + (cells_all->>'263_6')::numeric + (cells_all->>'263_7')::numeric
                     + (cells_all->>'263_8')::numeric + (cells_all->>'263_9')::numeric);

-- Raise Notice'2.cells_all: %',cells_all;

-- 259, 263, 265

delete from intervention_data_json
where intervention_id = int_id;

insert into intervention_data_json
(intervention_id, intervention_data)
values
(int_id, cells_all);	

end;

$$ LANGUAGE plpgsql;

-- select update_intervention_data_totals(1);

