
-- drop function update_intervention_data_totals;

CREATE or replace function update_intervention_data_totals(int_id integer) returns void

AS $$

declare 

cells_all jsonb;

test1 integer;

begin
	
cells_all := get_intervention_data_as_json(int_id);

-- Raise Notice'1.cells_all: %',cells_all->>'4_0';

-- formulae for intervention_id = 1
	
-- 	C31	=ROUNDUP(C27*C30, 0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('31_' || i::text,round((cells_all->>('27_' || i)::text)::numeric * (cells_all->>('30_' || i)::text)::numeric));
    
    end loop;


-- 	C33	=IF(OR(C13>0,C14>0),3,0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('33_' || i::text, case when (cells_all->>('13_' || i)::text)::numeric > 0 or (cells_all->>('14_' || i)::text)::numeric > 0 then 3 else 0 end);
    
    end loop;

-- 	C34	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('34_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or
        (cells_all->>('8_' || i)::text)::numeric > 0 or
        (cells_all->>('9_' || i)::text)::numeric > 0
      	then 3 else 0 end);
    
    end loop;  
 
-- 	C37	=1-C36

 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('37_' || i::text, 1 - (cells_all->>('36_' || i)::text)::numeric);
    
    end loop;

-- 	C40	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))

 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('40_' || i::text, 
		case when (cells_all->>('27_' || i)::text)::numeric = 0 then 1
			when (cells_all->>('27_' || i)::text)::numeric > 0 and (cells_all->>('27_' || i)::text)::numeric < 0.25 then 1 
			when (cells_all->>('27_' || i)::text)::numeric >= 0.25 and (cells_all->>('27_' || i)::text)::numeric < 0.5 then 2
			when (cells_all->>('27_' || i)::text)::numeric >= 0.5 and (cells_all->>('27_' || i)::text)::numeric < 0.75 then 3
					else 4 end
        );
    
    end loop;
   
   
	

-- 	C41	=IF(OR(C13>0, C14>0),3,0)


 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('41_' || i::text, case when (cells_all->>('13_' || i)::text)::numeric > 0 or (cells_all->>('14_' || i)::text)::numeric > 0 then 3 else 0 end);
    
    end loop;

-- 	C42	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),3,0)

 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('42_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or 
        (cells_all->>('8_' || i)::text)::numeric > 0 or 
        (cells_all->>('9_' || i)::text)::numeric > 0 then 3 else 0 end);
    
    end loop;

-- 	C44	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),6,IF(AND(C$27>=0.25,C$27<0.5),12,IF(AND(C$27>=0.5,C$27<0.75),18,24))))

 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('44_' || i::text, case when (cells_all->>'27_0')::numeric = 0 then 0
					when (cells_all->>('27_' || i)::text)::numeric > 0 and (cells_all->>('27_' || i)::text)::numeric < 0.25 then 6 
					when (cells_all->>('27_' || i)::text)::numeric >= 0.25 and (cells_all->>('27_' || i)::text)::numeric < 0.5 then 12
					when (cells_all->>('27_' || i)::text)::numeric >= 0.5 and (cells_all->>('27_' || i)::text)::numeric < 0.75 then 18
					else 24 end);
    
    end loop;

-- 	C45	=IF(OR(C13>0,C14>0),2,0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('45_' || i::text, case when (cells_all->>('13_' || i)::text)::numeric > 0 or (cells_all->>('14_' || i)::text)::numeric > 0 then 2 else 0 end );
    
    end loop;


-- 	C46	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),2,0)

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('46_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or 
        (cells_all->>('8_' || i)::text)::numeric > 0 or 
        (cells_all->>('9_' || i)::text)::numeric > 0 then 2 else 0 end );
    
    end loop;
    
