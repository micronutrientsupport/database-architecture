CREATE OR REPLACE FUNCTION update_intervention_data_totals(int_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

/*
This function takes all the intervention costing data as json,from one intervention and recalculates
all the totals where a formula is applied, as copied and translated from the excel work sheet.
*/

declare 

cells_all jsonb;

test1 integer;

num_var numeric;

begin
	
cells_all := get_intervention_data_as_json(int_id);

-- C1		E1 =D1+1	F1 =E1+1	G1 =F1+1	H1 =G1+1
-- C4		E4 =D4			
-- C5		E5 =D5	F5 =E5	G5 =F5	H5 =G5
-- C6		E6 =D6	F6 =E6	G6 =F6	H6 =G6
-- C7		E7 =D7	F7 =E7	G7 =F7	H7 =G7
-- C8		E8 =D8	F8 =E8	G8 =F8	H8 =G8
-- C9		E9 =D9	F9 =E9	G9 =F9	H9 =G9
-- C10		E10 =D10	F10 =E10	G10 =F10	H10 =G10
-- C11		E11 =D11	F11 =E11	G11 =F11	H11 =G11
-- C12		E12 =D12	F12 =E12	G12 =F12	H12 =G12
-- C13		E13 =D13	F13 =E13	G13 =F13	H13 =G13
-- C14		E14 =D14	F14 =E14	G14 =F14	H14 =G14
-- C15		E15 =D15	F15 =E15	G15 =F15	H15 =G15
-- C16		E16 =D16	F16 =E16	G16 =F16	H16 =G16
-- C17		E17 =D17	F17 =E17	G17 =F17	H17 =G17
-- C18		E18 =D18	F18 =E18	G18 =F18	H18 =G18
-- C19		E19 =D19	F19 =E19	G19 =F19	H19 =G19
-- C20		E20 =D20	F20 =E20	G20 =F20	H20 =G20
-- C21		E21 =D21	F21 =E21	G21 =F21	H21 =G21
-- C22		E22 =D22	F22 =E22	G22 =F22	H22 =G22
-- C23		E23 =D23	F23 =E23	G23 =F23	H23 =G23
-- C24		E24 =D24	F24 =E24	G24 =F24	H24 =G24
-- C25		E25 =D25	F25 =E25	G25 =F25	H25 =G25
-- C26		E26 =D26	F26 =E26	G26 =F26	H26 =G26
-- C27		E27 =D27	F27 =E27	G27 =F27	H27 =G27
-- C28		E28 =D28	F28 =E28	G28 =F28	H28 =G28
-- C31		E31 =D31	F31 =E31	G31 =F31	H31 =G31

-- C32	D32 =ROUNDUP(D28*D31, 0)	E32 =ROUNDUP(E28*E31, 0)	F32 =ROUNDUP(F28*F31, 0)	G32 =ROUNDUP(G28*G31, 0)	H32 =ROUNDUP(H28*H31, 0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('32_' || i::text,ceil((cells_all->>('28_' || i)::text)::numeric * (cells_all->>('31_' || i)::text)::numeric));
    
    end loop;

-- C33		E33 =D33	F33 =E33	G33 =F33	H33 =G33
-- C34	D34 =IF(OR(D14>0,D15>0),3,0)	E34 =IF(OR(E14>0,E15>0),3,0)	F34 =IF(OR(F14>0,F15>0),3,0)	G34 =IF(OR(G14>0,G15>0),3,0)	H34 =IF(OR(H14>0,H15>0),3,0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('34_' || i::text, case when (cells_all->>('14_' || i)::text)::numeric > 0 or (cells_all->>('15_' || i)::text)::numeric > 0 then 3 else 0 end);
    
    end loop;

-- C35	D35 =IF(OR(D6>0,D7>0,D8>0,D8>0,D9>0,D10>0),3,0)	E35 =IF(OR(E6>0,E7>0,E8>0,E8>0,E9>0,E10>0),3,0)	F35 =IF(OR(F6>0,F7>0,F8>0,F8>0,F9>0,F10>0),3,0)	G35 =IF(OR(G6>0,G7>0,G8>0,G8>0,G9>0,G10>0),3,0)	H35 =IF(OR(H6>0,H7>0,H8>0,H8>0,H9>0,H10>0),3,0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('35_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or
        (cells_all->>('8_' || i)::text)::numeric > 0 or
        (cells_all->>('9_' || i)::text)::numeric > 0 or
        (cells_all->>('10_' || i)::text)::numeric > 0
      	then 3 else 0 end);
    
    end loop;  

-- C36		E36 =D36	F36 =E36	G36 =F36	H36 =G36
-- C37		E37 =D37	F37 =E37	G37 =F37	H37 =G37
-- C38	D38 =1-D37	E38 =1-E37	F38 =1-F37	G38 =1-G37	H38 =1-H37

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('38_' || i::text, 1 - (cells_all->>('37_' || i)::text)::numeric);
    
    end loop;

-- C41	D41 =IF(D$28=0,0,IF(AND(D$28>0,D$28<0.25),1,IF(AND(D$28>=0.25,D$28<0.5),2,IF(AND(D$28>=0.5,D$28<0.75),3,4))))	E41 =IF(E$28=0,0,IF(AND(E$28>0,E$28<0.25),1,IF(AND(E$28>=0.25,E$28<0.5),2,IF(AND(E$28>=0.5,E$28<0.75),3,4))))	F41 =IF(F$28=0,0,IF(AND(F$28>0,F$28<0.25),1,IF(AND(F$28>=0.25,F$28<0.5),2,IF(AND(F$28>=0.5,F$28<0.75),3,4))))	G41 =IF(G$28=0,0,IF(AND(G$28>0,G$28<0.25),1,IF(AND(G$28>=0.25,G$28<0.5),2,IF(AND(G$28>=0.5,G$28<0.75),3,4))))	H41 =IF(H$28=0,0,IF(AND(H$28>0,H$28<0.25),1,IF(AND(H$28>=0.25,H$28<0.5),2,IF(AND(H$28>=0.5,H$28<0.75),3,4))))

 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('41_' || i::text, 
		case when (cells_all->>('28_' || i)::text)::numeric = 0 then 0
			when (cells_all->>('28_' || i)::text)::numeric > 0 and (cells_all->>('28_' || i)::text)::numeric < 0.25 then 1 
			when (cells_all->>('28_' || i)::text)::numeric >= 0.25 and (cells_all->>('28_' || i)::text)::numeric < 0.5 then 2
			when (cells_all->>('28_' || i)::text)::numeric >= 0.5 and (cells_all->>('28_' || i)::text)::numeric < 0.75 then 3
					else 4 end
        );
    
    end loop;

-- C42	D42 =IF(OR(D14>0, D15>0),3,0)	E42 =IF(OR(E14>0, E15>0),3,0)	F42 =IF(OR(F14>0, F15>0),3,0)	G42 =IF(OR(G14>0, G15>0),3,0)	H42 =IF(OR(H14>0, H15>0),3,0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('42_' || i::text, case when (cells_all->>('14_' || i)::text)::numeric > 0 or (cells_all->>('15_' || i)::text)::numeric > 0 then 3 else 0 end);
    
    end loop;

-- C43	D43 =IF(OR(D6>0,D7>0,D8>0,D8>0,D9>0,D10>0),3,0)	E43 =IF(OR(E6>0,E7>0,E8>0,E8>0,E9>0,E10>0),3,0)	F43 =IF(OR(F6>0,F7>0,F8>0,F8>0,F9>0,F10>0),3,0)	G43 =IF(OR(G6>0,G7>0,G8>0,G8>0,G9>0,G10>0),3,0)	H43 =IF(OR(H6>0,H7>0,H8>0,H8>0,H9>0,H10>0),3,0)

 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('43_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or 
        (cells_all->>('8_' || i)::text)::numeric > 0 or 
        (cells_all->>('9_' || i)::text)::numeric > 0 or 
        (cells_all->>('10_' || i)::text)::numeric > 0 
        then 3 else 0 end);
    
    end loop;

-- C44		E44 =D44	F44 =E44	G44 =F44	H44 =G44
-- C45	D45 =IF(D$28=0,0,IF(AND(D$28>0,D$28<0.25),6,IF(AND(D$28>=0.25,D$28<0.5),12,IF(AND(D$28>=0.5,D$28<0.75),18,24))))	E45 =IF(E$28=0,0,IF(AND(E$28>0,E$28<0.25),6,IF(AND(E$28>=0.25,E$28<0.5),12,IF(AND(E$28>=0.5,E$28<0.75),18,24))))	F45 =IF(F$28=0,0,IF(AND(F$28>0,F$28<0.25),6,IF(AND(F$28>=0.25,F$28<0.5),12,IF(AND(F$28>=0.5,F$28<0.75),18,24))))	G45 =IF(G$28=0,0,IF(AND(G$28>0,G$28<0.25),6,IF(AND(G$28>=0.25,G$28<0.5),12,IF(AND(G$28>=0.5,G$28<0.75),18,24))))	H45 =IF(H$28=0,0,IF(AND(H$28>0,H$28<0.25),6,IF(AND(H$28>=0.25,H$28<0.5),12,IF(AND(H$28>=0.5,H$28<0.75),18,24))))

 	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('45_' || i::text, case when (cells_all->>('28_' || i)::text)::numeric = 0 then 0
					when (cells_all->>('28_' || i)::text)::numeric > 0 and (cells_all->>('28_' || i)::text)::numeric < 0.25 then 6 
					when (cells_all->>('28_' || i)::text)::numeric >= 0.25 and (cells_all->>('28_' || i)::text)::numeric < 0.5 then 12
					when (cells_all->>('28_' || i)::text)::numeric >= 0.5 and (cells_all->>('28_' || i)::text)::numeric < 0.75 then 18
					else 24 end);
    
    end loop;


-- C46	D46 =IF(OR(D14>0,D15>0),2,0)	E46 =IF(OR(E14>0,E15>0),2,0)	F46 =IF(OR(F14>0,F15>0),2,0)	G46 =IF(OR(G14>0,G15>0),2,0)	H46 =IF(OR(H14>0,H15>0),2,0)

    for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('46_' || i::text, case when (cells_all->>('14_' || i)::text)::numeric > 0 or (cells_all->>('15_' || i)::text)::numeric > 0 then 2 else 0 end );
    
    end loop;

-- C47	D47 =IF(OR(D6>0,D7>0,D8>0,D8>0,D9>0,D10>0),2,0)	E47 =IF(OR(E6>0,E7>0,E8>0,E8>0,E9>0,E10>0),2,0)	F47 =IF(OR(F6>0,F7>0,F8>0,F8>0,F9>0,F10>0),2,0)	G47 =IF(OR(G6>0,G7>0,G8>0,G8>0,G9>0,G10>0),2,0)	H47 =IF(OR(H6>0,H7>0,H8>0,H8>0,H9>0,H10>0),2,0)

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('47_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or 
        (cells_all->>('8_' || i)::text)::numeric > 0 or 
        (cells_all->>('9_' || i)::text)::numeric > 0 or 
        (cells_all->>('10_' || i)::text)::numeric > 0  
        then 2 else 0 end );
    
    end loop;

-- C48		E48 =D48	F48 =E48	G48 =F48	H48 =G48
-- C49	D49 =IF(D$28=0,0,IF(AND(D$28>0,D$28<0.25),1,IF(AND(D$28>=0.25,D$28<0.5),2,IF(AND(D$28>=0.5,D$28<0.75),3,4))))	E49 =IF(E$28=0,0,IF(AND(E$28>0,E$28<0.25),1,IF(AND(E$28>=0.25,E$28<0.5),2,IF(AND(E$28>=0.5,E$28<0.75),3,4))))	F49 =IF(F$28=0,0,IF(AND(F$28>0,F$28<0.25),1,IF(AND(F$28>=0.25,F$28<0.5),2,IF(AND(F$28>=0.5,F$28<0.75),3,4))))	G49 =IF(G$28=0,0,IF(AND(G$28>0,G$28<0.25),1,IF(AND(G$28>=0.25,G$28<0.5),2,IF(AND(G$28>=0.5,G$28<0.75),3,4))))	H49 =IF(H$28=0,0,IF(AND(H$28>0,H$28<0.25),1,IF(AND(H$28>=0.25,H$28<0.5),2,IF(AND(H$28>=0.5,H$28<0.75),3,4))))

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('49_' || i::text, case when (cells_all->>('28_' || i)::text)::numeric = 0 then 0 					
                    when (cells_all->>('28_' || i)::text)::numeric > 0 
                     and (cells_all->>('28_' || i)::text)::numeric < 0.25 then 1 					
                    when (cells_all->>('28_' || i)::text)::numeric >= 0.25 
                     and (cells_all->>('28_' || i)::text)::numeric < 0.5 then 2 					
                    when (cells_all->>('28_' || i)::text)::numeric >= 0.5 
                     and (cells_all->>('28_' || i)::text)::numeric < 0.75 then 3 					
                    else 4 end );
    
    end loop;

-- C50	D50 =IF(OR(D14>0,D15>0),5,0)	E50 =IF(OR(E14>0,E15>0),5,0)	F50 =IF(OR(F14>0,F15>0),5,0)	G50 =IF(OR(G14>0,G15>0),5,0)	H50 =IF(OR(H14>0,H15>0),5,0)

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('50_' || i::text, case when 
        (cells_all->>('14_' || i)::text)::numeric > 0 or 
        (cells_all->>('15_' || i)::text)::numeric > 0 then 5 else 0 end );
    
    end loop;

-- C51	D51 =IF(OR(D6>0,D7>0,D8>0,D8>0,D9>0),5,0)	E51 =IF(OR(E6>0,E7>0,E8>0,E8>0,E9>0),5,0)	F51 =IF(OR(F6>0,F7>0,F8>0,F8>0,F9>0),5,0)	G51 =IF(OR(G6>0,G7>0,G8>0,G8>0,G9>0),5,0)	H51 =IF(OR(H6>0,H7>0,H8>0,H8>0,H9>0),5,0)

   for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('51_' || i::text, case when 
        (cells_all->>('6_' || i)::text)::numeric > 0 or 
        (cells_all->>('7_' || i)::text)::numeric > 0 or 
        (cells_all->>('8_' || i)::text)::numeric > 0 or 
        (cells_all->>('9_' || i)::text)::numeric > 0 then 5 else 0 end );
    
    end loop;

-- C55		E55 =(10000)*(1+0.05)			
-- C56		E56 =MAX(D32:M32)-D32	

   cells_all := cells_all || to_json_null('56_1'::text, 
   greatest((cells_all->>'32_0')::numeric, 
       (cells_all->>'32_1')::numeric,
       (cells_all->>'32_2')::numeric,
       (cells_all->>'32_3')::numeric,
       (cells_all->>'32_4')::numeric,
       (cells_all->>'32_5')::numeric,
       (cells_all->>'32_6')::numeric,
       (cells_all->>'32_7')::numeric,
       (cells_all->>'32_8')::numeric,
       (cells_all->>'32_9')::numeric) - (cells_all->>'32_0')::numeric);
		
-- C57		E57 =E55*E56

   cells_all := cells_all || to_json_null('57_1'::text, (cells_all->>'55_1')::numeric * (cells_all->>'56_1')::numeric);
			
-- C58		E58 =(2000)*(1+0.05)			
-- C59		E59 =MAX(D32:M32)-D32	

   cells_all := cells_all || to_json_null('59_1'::text, 
   greatest((cells_all->>'32_0')::numeric, 
       (cells_all->>'32_1')::numeric,
       (cells_all->>'32_2')::numeric,
       (cells_all->>'32_3')::numeric,
       (cells_all->>'32_4')::numeric,
       (cells_all->>'32_5')::numeric,
       (cells_all->>'32_6')::numeric,
       (cells_all->>'32_7')::numeric,
       (cells_all->>'32_8')::numeric,
       (cells_all->>'32_9')::numeric) - (cells_all->>'32_0')::numeric);
		
-- C60		E60 =E58*E59	

   cells_all := cells_all || to_json_null('60_1'::text, (cells_all->>'58_1')::numeric * (cells_all->>'59_1')::numeric);
		
-- C61		E61 =850*'GDP Deflators'!$H$38			
-- C63		E63 =SUM(E58:E61)*E62	

   cells_all := cells_all || to_json_null('63_1'::text, 
  ((cells_all->>'58_1')::numeric + 
   (cells_all->>'59_1')::numeric + 
   (cells_all->>'60_1')::numeric + 
   (cells_all->>'61_1')::numeric) * 
   (cells_all->>'62_1')::numeric);
		
-- C65		E65 =IF(D14>0,MAX(D32:M32)-D32,0)		


    cells_all := cells_all || to_json_null('65_1'::text, case when (cells_all->>'14_0')::numeric > 0 then 
    greatest((cells_all->>'32_0')::numeric, 
           (cells_all->>'32_1')::numeric,
           (cells_all->>'32_2')::numeric,
           (cells_all->>'32_3')::numeric,
           (cells_all->>'32_4')::numeric,
           (cells_all->>'32_5')::numeric,
           (cells_all->>'32_6')::numeric,
           (cells_all->>'32_7')::numeric,
           (cells_all->>'32_8')::numeric,
           (cells_all->>'32_9')::numeric) - (cells_all->>'32_0')::numeric else 0 end );
	
-- C67		E67 =IF(OR(D6>0,D7>0,D8>0,D8>0,D9>0),MAX(D32:M32)-D32,0)	

    cells_all := cells_all || to_json_null('67_1'::text, case when 
    (cells_all->>'6_0')::numeric > 0 or   
    (cells_all->>'7_0')::numeric > 0 or 
    (cells_all->>'8_0')::numeric > 0 or 
    (cells_all->>'9_0')::numeric > 0 
    then 
    greatest((cells_all->>'32_0')::numeric, 
       (cells_all->>'32_1')::numeric,
       (cells_all->>'32_2')::numeric,
       (cells_all->>'32_3')::numeric,
       (cells_all->>'32_4')::numeric,
       (cells_all->>'32_5')::numeric,
       (cells_all->>'32_6')::numeric,
       (cells_all->>'32_7')::numeric,
       (cells_all->>'32_8')::numeric,
       (cells_all->>'32_9')::numeric) - (cells_all->>'32_0')::numeric else 0 end ); 
		
-- C69		E69 =E67	

    cells_all := cells_all || to_json_null('69_1'::text, (cells_all->>'67_1')::numeric);
		
-- C70		E70 =E64*E65 + E66*E67+E68*E69	

    cells_all := cells_all || to_json_null('70_1'::text, 
    (cells_all->>'64_1')::numeric * 
    (cells_all->>'65_1')::numeric + 
    (cells_all->>'66_1')::numeric * 
    (cells_all->>'67_1')::numeric + 
    (cells_all->>'68_1')::numeric * 
    (cells_all->>'69_1')::numeric );
		
-- C72		E72 =(E70+E57)*E71		

    cells_all := cells_all || to_json_null('72_1'::text, 
    ((cells_all->>'70_1')::numeric + 
    (cells_all->>'57_1')::numeric) * 
    (cells_all->>'71_1')::numeric );
	
-- C73		E73 ='National Data'!B15			
-- C74		E74 ='National Data'!B16			
-- C75		E75 =(E57+E63)*E73+E70*E74	

    cells_all := cells_all || to_json_null('75_1'::text, 
   ((cells_all->>'57_1')::numeric + 
    (cells_all->>'63_1')::numeric) * 
    (cells_all->>'73_1')::numeric + 
    (cells_all->>'70_1')::numeric * 
    (cells_all->>'74_1')::numeric);
		
-- C76		E76 ='National Data'!B10			
-- C77		E77 ='National Data'!B11			
-- C78		E78 =(E57+E63)*E76+E70*E77	

   cells_all := cells_all || to_json_null('78_1'::text, 
   ((cells_all->>'57_1')::numeric + 
   (cells_all->>'63_1')::numeric) * 
   (cells_all->>'76_1')::numeric + 
   (cells_all->>'70_1')::numeric * 
   (cells_all->>'77_1')::numeric);
		
-- C79		E79 =-E57+E60+E63+E70+E72+E75+E78	

    cells_all := cells_all || to_json_null('79_1'::text,
    -(cells_all->>'57_1')::numeric +
    (cells_all->>'60_1')::numeric +
    (cells_all->>'63_1')::numeric +
    (cells_all->>'70_1')::numeric +
    (cells_all->>'72_1')::numeric +
    (cells_all->>'75_1')::numeric +
    (cells_all->>'78_1')::numeric );
		
-- C81		E81 =262.6*'GDP Deflators'!$G$38			
-- C82		E82 =MAX(D32:M32)-D32	

cells_all := cells_all || to_json_null('82_1'::text,  
    greatest((cells_all->>'32_0')::numeric, 
           (cells_all->>'32_1')::numeric,
           (cells_all->>'32_2')::numeric,
           (cells_all->>'32_3')::numeric,
           (cells_all->>'32_4')::numeric,
           (cells_all->>'32_5')::numeric,
           (cells_all->>'32_6')::numeric,
           (cells_all->>'32_7')::numeric,
           (cells_all->>'32_8')::numeric,
           (cells_all->>'32_9')::numeric) - (cells_all->>'32_0')::numeric );
		
-- C83		E83 =E81*E82

    cells_all := cells_all || to_json_null('83_1'::text,
    (cells_all->>'81_1')::numeric *
    (cells_all->>'82_1')::numeric );
			
-- C85		E85 =400*'GDP Deflators'!$G$38			
-- C87		E87 =MAX(D32:M32)-D32	

cells_all := cells_all || to_json_null('87_1'::text,  
    greatest((cells_all->>'32_0')::numeric, 
           (cells_all->>'32_1')::numeric,
           (cells_all->>'32_2')::numeric,
           (cells_all->>'32_3')::numeric,
           (cells_all->>'32_4')::numeric,
           (cells_all->>'32_5')::numeric,
           (cells_all->>'32_6')::numeric,
           (cells_all->>'32_7')::numeric,
           (cells_all->>'32_8')::numeric,
           (cells_all->>'32_9')::numeric) - (cells_all->>'32_0')::numeric );
		
-- C88		E88 =E85*E86*E87	

    cells_all := cells_all || to_json_null('88_1'::text,
    (cells_all->>'85_1')::numeric *
    (cells_all->>'86_1')::numeric *
    (cells_all->>'87_1')::numeric );
	
-- C89		E89 =E79+E83+E88	

    cells_all := cells_all || to_json_null('89_1'::text,
    (cells_all->>'79_1')::numeric +
    (cells_all->>'83_1')::numeric +
    (cells_all->>'88_1')::numeric );
		
-- C93	D93 =IF(D4="SU",200000*'GDP Deflators'!$G$38,0)	
			
-- C94	D94 =IF(D4="SU",15000,0)	

	cells_all := cells_all || to_json_null('94_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 15000 else 0 end);
			
-- C95	D95 =IF(D4="SU",20000,0)

	cells_all := cells_all || to_json_null('95_0'::text,case when (cells_all->>'4_0')::numeric = 1 then 20000 else 0 end);
				
-- C96	D96 =IF(D4="SU", 10000,IF(D4="SC",5000,0))		

	cells_all := cells_all || to_json_null('94_0'::text,
    case when (cells_all->>'4_0')::numeric = 1 then 10000 when (cells_all->>'4_0')::numeric = 2 then 5000 else 0 end);
		
-- C97	D97 =SUM(D93:D96)	

	cells_all := cells_all || to_json_null('97_0'::text,
    (cells_all->>'93_0')::numeric + 
    (cells_all->>'94_0')::numeric + 
    (cells_all->>'95_0')::numeric + 
    (cells_all->>'96_0')::numeric);
 			
-- C100		E100 =IF(D4="SU",IF(D14>0,E44+1+1,0),0)	

    cells_all := cells_all || to_json_null('100_1'::text,
    case when (cells_all->>'4_0')::numeric = 1 then 
        case when (cells_all->>'14_0')::numeric > 0 then (cells_all->>'44_1')::numeric + 1 + 1 else 0 end
    else 0 end);
		
-- C102		E102 =IF(D4="SU",IF(OR(D6>0,D7>0,D8>0,D8>0,D9>0),E44+1+1,0),0)	

    cells_all := cells_all || to_json_null('102_1'::text,
    case when (cells_all->>'4_0')::numeric = 1 then 
        case when 
            (cells_all->>'6_0')::numeric > 0 or   
            (cells_all->>'7_0')::numeric > 0 or 
            (cells_all->>'8_0')::numeric > 0 or 
            (cells_all->>'9_0')::numeric > 0 
        then (cells_all->>'44_1')::numeric + 1 + 1 else 0 end
    else 0 end);
		
-- C104		E104 =E102	

    cells_all := cells_all || to_json_null('104_1'::text, (cells_all->>'102_1')::numeric);
		
-- C105		E105 =E99*E100+E101*E102+E103*E104	

    cells_all := cells_all || to_json_null('105_1'::text, 
   (cells_all->>'99_1')::numeric * 
   (cells_all->>'100_1')::numeric + 
   (cells_all->>'101_1')::numeric * 
   (cells_all->>'102_1')::numeric +
   (cells_all->>'103_1')::numeric *
   (cells_all->>'104_1')::numeric   );
		
-- C107		E107 =E105*E106			

   cells_all := cells_all || to_json_null('107_1'::text, 
   (cells_all->>'105_1')::numeric * 
   (cells_all->>'106_1')::numeric );

-- C108		E108 =E105+E107	

    cells_all := cells_all || to_json_null('108_1'::text, 
   (cells_all->>'105_1')::numeric +
   (cells_all->>'107_1')::numeric );
		
-- C110	D110 =IF(D4="BAU",0,IF(D4="SU",50000,25000))	E110 =IF(D4="BAU",0,IF(D4="SU",50000,25000))	

	cells_all := cells_all || to_json_null('110_0'::text,case 
	when (cells_all->>'4_0')::numeric = 3 then 0 
	when (cells_all->>'4_0')::numeric = 1 then  50000 
	else 25000 end);

	cells_all := cells_all || to_json_null('110_1'::text,case 
	when (cells_all->>'4_0')::numeric = 3 then 0 
	when (cells_all->>'4_0')::numeric = 1 then  50000 
	else 25000 end);
		
-- C111	D111 =D110	E111 =E110	

    cells_all := cells_all || to_json_null('111_0'::text,(cells_all->>'110_0')::numeric);
	cells_all := cells_all || to_json_null('111_1'::text,(cells_all->>'110_1')::numeric);
		
-- C113		E113 =4000*'GDP Deflators'!$G$38			
-- C114		E114 =IF(D4="BAU",0,4)	

    cells_all := cells_all || to_json_null('114_1'::text,case when (cells_all->>'4_0')::numeric = 3 then 0 else 4 end);
		
-- C115		E115 =E113*E114			

    cells_all := cells_all || to_json_null('115_1'::text, 
   (cells_all->>'113_1')::numeric *
   (cells_all->>'114_1')::numeric );

-- C116	D116 =D97+D108+D111+D115	E116 =E97+E108+E111+E115	

	cells_all := cells_all || to_json_null('116_0'::text,
(cells_all->>'97_0')::numeric + 
(cells_all->>'108_0')::numeric + 
(cells_all->>'111_0')::numeric + 
(cells_all->>'115_0')::numeric);

	cells_all := cells_all || to_json_null('116_1'::text,
(cells_all->>'97_1')::numeric + 
(cells_all->>'108_1')::numeric + 
(cells_all->>'111_1')::numeric + 
(cells_all->>'115_1')::numeric);
		
-- C120	D120 ='Premix - wheat flour'!I34	E120 =D120	F120 =E120	G120 =F120	H120 =G120
-- I33=I31 +I32 (which is just 1)
-- I34=(I33*F30)/1000
/*
	select (("Premix cost" + 1) * "Addition Rate") /1000  into num_var from fortificant_amount_totals where intervention_id =  int_id;

	for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('120_' || i::text,
        num_var);
    
    end loop;
*/

-- C121		E121 =D121	F121 =E121	G121 =F121	H121 =G121
-- C122	D122 ='National Data'!B17	E122 =D122	F122 =E122	G122 =F122	H122 =G122
-- C123	D123 ='National Data'!B12	E123 =D123	F123 =E123	G123 =F123	H123 =G123
-- C124		E124 =D124	F124 =E124	G124 =F124	H124 =G124

-- C125	D125 =D120*(1+D121+D122+D123)+(D124*'Premix - wheat flour'!$F$30)/100	E125 =E120*(1+E121+E122+E123)+(E124*'Premix - wheat flour'!$F$30)/100	F125 =F120*(1+F121+F122+F123)+(F124*'Premix - wheat flour'!$F$30)/100	G125 =G120*(1+G121+G122+G123)+(G124*'Premix - wheat flour'!$F$30)/100	H125 =H120*(1+H121+H122+H123)+(H124*'Premix - wheat flour'!$F$30)/100
/*
	select "Addition Rate" into num_var from fortificant_amount_totals where intervention_id = int_id;

	for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('125_' || i::text,
      		(cells_all->>('120_' || i)::text)::numeric * 
      ( 1 + (cells_all->>('121_' || i)::text)::numeric + 
            (cells_all->>('122_' || i)::text)::numeric + 
            (cells_all->>('123_' || i)::text)::numeric) + 
            ((cells_all->>('124_' || i)::text)::numeric *
            num_var)/100
            );
    end loop;
*/
-- C126		E126 =D126	F126 =E126	G126 =F126	H126 =G126
-- C127	D127 =D27	E127 =E27	F127 =F27	G127 =G27	H127 =H27
-- C128	D128 =Demographics!D3	E128 =Demographics!E3	F128 =Demographics!F3	G128 =Demographics!G3	H128 =Demographics!H3
-- C129	D129 =((D126*D127*D128)*365)/1000000	E129 =((E126*E127*E128)*365)/1000000	F129 =((F126*F127*F128)*365)/1000000	G129 =((G126*G127*G128)*365)/1000000	H129 =((H126*H127*H128)*365)/1000000

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('129_' || i::text,
        ((cells_all->>('126_' || i)::text)::numeric * 
        (cells_all->>('127_' || i)::text)::numeric * 
        (cells_all->>('128_' || i)::text)::numeric * 365) / 1000000);
    
    end loop;

-- C130	D130 =D37	E130 =E37	F130 =F37	G130 =G37	H130 =H37
-- C131	D131 =IF(D130=0,0,D28)	E131 =IF(E130=0,0,E28)	F131 =IF(F130=0,0,F28)	G131 =IF(G130=0,0,G28)	H131 =IF(H130=0,0,H28)

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('131_' || i::text,
        case when (cells_all->>('130_' || i)::text)::numeric = 0 then 0 else (cells_all->>('28_' || i)::text)::numeric end);
        
    end loop;

-- C132	D132 =D129*D131*D130	E132 =E129*E131*E130	F132 =F129*F131*F130	G132 =G129*G131*G130	H132 =H129*H131*H130

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('132_' || i::text,
        (cells_all->>('129_' || i)::text)::numeric * 
        (cells_all->>('131_' || i)::text)::numeric * 
        (cells_all->>('130_' || i)::text)::numeric);
        
    end loop;

-- C133	D133 =D125*D132	            E133 =E125*E132	F133 =F125*F132	G133 =G125*G132	H133 =H125*H132

    for i in 0 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('133_' || i::text,
        (cells_all->>('125_' || i)::text)::numeric * 
        (cells_all->>('132_' || i)::text)::numeric );
        
    end loop;

-- C134	D134 =D38	E134 =E38	F134 =F38	G134 =G38	H134 =H38
-- C135	D135 =IF(D134=0,0,D28)	E135 =IF(E134=0,0,E28)	F135 =IF(F134=0,0,F28)	G135 =IF(G134=0,0,G28)	H135 =IF(H134=0,0,H28)

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('135_' || i::text,
       case when (cells_all->>('134_' || i)::text)::numeric = 0 then 0 else (cells_all->>('28_' || i)::text)::numeric end);
        
    end loop;

-- C136	D136 =D129*D134*D135	E136 =E129*E134*E135	F136 =F129*F134*F135	G136 =G129*G134*G135	H136 =H129*H134*H135

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('136_' || i::text,
       (cells_all->>('129_' || i)::text)::numeric * 
       (cells_all->>('134_' || i)::text)::numeric * 
       (cells_all->>('135_' || i)::text)::numeric);
        
    end loop;

-- C137	D137 =D125*D136	        E137 =E125*E136	F137 =F125*F136	G137 =G125*G136	H137 =H125*H136

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('137_' || i::text,
       (cells_all->>('125_' || i)::text)::numeric * 
       (cells_all->>('136_' || i)::text)::numeric );
        
    end loop;

-- C138	D138 =D133+D137	    E138 =E133+E137	F138 =F133+F137	G138 =G133+G137	H138 =H133+H137

    for i in 0 .. 9 loop -- ' || i
    
       cells_all := cells_all || to_json_null('138_' || i::text,
       (cells_all->>('133_' || i)::text)::numeric + 
       (cells_all->>('137_' || i)::text)::numeric);
        
    end loop;

-- C139	D139 =D138	E139 =E138	F139 =F138	G139 =G138	H139 =H138

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('139_' || i::text,(cells_all->>('138_' || i)::text)::numeric);
        
    end loop;

-- C143		E143 =D143	F143 =E143	G143 =F143	H143 =G143

-- C144	D144 ='National Data'!B6*2	E144 =D144*(1+'National Data'!$B$22)	F144 =E144*(1+'National Data'!$B$22)	G144 =F144*(1+'National Data'!$B$22)	H144 =G144*(1+'National Data'!$B$22)

-- C145	D145 =D32*D144*D143	        E145 =E32*E144*E143	F145 =F32*F144*F143	G145 =G32*G144*G143	H145 =H32*H144*H143

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('145_' || i::text,
      (cells_all->>('32_' || i)::text)::numeric * 
      (cells_all->>('144_' || i)::text)::numeric * 
      (cells_all->>('143_' || i)::text)::numeric);
        
    end loop;

-- C146				G146 =F146	H146 =G146
-- C147	D147 =D32*D146*($E$55)	E147 =E32*E146*($E$55)	F147 =F32*F146*($E$55)	G147 =G32*G146*($E$55)	H147 =H32*H146*($E$55)
-- 17Jan2022 new formula: D147 =D132*(1000/5)

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('147_' || i::text,
      (cells_all->>('132_' || i)::text)::numeric * (1000/5));
        
    end loop;

-- C148	D148 =D145+D147	E148 =E145+E147	F148 =F145+F147	G148 =G145+G147	H148 =H145+H147
-- 17Jan2022 new formula: D148 =D146*D147
   
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('148_' || i::text,
      (cells_all->>('146_' || i)::text)::numeric * (cells_all->>('147_' || i)::text)::numeric);
        
    end loop;

-- C150	D150 =816.62/100	E150 =D150	F150 =E150	G150 =F150	H150 =G150
-- C151		E151 =D151	F151 =E151	G151 =F151	H151 =G151
-- C152	D152 ='National Data'!B16	E152 =D152	F152 =E152	G152 =F152	H152 =G152
-- C153	D153 ='National Data'!B11	E153 =D153	F153 =E153	G153 =F153	H153 =G153

-- C154	D154 =D150*(1+D151+D152+D153)	    E154 =E150*(1+E151+E152+E153)	F154 =F150*(1+F151+F152+F153)	G154 =G150*(1+G151+G152+G153)	H154 =H150*(1+H151+H152+H153)
   -- 17Jan2022 no formula
   /*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('154_' || i::text, 
      (cells_all->>('150_' || i)::text)::numeric * 
      (1 + (cells_all->>('151_' || i)::text)::numeric + 
      (cells_all->>('152_' || i)::text)::numeric + 
      (cells_all->>('153_' || i)::text)::numeric));
        
    end loop;
	*/

-- C155	D155 =D34	E155 =E34	F155 =F34	G155 =G34	H155 =H34
-- 17Jan2022   ='National Data'!B16
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('155_' || i::text, (cells_all->>('34_' || i)::text)::numeric);
        
    end loop;
*/
-- C156	D156 =673.19/100	E156 =D156	F156 =E156	G156 =F156	H156 =G156
-- C157		E157 =D157	F157 =E157	G157 =F157	H157 =G157
-- C158	D158 ='National Data'!B16	E158 =D158	F158 =E158	G158 =F158	H158 =G158
-- C159	D159 ='National Data'!B11	E159 =D159	F159 =E159	G159 =F159	H159 =G159

-- C160	D160 =D156*(1+D157+D158+D159)	E160 =E156*(1+E157+E158+E159)	F160 =F156*(1+F157+F158+F159)	G160 =G156*(1+G157+G158+G159)	H160 =H156*(1+H157+H158+H159)

   for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('160_' || i::text, 
     (cells_all->>('156_' || i)::text)::numeric * 
    (1 + (cells_all->>('157_' || i)::text)::numeric + 
   (cells_all->>('158_' || i)::text)::numeric + 
  (cells_all->>('159_' || i)::text)::numeric));
        
    end loop;

-- C161	D161 =D35	E161 =E35	F161 =F35	G161 =G35	H161 =H35
-- 17Jan2022   ='National Data'!B16
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('161_' || i::text, (cells_all->>('35_' || i)::text)::numeric);
        
    end loop;
*/
-- C162	D162 =(D154*D155+D160*D161)*D32*D33	        E162 =(E154*E155+E160*E161)*E32*E33	F162 =(F154*F155+F160*F161)*F32*F33	G162 =(G154*G155+G160*G161)*G32*G33	H162 =(H154*H155+H160*H161)*H32*H33

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('162_' || i::text, 
      ((cells_all->>('154_' || i)::text)::numeric * 
      (cells_all->>('155_' || i)::text)::numeric + 
      (cells_all->>('160_' || i)::text)::numeric * 
      (cells_all->>('161_' || i)::text)::numeric) * 
      (cells_all->>('32_' || i)::text)::numeric * 
      (cells_all->>('33_' || i)::text)::numeric);
	
    end loop;

-- C163		E163 =D163	F163 =E163	G163 =F163	H163 =G163
-- C164	D164 ='National Data'!B6*2.5	E164 =D164	F164 =E164	G164 =F164	H164 =G164

-- C165	D165 =D163*D164*D32	E165 =E163*E164*E32	F165 =F163*F164*F32	G165 =G163*G164*G32	H165 =H163*H164*H32
-- 17Jan2022 D165 =    (D157*D158+D163*D164)*D32*D33

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('165_' || i::text,
      ((cells_all->>('157_' || i)::text)::numeric * 
      (cells_all->>('158_' || i)::text)::numeric +
      (cells_all->>('163_' || i)::text)::numeric * 
      (cells_all->>('164_' || i)::text)::numeric) * 
      (cells_all->>('32_' || i)::text)::numeric *
      (cells_all->>('33_' || i)::text)::numeric);
        
    end loop;

-- C166	D166 =D162+D165	E166 =E162+E165	F166 =F162+F165	G166 =G162+G165	H166 =H162+H165
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('166_' || i::text, 
      (cells_all->>('162_' || i)::text)::numeric + 
      (cells_all->>('165_' || i)::text)::numeric);
        
    end loop;
*/
-- C168	D168 =50*'GDP Deflators'!$G$38	E168 =D168*(1+'National Data'!$B$22)	F168 =E168*(1+'National Data'!$B$22)	G168 =F168*(1+'National Data'!$B$22)	H168 =G168*(1+'National Data'!$B$22)
-- C169		E169 =D169	F169 =E169	G169 =F169	H169 =G169

-- C170	D170 =D168*D169*D32	E170 =E168*E169*E32	F170 =F168*F169*F32	G170 =G168*G169*G32	H170 =H168*H169*H32

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('170_' || i::text,
      (cells_all->>('168_' || i)::text)::numeric * 
      (cells_all->>('169_' || i)::text)::numeric * 
      (cells_all->>('32_' || i)::text)::numeric);
        
    end loop;

-- C172	D172 =200*'GDP Deflators'!F38	E172 =D172	F172 =E172	G172 =F172	H172 =G172
-- C173		E173 =D173	F173 =E173	G173 =F173	H173 =G173

-- C174	D174 =D172*D173*D32	E174 =E172*E173*E32	F174 =F172*F173*F32	G174 =G172*G173*G32	H174 =H172*H173*H32

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('174_' || i::text,
      (cells_all->>('172_' || i)::text)::numeric * 
      (cells_all->>('173_' || i)::text)::numeric * 
      (cells_all->>('32_' || i)::text)::numeric);
        
    end loop;

-- C176		E176 =D176	F176 =E176	G176 =F176	H176 =G176
-- C177	D177 =D176*(D148+D166+D170+D174)	E177 =E176*(E148+E166+E170+E174)	F177 =F176*(F148+F166+F170+F174)	G177 =G176*(G148+G166+G170+G174)	H177 =H176*(H148+H166+H170+H174)
-- 17Jan2022  D177 =D175*D176*D32
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('177_' || i::text, 
      (cells_all->>('175_' || i)::text)::numeric * 
      (cells_all->>('176_' || i)::text)::numeric * 
      (cells_all->>('32_' || i)::text)::numeric);
	  
    end loop;

-- C178	D178 =D148+D166+D170+D174+D177	E178 =E148+E166+E170+E174+E177	F178 =F148+F166+F170+F174+F177	G178 =G148+G166+G170+G174+G177	H178 =H148+H166+H170+H174+H177

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('178_' || i::text, 
      (cells_all->>('148_' || i)::text)::numeric +
      (cells_all->>('166_' || i)::text)::numeric + 
      (cells_all->>('170_' || i)::text)::numeric + 
      (cells_all->>('174_' || i)::text)::numeric + 
      (cells_all->>('177_' || i)::text)::numeric);
	  
    end loop;

-- C182	D182 =130*'GDP Deflators'!$G$38	E182 =D182*(1+'National Data'!$B$22)	F182 =E182*(1+'National Data'!$B$22)	G182 =F182*(1+'National Data'!$B$22)	H182 =G182*(1+'National Data'!$B$22)
-- C183	D183 =D31*D41	E183 =E31*E41	F183 =F31*F41	G183 =G31*G41	H183 =H31*H41

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('183_' || i::text,
      (cells_all->>('31_' || i)::text)::numeric * 
      (cells_all->>('41_' || i)::text)::numeric);
	  
    end loop;

-- C184	D184 =D182*D183	    E184 =E182*E183	F184 =F182*F183	G184 =G182*G183	H184 =H182*H183

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('184_' || i::text,
      (cells_all->>('182_' || i)::text)::numeric * 
      (cells_all->>('183_' || i)::text)::numeric);
	
    end loop;

-- C185	D185 =816.62/100	E185 =D185	F185 =E185	G185 =F185	H185 =G185
-- C186		E186 =D186	F186 =E186	G186 =F186	H186 =G186
-- C187	D187 =D185*(1+D186)	    E187 =E185*(1+E186)	F187 =F185*(1+F186)	G187 =G185*(1+G186)	H187 =H185*(1+H186)
-- 17Jan2022 D187 =D185*D186
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('187_' || i::text, 
      (cells_all->>('185_' || i)::text)::numeric * 
      (cells_all->>('186_' || i)::text)::numeric);
	
    end loop;

-- C188	D188 =D42	E188 =E42	F188 =F42	G188 =G42	H188 =H42
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('188_' || i::text, (cells_all->>('42_' || i)::text)::numeric);
	
    end loop;
*/
-- C189	D189 =673.19/100	E189 =D189	F189 =E189	G189 =F189	H189 =G189
-- C190		E190 =D190	F190 =E190	G190 =F190	H190 =G190

-- C191	D191 =D189*(1+D190)	    E191 =E189*(1+E190)	F191 =F189*(1+F190)	G191 =G189*(1+G190)	H191 =H189*(1+H190)
-- 17Jan2022 D191 = D42
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('191_' || i::text, 
      (cells_all->>('42_' || i)::text)::numeric);
	
    end loop;

-- C192	D192 =D43	E192 =E43	F192 =F43	G192 =G43	H192 =H43
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('192_' || i::text, 
      (cells_all->>('43_' || i)::text)::numeric);
	
    end loop;
*/
-- C193	D193 =(D187*D188+D191*D192)*D31*D41	        E193 =(E187*E188+E191*E192)*E31*E41	F193 =(F187*F188+F191*F192)*F31*F41	G193 =(G187*G188+G191*G192)*G31*G41	H193 =(H187*H188+H191*H192)*H31*H41
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('193_' || i::text, 
      ((cells_all->>('187_' || i)::text)::numeric *
      (cells_all->>('188_' || i)::text)::numeric + 
      (cells_all->>('191_' || i)::text)::numeric * 
      (cells_all->>('192_' || i)::text)::numeric) * 
      (cells_all->>('31_' || i)::text)::numeric * 
      (cells_all->>('41_' || i)::text)::numeric);
	
    end loop;
*/
-- C194	D194 =D184+D193	E194 =E184+E193	F194 =F184+F193	G194 =G184+G193	H194 =H184+H193
-- 17Jan2022 D194 =D192*(1+D193)
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('194_' || i::text, 
      (cells_all->>('192_' || i)::text)::numeric * 
      ( 1 + (cells_all->>('193_' || i)::text)::numeric));
	
    end loop;

-- C196		E196 =D196	F196 =E196	G196 =F196	H196 =G196
-- C197	D197 ='National Data'!B6*2.5	E197 =D197*(1+'National Data'!$B$22)	F197 =E197*(1+'National Data'!$B$22)	G197 =F197*(1+'National Data'!$B$22)	H197 =G197*(1+'National Data'!$B$22)

-- C198	D198 =IF(D4="SU",0,D196*D44*D197)	E198 =IF(E4="SU",0,E196*E44*E197)	F198 =F196*F44*F197	G198 =G196*G44*G197	H198 =H196*H44*H197

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('198_' || i::text,
     (cells_all->>('196_' || i)::text)::numeric * 
     (cells_all->>('44_' || i)::text)::numeric * 
     (cells_all->>('197_' || i)::text)::numeric);
	
    end loop;

-- C199	D199 =816.62/100	E199 =D199	F199 =E199	G199 =F199	H199 =G199
-- C200		E200 =D200	F200 =E200	G200 =F200	H200 =G200
-- C201	D201 =D199*(1+D200)	E201 =E199*(1+E200)	F201 =F199*(1+F200)	G201 =G199*(1+G200)	H201 =H199*(1+H200)
-- 17Jan2022 D201 = =IF(D4="SU",0,D199*D44*D200)  F201 = =F199*F44*F200
   
    for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('201_' || i::text, 
      case when (cells_all->>('4_' || i)::text)::numeric = 1 then 0 else 
      (cells_all->>('199_' || i)::text)::numeric * 
      (cells_all->>('44_' || i)::text)::numeric *
      (cells_all->>('200_' || i)::text)::numeric end);
   
    end loop;
   
    for i in 2 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('201_' || i::text, 
      (cells_all->>('199_' || i)::text)::numeric * 
      (cells_all->>('44_' || i)::text)::numeric *
      (cells_all->>('200_' || i)::text)::numeric);
	
    end loop;

-- C202	D202 =D46	E202 =E46	F202 =F46	G202 =G46	H202 =H46
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('202_' || i::text, (cells_all->>('46_' || i)::text)::numeric);
	
    end loop;
*/
-- C203	D203 =673.19/100	E203 =D203	F203 =E203	G203 =F203	H203 =G203
-- C204		E204 =D204	F204 =E204	G204 =F204	H204 =G204

-- C205	D205 =D203*(1+D204)	E205 =E203*(1+E204)	F205 =F203*(1+F204)	G205 =G203*(1+G204)	H205 =H203*(1+H204)
-- 17Jan2022 D205 = D46
   
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('205_' || i::text, 
      (cells_all->>('46_' || i)::text)::numeric);
	
    end loop;

-- C206	D206 =D47	E206 =E47	F206 =F47	G206 =G47	H206 =H47
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('206_' || i::text, (cells_all->>('47_' || i)::text)::numeric);
	
    end loop;
*/
-- C207	D207 =(D201*D202+D205*D206)*D44*D45	        E207 =(E201*E202+E205*E206)*E44*E45	F207 =(F201*F202+F205*F206)*F44*F45	G207 =(G201*G202+G205*G206)*G44*G45	H207 =(H201*H202+H205*H206)*H44*H45
-- 17Jan2022 no formula
/* 
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('207_' || i::text, 
      ((cells_all->>('201_' || i)::text)::numeric *
      (cells_all->>('202_' || i)::text)::numeric + 
      (cells_all->>('205_' || i)::text)::numeric * 
      (cells_all->>('206_' || i)::text)::numeric) * 
      (cells_all->>('44_' || i)::text)::numeric * 
      (cells_all->>('45_' || i)::text)::numeric);
	
    end loop;
*/
-- C208	D208 =D198+D207	E208 =E198+E207	F208 =F198+F207	G208 =G198+G207	H208 =H198+H207
-- 17Jan2022 D208 =D206*(1+D207)
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('208_' || i::text, 
      (cells_all->>('206_' || i)::text)::numeric * 
      (1+(cells_all->>('207_' || i)::text)::numeric));
	
    end loop;

-- C211	D211 ='National Data'!B6*2.5	E211 =D211*(1+'National Data'!$B$22)	F211 =E211*(1+'National Data'!$B$22)	G211 =F211*(1+'National Data'!$B$22)	H211 =G211*(1+'National Data'!$B$22)

-- C212	D212 =IF(D4="SU",0,D210*D211)	E212 =IF(E4="SU",0,E210*E211)	F212 =F210*F211	G212 =G210*G211	H212 =H210*H211

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('212_' || i::text, 
      (cells_all->>('210_' || i)::text)::numeric * 
      (cells_all->>('211_' || i)::text)::numeric);
	
    end loop;

-- C213	D213 =816.62/100	E213 =D213	F213 =E213	G213 =F213	H213 =G213
-- C214		E214 =D214	F214 =E214	G214 =F214	H214 =G214

-- C215	D215 =D213*(1+D214)	E215 =E213*(1+E214)	F215 =F213*(1+F214)	G215 =G213*(1+G214)	H215 =H213*(1+H214)
-- 17Jan2022 D215 =IF(D4="SU",0,D213*D214)
   
    for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('215_' || i::text, 
      case when (cells_all->>('4_' || i)::text)::numeric = 1 then 0 else
      (cells_all->>('213_' || i)::text)::numeric * 
      (cells_all->>('214_' || i)::text)::numeric end);
	
    end loop;   
   
    for i in 2 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('215_' || i::text, 
      (cells_all->>('213_' || i)::text)::numeric * 
      (cells_all->>('214_' || i)::text)::numeric);
	
    end loop;

-- C216	D216 =D50	E216 =E50	F216 =F50	G216 =G50	H216 =H50
-- 17Jan2022 no formula
  /*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('216_' || i::text, (cells_all->>('50_' || i)::text)::numeric);
	
    end loop;
*/
-- C217	D217 =673.19/100	E217 =D217	F217 =E217	G217 =F217	H217 =G217
-- C218		E218 =D218	F218 =E218	G218 =F218	H218 =G218

-- C219	D219 =D217*(1+D218)	    E219 =E217*(1+E218)	F219 =F217*(1+F218)	G219 =G217*(1+G218)	H219 =H217*(1+H218)
-- 17Jan2022 = D50
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('219_' || i::text, 
      (cells_all->>('50_' || i)::text)::numeric);
	
    end loop;

-- C220	D220 =D51	E220 =E51	F220 =F51	G220 =G51	H220 =H51
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('220_' || i::text, (cells_all->>('51_' || i)::text)::numeric);
	
    end loop;
*/
-- C221	D221 =(D215*D216+D219*D220)*(D48*D49)	E221 =(E215*E216+E219*E220)*(E48*E49)	F221 =(F215*F216+F219*F220)*(F48*F49)	G221 =(G215*G216+G219*G220)*(G48*G49)	H221 =(H215*H216+H219*H220)*(H48*H49)
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('221_' || i::text, 
      ((cells_all->>('215_' || i)::text)::numeric *
      (cells_all->>('216_' || i)::text)::numeric + 
      (cells_all->>('219_' || i)::text)::numeric * 
      (cells_all->>('220_' || i)::text)::numeric) * 
      ((cells_all->>('48_' || i)::text)::numeric * 
      (cells_all->>('49_' || i)::text)::numeric));
	
    end loop;
*/
-- C222	D222 =D212+D221	E222 =E212+E221	F222 =F212+F221	G222 =G212+G221	H222 =H212+H221
-- 17Jan2022 D222 =D220*(1+D221)
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('222_' || i::text, 
      (cells_all->>('220_' || i)::text)::numeric * 
     (1+(cells_all->>('221_' || i)::text)::numeric));
	
    end loop;

-- C224		E224 =D224	F224 =E224	G224 =F224	H224 =G224
-- C225		E225 =D225	F225 =E225	G225 =F225	H225 =G225
-- C228		E228 =D228	F228 =E228	G228 =F228	H228 =G228
-- C229	D229 =IF(D4="BAU",D228,0)	E229 =IF(D4="BAU",E228,0)	F229 =F228	G229 =G228	H229 =H228

    for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('229_' || i::text,
     case when (cells_all->>'4_0')::numeric = 3 then (cells_all->>('228_' || i)::text)::numeric else 0 end);
	
    end loop;
   
    for i in 2 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('229_' || i::text, (cells_all->>('228_' || i)::text)::numeric);
	
    end loop;

-- C231		E231 =D231	F231 =E231	G231 =F231	H231 =G231
-- C232		E232 =D232	F232 =E232	G232 =F232	H232 =G232
-- C233	D233 =IF(D4="BAU",D231*D232,0)	E233 =IF(E4="BAU",E231*E232,0)	F233 =F231*F232	G233 =G231*G232	H233 =H231*H232

    for i in 0 .. 1 loop -- ' || i
    
        cells_all := cells_all || to_json_null('233_' || i::text,case when (cells_all->>('4_' || i)::text)::numeric = 3 then 
        (cells_all->>('231_' || i)::text)::numeric * (cells_all->>('232_' || i)::text)::numeric else 0 end);

    end loop;
    
    for i in 2 .. 9 loop -- ' || i
    
        cells_all := cells_all || to_json_null('233_' || i::text, 
        (cells_all->>('231_' || i)::text)::numeric * 
        (cells_all->>('232_' || i)::text)::numeric);
	
    end loop;  

-- C235		E235 =D235	F235 =E235	G235 =F235	H235 =G235

-- C236	D236 =D235*(D194+D208+D222+D226)	    E236 =E235*(E194+E208+E222+E226)	F236 =F235*(F194+F208+F222+F226)	G236 =G235*(G194+G208+G222+G226)	H236 =H235*(H194+H208+H222+H226)
-- 17Jan2022 D236 =IF(D4="BAU",D234*D235,0)
   for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('236_' || i::text, 
      case when (cells_all->>('4_' || i)::text)::numeric = 3 then
      (cells_all->>('234_' || i)::text)::numeric * 
      (cells_all->>('235_' || i)::text)::numeric
      else 0 end);
	
    end loop;
   
    for i in 2 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('236_' || i::text, 
      (cells_all->>('234_' || i)::text)::numeric * 
      (cells_all->>('235_' || i)::text)::numeric);
	
    end loop;

-- C237	D237 =D194+D208+D222+D226+D229+D233+D236	E237 =E194+E208+E222+E226+E229+E233+E236	F237 =F194+F208+F222+F226+F229+F233+F236	G237 =G194+G208+G222+G226+G229+G233+G236	H237 =H194+H208+H222+H226+H229+H233+H236

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('237_' || i::text, 
      (cells_all->>('194_' || i)::text)::numeric +
      (cells_all->>('208_' || i)::text)::numeric +
      (cells_all->>('222_' || i)::text)::numeric +
      (cells_all->>('226_' || i)::text)::numeric +
      (cells_all->>('229_' || i)::text)::numeric +
      (cells_all->>('233_' || i)::text)::numeric +
      (cells_all->>('236_' || i)::text)::numeric);
	
    end loop;

-- C241		E241 =D241	F241 =E241	G241 =F241	H241 =G241
-- C242		E242 =D242	F242 =E242	G242 =F242	H242 =G242

-- C244	D244 =D243	    E244 =E243	F244 =F243	G244 =G243	H244 =H243
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('244_' || i::text, (cells_all->>('243_' || i)::text)::numeric);
	
    end loop;
*/
-- C248	D248 =D89	E248 =E89	F248 =F89	

    for i in 0 .. 2 loop -- ' || i
    
      cells_all := cells_all || to_json_null('248_' || i::text, (cells_all->>('89_' || i)::text)::numeric);
	
    end loop;
	
-- C249	D249 =D116	E249 =E116	F249 =F116	

    for i in 0 .. 2 loop -- ' || i
    
      cells_all := cells_all || to_json_null('249_' || i::text, (cells_all->>('116_' || i)::text)::numeric);
	
    end loop;
	
-- C250	D250 =D248+D249	E250 =E248+E249	F250 =F248+F249	

    for i in 0 .. 2 loop -- ' || i
    
      cells_all := cells_all || to_json_null('250_' || i::text, 
      (cells_all->>('248_' || i)::text)::numeric + 
      (cells_all->>('249_' || i)::text)::numeric);
	
    end loop;
	
-- C252	D252 =D139	E252 =E139	F252 =F139	G252 =G139	H252 =H139
-- 17Jan2022 D252 = D116
    for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('252_' || i::text, (cells_all->>('116_' || i)::text)::numeric);
	
    end loop;

-- C253	D253 =D178	E253 =E178	F253 =F178	G253 =G178	H253 =H178
-- 17Jan2022 D253 =  =D251+D252

    for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('253_' || i::text, 
     (cells_all->>('251_' || i)::text)::numeric + 
     (cells_all->>('252_' || i)::text)::numeric);
	
    end loop;

-- C254	D254 =D237	E254 =E237	F254 =F237	G254 =G237	H254 =H237

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('254_' || i::text, (cells_all->>('237_' || i)::text)::numeric);
	
    end loop;

-- C255	D255 =D244	E255 =E244	F255 =F244	G255 =G244	H255 =H244
-- 17Jan2022 = D139
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('255_' || i::text, (cells_all->>('139_' || i)::text)::numeric);
	
    end loop;

-- C256	D256 =SUM(D252:D255)	E256 =SUM(E252:E255)	F256 =SUM(F252:F255)	G256 =SUM(G252:G255)	H256 =SUM(H252:H255)
-- 17Jan2022 = D181
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('256_' || i::text, 
      (cells_all->>('181_' || i)::text)::numeric);
	
    end loop;

-- C258	D258 =D250+D256	E258 =E250+E256	F258 =F250+F256	G258 =G250+G256	H258 =H250+H256
-- 17Jan2022 = D247

    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('258_' || i::text, 
      (cells_all->>('247_' || i)::text)::numeric);
	
    end loop;
   
-- 17Jan2022 = D259 =SUM(D255:D258)
   for i in 0 .. 9 loop -- ' || i
   
      cells_all := cells_all || to_json_null('259_' || i::text, 
        (cells_all->>('255_' || i)::text)::numeric +
       (cells_all->>('256_' || i)::text)::numeric +
       (cells_all->>('257_' || i)::text)::numeric +
       (cells_all->>('258_' || i)::text)::numeric);
      
	end loop;

-- C261	D261 =SUM(D258:M258)
-- 17Jan2022 D261   =D253+D259
   for i in 0 .. 1 loop -- ' || i
    
      cells_all := cells_all || to_json_null('261_' || i::text, 
      (cells_all->>('253_' || i)::text)::numeric +
      (cells_all->>('259_' || i)::text)::numeric);
	
    end loop;
   for i in 2 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('261_' || i::text, 
      (cells_all->>('259_' || i)::text)::numeric);
	
    end loop;
				
-- C262	D262 ='National Data'!B9				
-- C264		E264 =D264+1	F264 =E264+1	G264 =F264+1	H264 =G264+1
-- 17Jan2022 D264 =SUM(D261:M261)

   cells_all := cells_all || to_json_null('264_0', 
        (cells_all->>'261_0')::numeric +
        (cells_all->>'261_1')::numeric +
		(cells_all->>'261_2')::numeric +
		(cells_all->>'261_3')::numeric +
		(cells_all->>'261_4')::numeric +
		(cells_all->>'261_5')::numeric +
		(cells_all->>'261_6')::numeric +
		(cells_all->>'261_7')::numeric +
		(cells_all->>'261_8')::numeric +
		(cells_all->>'261_9')::numeric);
   
   
-- C265	D265 =PV($D$262,D$264,0,D258)*-1	E265 =PV($D$262,E$264,0,E258)*-1	F265 =PV($D$262,F$264,0,F258)*-1	G265 =PV($D$262,G$264,0,G258)*-1	H265 =PV($D$262,H$264,0,H258)*-1
-- 17Jan2022 no formula
/*
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('265_' || i::text, 
     pv((cells_all->>'262_0')::numeric, 
    (cells_all->>('264_' || i)::text)::numeric, 
   (cells_all->>('258_' || i)::text)::numeric));
    
    end loop;
*/

-- C267	D267 =SUM(D265:M265)
-- 17Jan2022 no formula				
/*
   cells_all := cells_all || to_json_null('267_0'::text, 
   (cells_all->>'265_0')::numeric + 
   (cells_all->>'265_1')::numeric + 
   (cells_all->>'265_2')::numeric + 
   (cells_all->>'265_3')::numeric +
   (cells_all->>'265_4')::numeric + 
   (cells_all->>'265_5')::numeric + 
   (cells_all->>'265_6')::numeric + 
   (cells_all->>'265_7')::numeric +
   (cells_all->>'265_8')::numeric + 
   (cells_all->>'265_9')::numeric);
*/

   -- 17Jan2022 D268 =PV($D$265,D$267,0,D261)*-1
    for i in 0 .. 9 loop -- ' || i
    
      cells_all := cells_all || to_json_null('268_' || i::text, 
     pv((cells_all->>'265_0')::numeric, 
    (cells_all->>('267_' || i)::text)::numeric, 
   (cells_all->>('261_' || i)::text)::numeric));
    
    end loop;  
 

delete from intervention_data_json
where intervention_id = int_id;

insert into intervention_data_json
(intervention_id, intervention_data)
values
(int_id, cells_all);	

end;

$function$
;