-- 	C48	=IF(C$27=0,0,IF(AND(C$27>0,C$27<0.25),1,IF(AND(C$27>=0.25,C$27<0.5),2,IF(AND(C$27>=0.5,C$27<0.75),3,4))))

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('48_' || i::text, case when (cells_all->>'27_0')::numeric = 0 then 1 					
                    when (cells_all->>('27_' || i)::text)::numeric > 0 
                     and (cells_all->>('27_' || i)::text)::numeric < 0.25 then 1 					
                    when (cells_all->>('27_' || i)::text)::numeric >= 0.25 
                     and (cells_all->>('27_' || i)::text)::numeric < 0.5 then 2 					
                    when (cells_all->>('27_' || i)::text)::numeric >= 0.5 
                     and (cells_all->>('27_' || i)::text)::numeric < 0.75 then 3 					
                    else 4 end );
    
    end loop;

-- 	C49	=IF(OR(C13>0,C14>0),5,0)

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('49_' || i::text, case when 
        (cells_all->>('13_' || i)::text)::numeric > 0 or 
        (cells_all->>('14_' || i)::text)::numeric > 0 then 5 else 0 end );
    
    end loop;

-- 	C50	=IF(OR(C6>0,C7>0,C8>0,C8>0,C9>0),5,0)

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('50_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or 
        (cells_all->>('8_' || i)::text)::numeric > 0 or 
        (cells_all->>('9_' || i)::text)::numeric > 0 then 5 else 0 end );
    
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

   cells_all := cells_all || to_json_null('56_1'::text, (cells_all->>'54_1')::numeric * (cells_all->>'55_1')::numeric);

-- D57 =500*'GDP Deflators'!$H$38
-- D58 =200*'GDP Deflators'!$H$38
-- D59 =850*'GDP Deflators'!$H$38

-- D61 =SUM(D57:D59)*D60

   cells_all := cells_all || to_json_null('61_1'::text, 
  ((cells_all->>'57_1')::numeric + 
 (cells_all->>'57_1')::numeric + 
(cells_all->>'59_1')::numeric) * 
(cells_all->>'60_1')::numeric );

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

-- 	C114 =C95+C106+C109+C113	D114 =D95+D106+D109+D113

	cells_all := cells_all || to_json_null('114_0'::text,
(cells_all->>'95_0')::numeric + 
(cells_all->>'106_0')::numeric + 
(cells_all->>'109_0')::numeric + 
(cells_all->>'113_0')::numeric);

	cells_all := cells_all || to_json_null('114_1'::text,
(cells_all->>'95_1')::numeric + 
(cells_all->>'106_1')::numeric + 
(cells_all->>'109_1')::numeric + 
(cells_all->>'113_1')::numeric);
	
-- 	C118	='Premix - wheat flour'!I35
-- 	C120	='National Data'!B17                    TODO
-- 	C121	='National Data'!B12

-- 	C123	=C118*(1+C119+C120+C121)+C122

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('123_' || i::text,
      		(cells_all->>('118_' || i)::text)::numeric * 
      ( 1 + (cells_all->>('119_' || i)::text)::numeric + 
            (cells_all->>('120_' || i)::text)::numeric + 
            (cells_all->>('121_' || i)::text)::numeric) + 
            (cells_all->>('122_' || i)::text)::numeric);
    
    end loop;


-- 	C125	=C26
-- 	C126	=Demographics!D3

-- 	C127	=((C124*C125*C126)*365)/1000000

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('127_' || i::text,((cells_all->>('124_' || i)::text)::numeric * (cells_all->>('125_' || i)::text)::numeric * (cells_all->>('126_' || i)::text)::numeric * 365) / 1000000);
    
    end loop;


-- 	C128	=C36

-- 	C129	=IF(C128=0,0,C27)

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('129_' || i::text,case when (cells_all->>('128_' || i)::text)::numeric = 0 then 0 else (cells_all->>('27_' || i)::text)::numeric end);
        
    end loop;


-- 	C130	=C127*C129*C128

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('130_' || i::text,(cells_all->>('127_' || i)::text)::numeric * (cells_all->>('129_' || i)::text)::numeric * (cells_all->>('128_' || i)::text)::numeric);
        
    end loop;
 

-- 	C131	=C123*C130

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('131_' || i::text,(cells_all->>('127_' || i)::text)::numeric * (cells_all->>('129_' || i)::text)::numeric * (cells_all->>('128_' || i)::text)::numeric * (cells_all->>('123_' || i)::text)::numeric);
        
    end loop;

-- 	C132	=C37

-- 	C133	=IF(C132=0,0,C27)

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('133_' || i::text,case when (cells_all->>('132_' || i)::text)::numeric = 0 then 0 else (cells_all->>('27_' || i)::text)::numeric end);
        
    end loop;

	
-- 	C134	=C127*C132*C133

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('134_' || i::text,(cells_all->>('127_' || i)::text)::numeric * (cells_all->>('132_' || i)::text)::numeric * (cells_all->>('133_' || i)::text)::numeric);
        
    end loop;

-- 	C135	=C123*C134

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('135_' || i::text,(cells_all->>('123_' || i)::text)::numeric * (cells_all->>('127_' || i)::text)::numeric * (cells_all->>('132_' || i)::text)::numeric * (cells_all->>('133_' || i)::text)::numeric);
        
    end loop;

-- 	C136	=C131+C135

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('136_' || i::text,(cells_all->>('131_' || i)::text)::numeric + ((cells_all->>('123_' || i)::text)::numeric * 
       (cells_all->>('127_' || i)::text)::numeric * (cells_all->>('132_' || i)::text)::numeric * (cells_all->>('133_' || i)::text)::numeric));
        
    end loop;

-- 	C137	=C136

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('137_' || i::text,(cells_all->>('136_' || i)::text)::numeric);
        
    end loop;
    
-- 	C142	='National Data'!B6*2

-- 	C143	=C31*C142*C141

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('143_' || i::text,(cells_all->>('31_' || i)::text)::numeric * (cells_all->>('142_' || i)::text)::numeric * (cells_all->>('141_' || i)::text)::numeric);
        
    end loop;

-- 	C145	=C31*C144*($D$54)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('145_' || i::text,(cells_all->>('31_' || i)::text)::numeric * (cells_all->>('144_' || i)::text)::numeric * (cells_all->>'54_1')::numeric);
        
    end loop;


-- 	C146	=C143+C145

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('146_' || i::text,(cells_all->>('143_' || i)::text)::numeric + (cells_all->>('145_' || i)::text)::numeric);
        
    end loop;

-- 	C148	=816.62/100
-- 	C150	='National Data'!B16
-- 	C151	='National Data'!B11

-- 	C152	=C148*(1+C149+C150+C151)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('152_' || i::text, (cells_all->>('148_' || i)::text)::numeric * (1 + (cells_all->>('149_' || i)::text)::numeric + (cells_all->>('150_' || i)::text)::numeric + (cells_all->>('151_' || i)::text)::numeric));
        
    end loop;

-- 	C153	=C33

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('153_' || i::text, (cells_all->>('33_' || i)::text)::numeric);
        
    end loop;

-- 	C154	=673.19/100
-- 	C156	='National Data'!B16
-- 	C157	='National Data'!B11

-- 	C158	=C154*(1+C155+C156+C157)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('158_' || i::text, 
     (cells_all->>('154_' || i)::text)::numeric * 
    (1 + (cells_all->>('155_' || i)::text)::numeric + 
   (cells_all->>('156_' || i)::text)::numeric + 
  (cells_all->>('157_' || i)::text)::numeric));
        
    end loop;

-- 	C159	=C34

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('159_' || i::text, (cells_all->>('34_' || i)::text)::numeric);
        
    end loop;

-- 	C160	=(C152*C153+C158*C159)*C31*C32

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('160_' || i::text, 
      ((cells_all->>('152_' || i)::text)::numeric * 
      (cells_all->>('153_' || i)::text)::numeric + 
      (cells_all->>('158_' || i)::text)::numeric * 
      (cells_all->>('159_' || i)::text)::numeric) * 
      (cells_all->>('31_' || i)::text)::numeric * 
      (cells_all->>('32_' || i)::text)::numeric);
	
    end loop;

-- 	C162	='National Data'!B6*2.5

-- 	C163	=C161*C162*C31

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('163_' || i::text,(cells_all->>('161_' || i)::text)::numeric * (cells_all->>('162_' || i)::text)::numeric * (cells_all->>('31_' || i)::text)::numeric);
        
    end loop;

-- 	C164	=C160+C163

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('164_' || i::text, (cells_all->>('160_' || i)::text)::numeric + (cells_all->>('163_' || i)::text)::numeric);
        
    end loop;

-- 	C166	=50*'GDP Deflators'!$G$38

-- 	C168	=C166*C167*C31

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('168_' || i::text,(cells_all->>('166_' || i)::text)::numeric * (cells_all->>('167_' || i)::text)::numeric * (cells_all->>('31_' || i)::text)::numeric);
        
    end loop;

-- 	C170	=200*'GDP Deflators'!F38

-- 	C172	=C170*C171*C31

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('172_' || i::text,(cells_all->>('170_' || i)::text)::numeric * (cells_all->>('171_' || i)::text)::numeric * (cells_all->>('31_' || i)::text)::numeric);
        
    end loop;

-- 	C175	=C174*(C146+C164+C168+C172)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('175_' || i::text, (cells_all->>('174_' || i)::text)::numeric * 
      ((cells_all->>('146_' || i)::text)::numeric + (cells_all->>('164_' || i)::text)::numeric + (cells_all->>('168_' || i)::text)::numeric + (cells_all->>('172_' || i)::text)::numeric));
	  
    end loop;

-- 	C176	=C146+C164+C168+C172+C175

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('176_' || i::text, (cells_all->>('146_' || i)::text)::numeric +
      (cells_all->>('164_' || i)::text)::numeric + (cells_all->>('168_' || i)::text)::numeric + (cells_all->>('172_' || i)::text)::numeric + (cells_all->>('175_' || i)::text)::numeric);
	  
    end loop;

-- 	C180	=130*'GDP Deflators'!$G$38

-- 	C181	=C30*C40

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('181_' || i::text,(cells_all->>('30_' || i)::text)::numeric * (cells_all->>('40_' || i)::text)::numeric);
	  
    end loop;

-- 	C182	=C180*C181

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('182_' || i::text,(cells_all->>('180_' || i)::text)::numeric * (cells_all->>('181_' || i)::text)::numeric);
	
    end loop;

-- 	C183	=816.62/100

-- 	C185	=C183*(1+C184)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('185_' || i::text, (cells_all->>('183_' || i)::text)::numeric * (1 + (cells_all->>('184_' || i)::text)::numeric));
	
    end loop;

-- 	C186	=C41

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('186_' || i::text, (cells_all->>('41_' || i)::text)::numeric);
	
    end loop;

-- 	C187	=673.19/100

-- 	C189	=C187*(1+C188)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('189_' || i::text, (cells_all->>('187_' || i)::text)::numeric * (1 + (cells_all->>('188_' || i)::text)::numeric));
	
    end loop;

-- 	C190	=C42

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('190_' || i::text, (cells_all->>('42_' || i)::text)::numeric);
	
    end loop;

-- 	C191	=(C185*C186+C189*C190)*C30*C40

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('191_' || i::text, ((cells_all->>('185_' || i)::text)::numeric *
      (cells_all->>('186_' || i)::text)::numeric + (cells_all->>('189_' || i)::text)::numeric * (cells_all->>('190_' || i)::text)::numeric) * (cells_all->>('30_' || i)::text)::numeric * (cells_all->>('40_' || i)::text)::numeric);
	
    end loop;

-- 	C192	=C182+C191

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('192_' || i::text, (cells_all->>('182_' || i)::text)::numeric + (cells_all->>('191_' || i)::text)::numeric);
	
    end loop;

-- 	C195	='National Data'!B6*2.5

-- 	C196	=C194*C43*C195

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('196_' || i::text,
     (cells_all->>('194_' || i)::text)::numeric * 
     (cells_all->>('43_' || i)::text)::numeric * 
     (cells_all->>('195_' || i)::text)::numeric);
	
    end loop;

-- 	C197	=816.62/100

-- 	C199	=C197*(1+C198)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('199_' || i::text, (cells_all->>('197_' || i)::text)::numeric * (1 + (cells_all->>('198_' || i)::text)::numeric));
	
    end loop;

-- 	C200	=C45

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('200_' || i::text, (cells_all->>('45_' || i)::text)::numeric);
	
    end loop;

-- 	C201	=673.19/100

-- 	C203	=C201*(1+C202)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('203_' || i::text, (cells_all->>('201_' || i)::text)::numeric * (1 + (cells_all->>('202_' || i)::text)::numeric));
	
    end loop;

-- 	C204	=C46

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('204_' || i::text, (cells_all->>('46_' || i)::text)::numeric);
	
    end loop;

-- 	C205	=(C199*C200+C203*C204)*C43*C44

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('205_' || i::text, ((cells_all->>('199_' || i)::text)::numeric *
      (cells_all->>('200_' || i)::text)::numeric + (cells_all->>('203_' || i)::text)::numeric * (cells_all->>('204_' || i)::text)::numeric) * (cells_all->>('43_' || i)::text)::numeric * (cells_all->>('44_' || i)::text)::numeric);
	
    end loop;

-- 	C206	=C196+C205

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('206_' || i::text, (cells_all->>('196_' || i)::text)::numeric + (cells_all->>('205_' || i)::text)::numeric);
	
    end loop;

-- 	C209	='National Data'!B6*2.5

-- 	C210	=C208*C209

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('210_' || i::text, (cells_all->>('208_' || i)::text)::numeric * (cells_all->>('209_' || i)::text)::numeric);
	
    end loop;

-- 	C211	=816.62/100

-- 	C213	=C211*(1+C212)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('213_' || i::text, (cells_all->>('211_' || i)::text)::numeric * (1 + (cells_all->>('212_' || i)::text)::numeric));
	
    end loop;

-- 	C214	=C49

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('214_' || i::text, (cells_all->>('49_' || i)::text)::numeric);
	
    end loop;

-- 	C215	=673.19/100

-- 	C217	=C215*(1+C216)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('217_' || i::text, (cells_all->>('215_' || i)::text)::numeric * (1 + (cells_all->>('216_' || i)::text)::numeric));
	
    end loop;

-- 	C218	=C50

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('218_' || i::text, (cells_all->>('50_' || i)::text)::numeric);
	
    end loop;

-- 	C219	=(C213*C214+C217*C218)*(C47*C48)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('219_' || i::text, 
      ((cells_all->>('213_' || i)::text)::numeric *
      (cells_all->>('214_' || i)::text)::numeric + 
      (cells_all->>('217_' || i)::text)::numeric * (cells_all->>('218_' || i)::text)::numeric) * ((cells_all->>('47_' || i)::text)::numeric * (cells_all->>('48_' || i)::text)::numeric));
	
    end loop;

-- 	C220	=C210+C219

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('220_' || i::text, (cells_all->>('210_' || i)::text)::numeric + (cells_all->>('219_' || i)::text)::numeric);
	
    end loop;

-- 	C227 =IF(C4="BAU",C226,0)	D227 =IF(C4="BAU",D226,0)	E227 =E226	F227 =F226	G227 =G226                              -- BAU = 3

    for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('227_' || i::text,
     case when (cells_all->>'4_0')::numeric = 3 then (cells_all->>('226_' || i)::text)::numeric else 0 end);
	
    end loop;
   
    for i in 2 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('227_' || i::text, (cells_all->>('226_' || i)::text)::numeric);
	
    end loop;
   
-- 	C231 =IF(C4="BAU",C229*C230,0)	D231 =IF(D4="BAU",D229*D230,0)	E231 =E229*E230	F231 =F229*F230	G231 =G229*G230

    for i in 0 .. 1 loop -- ' || i
    
        cells_all := cells_all || to_json_null('231_' || i::text,case when (cells_all->>('4_' || i)::text)::numeric = 3 then (cells_all->>('229_' || i)::text)::numeric * (cells_all->>('230_' || i)::text)::numeric else 0 end);

    end loop;
    
    for i in 2 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('231_' || i::text, (cells_all->>('229_' || i)::text)::numeric * (cells_all->>('230_' || i)::text)::numeric);
	
    end loop;  

-- 	C234	=C233*(C192+C206+C220+C224)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('234_' || i::text, 
      (cells_all->>('233_' || i)::text)::numeric * 
      ((cells_all->>('192_' || i)::text)::numeric + 
      (cells_all->>('206_' || i)::text)::numeric + 
      (cells_all->>('220_' || i)::text)::numeric + 
      (cells_all->>('224_' || i)::text)::numeric));
	
    end loop;

-- 	C235	=C192+C206+C220+C224+C227+C231+C234

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('235_' || i::text, 
      (cells_all->>('192_' || i)::text)::numeric +
      (cells_all->>('206_' || i)::text)::numeric +
      (cells_all->>('220_' || i)::text)::numeric +
      (cells_all->>('224_' || i)::text)::numeric +
      (cells_all->>('227_' || i)::text)::numeric +
      (cells_all->>('231_' || i)::text)::numeric +
      (cells_all->>('234_' || i)::text)::numeric);
	
    end loop;

-- 	C242	=C241

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('242_' || i::text, (cells_all->>('241_' || i)::text)::numeric);
	
    end loop;

-- 	C246	=C87

    for i in 0 .. 2 loop -- ' || i
    
      cells_all := cells_all || to_json_null('246_' || i::text, (cells_all->>('87_' || i)::text)::numeric);
	
    end loop;

-- 	C247	=C114

    for i in 0 .. 2 loop -- ' || i
    
      cells_all := cells_all || to_json_null('247_' || i::text, (cells_all->>('114_' || i)::text)::numeric);
	
    end loop;
	

-- 	C248	=C246+C247

    for i in 0 .. 2 loop -- ' || i
    
      cells_all := cells_all || to_json_null('248_' || i::text, (cells_all->>('246_' || i)::text)::numeric + (cells_all->>('247_' || i)::text)::numeric);
	
    end loop;

-- 	C250	=C137

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('250_' || i::text, (cells_all->>('137_' || i)::text)::numeric);
	
    end loop;
    
-- 	C251	=C176

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('251_' || i::text, (cells_all->>('176_' || i)::text)::numeric);
	
    end loop;

-- 	C252	=C235

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('252_' || i::text, (cells_all->>('235_' || i)::text)::numeric);
	
    end loop;


-- 	C253	=C242

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('253_' || i::text, (cells_all->>('242_' || i)::text)::numeric);
	
    end loop;

-- 	C254	=SUM(C250:C253)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('254_' || i::text, (cells_all->>('250_' || i)::text)::numeric + (cells_all->>('251_' || i)::text)::numeric + (cells_all->>('252_' || i)::text)::numeric + (cells_all->>('253_' || i)::text)::numeric);
	
    end loop;

-- 	C256	=C248+C254

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('256_' || i::text, (cells_all->>('248_' || i)::text)::numeric + (cells_all->>('254_' || i)::text)::numeric);
	
    end loop;

-- 	C259	=SUM(C256:L256)

    cells_all := cells_all || to_json_null('259_0'::text, (cells_all->>'256_0')::numeric + (cells_all->>'256_1')::numeric + (cells_all->>'256_2')::numeric + (cells_all->>'256_3')::numeric
                     + (cells_all->>'256_4')::numeric + (cells_all->>'256_5')::numeric + (cells_all->>'256_6')::numeric + (cells_all->>'256_7')::numeric
                     + (cells_all->>'256_8')::numeric + (cells_all->>'256_9')::numeric);
                    
-- 	C260	='National Data'!B9

-- 	C263	=PV($C$260,C$262,0,C256)*-1
-- pv(rate, nper, fv)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('263_' || i::text, pv((cells_all->>'260_0')::numeric, (cells_all->>('262_' || i)::text)::numeric, (cells_all->>('256_' || i)::text)::numeric));
    
    end loop;

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

