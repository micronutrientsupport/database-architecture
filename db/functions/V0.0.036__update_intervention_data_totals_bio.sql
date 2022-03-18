CREATE OR REPLACE FUNCTION update_intervention_data_totals_bio(int_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

declare 

cells_all jsonb;
test1 integer;
num_var numeric;
fv_id integer;
f_name text;
ii numeric;
rec_var record;

begin
	
	cells_all := get_intervention_data_as_json(int_id);

	select file_name, food_vehicle_id into f_name, fv_id
	from intervention where id = int_id;

	RAISE NOTICE 'f_name: %', f_name;
	RAISE NOTICE 'fv_id: %', fv_id;



--C1		E1 =D1+1	F1 =E1+1	G1 =F1+1	H1 =G1+1
--C4		E4 =D4	F4 =E4		
--C5		E5 =D5	F5 =E5		H5 =G5
--C6		E6 =D6	F6 =E6		H6 =G6
--C7		E7 =D7	F7 =E7		H7 =G7
--C8		E8 =D8	F8 =E8	G8 =F8	H8 =G8
--C11	D11 ='Biofortification targeting'!D10	E11 =D11	F11 =E11	G11 =F11	H11 =G11

	select sum(region_targeted::integer) into num_var
	from fortification_targeting
	where file_name = f_name 
	and food_vehicle_id = fv_id;

	RAISE NOTICE 'num_var: %', num_var;

	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('11_' || i::text, num_var::numeric);
    
    end loop;

--C12	D12 ='Biofortification targeting'!E10	E12 =D12	F12 =E12	G12 =F12	H12 =G12

	select sum(zones_targeted) into num_var
	from fortification_targeting
	where file_name = f_name 
	and food_vehicle_id = fv_id;

	RAISE NOTICE 'num_var: %', num_var;

	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('12_' || i::text, num_var::numeric);
    
    end loop;

--C13	D13 ='IMPACT projections'!D2*'Biofortification targeting'!$H10	E13 ='IMPACT projections'!E2*'Biofortification targeting'!$H10	F13 ='IMPACT projections'!F2*'Biofortification targeting'!$H10	G13 ='IMPACT projections'!G2*'Biofortification targeting'!$H10	H13 ='IMPACT projections'!H2*'Biofortification targeting'!$H10

   select 
   ip.year_0 * ft.regional_share as year_0,
   ip.year_1 * ft.regional_share as year_1,
   ip.year_2 * ft.regional_share as year_2,
   ip.year_3 * ft.regional_share as year_3,
   ip.year_4 * ft.regional_share as year_4,
   ip.year_5 * ft.regional_share as year_5,
   ip.year_6 * ft.regional_share as year_6,
   ip.year_7 * ft.regional_share as year_7,
   ip.year_8 * ft.regional_share as year_8,
   ip.year_9 * ft.regional_share as year_9
   into rec_var
   from
   (select *
   from impact_projections
   where file_name = f_name 
	and food_vehicle_id = fv_id) ip
   cross join
   	(select sum(regional_share_pc) as regional_share
	from fortification_targeting
	where file_name = f_name 
	and food_vehicle_id = fv_id) ft;

	RAISE NOTICE 'rec_var: %', rec_var;
    
	cells_all := cells_all || to_json_null('13_0', rec_var.year_0);
	cells_all := cells_all || to_json_null('13_1', rec_var.year_1);
	cells_all := cells_all || to_json_null('13_2', rec_var.year_2);
	cells_all := cells_all || to_json_null('13_3', rec_var.year_3);
	cells_all := cells_all || to_json_null('13_4', rec_var.year_4);
	cells_all := cells_all || to_json_null('13_5', rec_var.year_5);
	cells_all := cells_all || to_json_null('13_6', rec_var.year_6);
	cells_all := cells_all || to_json_null('13_7', rec_var.year_7);
	cells_all := cells_all || to_json_null('13_8', rec_var.year_8);
	cells_all := cells_all || to_json_null('13_9', rec_var.year_9);
    
   
--C14		E14 =D14	F14 =E14	G14 =F14	H14 =G14
--C15	D15 =D13*(1-D14)	E15 =E13*(1-E14)	F15 =F13*(1-F14)	G15 =G13*(1-G14)	H15 =H13*(1-H14)

	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('15_' || i::text, (cells_all->>('13_' || i)::text)::numeric * (1 - (cells_all->>('14_' || i)::text)::numeric));
    
    end loop;

--C16		E16 =D16	F16 =E16	G16 =F16	H16 =G16
--C17		E17 =D17	F17 =E17	G17 =F17	H17 =G17
--C18		E18 =D18	F18 =E18	G18 =F18	H18 =G18
--C19	D19 =1-SUM(D16:D18)	E19 =1-SUM(E16:E18)	F19 =1-SUM(F16:F18)	G19 =1-SUM(G16:G18)	H19 =1-SUM(H16:H18)
   
	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('19_' || i::text, 
	    1 - ((cells_all->>('16_' || i)::text)::numeric +
	    (cells_all->>('17_' || i)::text)::numeric +
	    (cells_all->>('18_' || i)::text)::numeric));
	end loop;	
   
--C20	D20 =D$15*D16	E20 =E$15*E16	F20 =F$15*F16	G20 =G$15*G16	H20 =H$15*H16

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('20_' || i::text, 
	    (cells_all->>('15_' || i)::text)::numeric *
	    (cells_all->>('16_' || i)::text)::numeric);
	end loop;	

--C21	D21 =D$15*D17	E21 =E$15*E17	F21 =F$15*F17	G21 =G$15*G17	H21 =H$15*H17

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('21_' || i::text, 
	    (cells_all->>('15_' || i)::text)::numeric *
	    (cells_all->>('17_' || i)::text)::numeric);
	end loop;

--C22	D22 =D$15*D18	E22 =E$15*E18	F22 =F$15*F18	G22 =G$15*G18	H22 =H$15*H18

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('22_' || i::text, 
	    (cells_all->>('15_' || i)::text)::numeric *
	    (cells_all->>('18_' || i)::text)::numeric);
	end loop;

--C23	D23 =D$15*D19	E23 =E$15*E19	F23 =F$15*F19	G23 =G$15*G19	H23 =H$15*H19

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('23_' || i::text, 
	    (cells_all->>('15_' || i)::text)::numeric *
	    (cells_all->>('19_' || i)::text)::numeric);
	end loop;

--C27	D27 =D20*D5	E27 =E20*E5	F27 =F20*F5	G27 =G20*G5	H27 =H20*H5

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('27_' || i::text, 
	    (cells_all->>('20_' || i)::text)::numeric *
	    (cells_all->>('5_' || i)::text)::numeric);
	end loop;

--C29	D29 =D21*D6	E29 =E21*E6	F29 =F21*F6	G29 =G21*G6	H29 =H21*H6

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('29_' || i::text, 
	    (cells_all->>('21_' || i)::text)::numeric *
	    (cells_all->>('6_' || i)::text)::numeric);
	end loop;

--C31	D31 =D22*D7	E31 =E22*E7	F31 =F22*F7	G31 =G22*G7	H31 =H22*H7

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('31_' || i::text, 
	    (cells_all->>('22_' || i)::text)::numeric *
	    (cells_all->>('7_' || i)::text)::numeric);
	end loop;

--C33	D33 =D23*D8	E33 =E23*E8	F33 =F23*F8	G33 =G23*G8	H33 =H23*H8

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('33_' || i::text, 
	    (cells_all->>('23_' || i)::text)::numeric *
	    (cells_all->>('8_' || i)::text)::numeric);
	end loop;

--C35	D35 =D27+D29+D31+D33	E35 =E27+E29+E31+E33	F35 =F27+F29+F31+F33	G35 =G27+G29+G31+G33	H35 =H27+H29+H31+H33

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('35_' || i::text, 
	    (cells_all->>('27_' || i)::text)::numeric +
	    (cells_all->>('29_' || i)::text)::numeric +
	    (cells_all->>('31_' || i)::text)::numeric +
	    (cells_all->>('33_' || i)::text)::numeric);
	end loop;

--C36	D36 =D35/D15	E36 =E35/E15	F36 =F35/F15	G36 =G35/G15	H36 =H35/H15

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('36_' || i::text, 
	    (cells_all->>('35_' || i)::text)::numeric /
	    (cells_all->>('15_' || i)::text)::numeric);
	end loop;

--C39	D39 =301*0.00222	E39 =D39	F39 =E39	G39 =F39	H39 =G39
--C40	D40 =254*0.00222	E40 =D40	F40 =E40	G40 =F40	H40 =G40
--C41	D41 =362*0.00222	E41 =D41	F41 =E41	G41 =F41	H41 =G41
--C42		E42 =D42	F42 =E42	G42 =F42	H42 =G42
--C43	D43 =D$42-D39	E43 =E$42-E39	F43 =F$42-F39	G43 =G$42-G39	H43 =H$42-H39

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('43_' || i::text, 
	    (cells_all->>('42_' || i)::text)::numeric -
	    (cells_all->>('39_' || i)::text)::numeric);
	end loop;

--C44	D44 =D$42-D40	E44 =E$42-E40	F44 =F$42-F40	G44 =G$42-G40	H44 =H$42-H40

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('44_' || i::text, 
	    (cells_all->>('42_' || i)::text)::numeric -
	    (cells_all->>('40_' || i)::text)::numeric);
	end loop;

--C45	D45 =D$42-D41	E45 =E$42-E41	F45 =F$42-F41	G45 =G$42-G41	H45 =H$42-H41

	for i in 0 .. 9 loop
	   cells_all := cells_all || to_json_null('45_' || i::text, 
	    (cells_all->>('42_' || i)::text)::numeric -
	    (cells_all->>('41_' || i)::text)::numeric);
	end loop;

--C46	D46 =D$42	E46 =E$42	F46 =F$42	G46 =G$42	H46 =H$42
--C50	D50 =IF(D4="SU",200000*'GDP Deflators'!G62,0)		

--C51	D51 =IF(D4="BAU",0,15000)		

	cells_all := cells_all || to_json_null('51_0'::text,
	case 
	when (cells_all->>'4_0')::numeric = 3 then 0
	else 15000 end);

--C52	D52 =IF(D4="BAU",0,10000)	

	cells_all := cells_all || to_json_null('52_0'::text,
	case 
	when (cells_all->>'4_0')::numeric = 3 then 0
	else 10000 end);

--C53	D53 =IF(D4="SU", 10000,IF(D4="SC",5000,0))		

	cells_all := cells_all || to_json_null('53_0'::text,
	case 
	when (cells_all->>'4_0')::numeric = 1 then 10000
	when (cells_all->>'4_0')::numeric = 2 then 5000
	else 0 end);

--C54	D54 =SUM(D50:D53)	E54 =SUM(E50:E53)	F54 =SUM(F50:F53)	

	for i in 0 .. 2 loop
	   cells_all := cells_all || to_json_null('54_' || i::text, 
	    (cells_all->>('50_' || i)::text)::numeric +
	    (cells_all->>('51_' || i)::text)::numeric +
	    (cells_all->>('52_' || i)::text)::numeric +
	    (cells_all->>('53_' || i)::text)::numeric);
	end loop;

--C56		E56 =18460*'GDP Deflators'!L38	F56 =18460*'GDP Deflators'!L38		
--C57		E57 =IF(D4="BAU",0,3)	F57 =IF(D4="BAU",0,3)		
--C58	D58 =D56*D57	E58 =E56*E57	F58 =F56*F57		
--C61		E61 =IF(D4="BAU",0,E12)	F61 =IF(D4="BAU",0,E12)		
--C62	D62 =D60*D61	E62 =E60*E61	F62 =F60*F61		
--C65		E65 =IF(D4="BAU",0,3)	F65 =IF(D4="BAU",0,3)		
--C66	D66 =D64*D65	E66 =E64*E65	F66 =F64*F65		
--C68		E68 =6500*'GDP Deflators'!L38			
--C69		E69 =IF(D4="BAU",0,E12)			
--C70	D70 =D68*D69	E70 =E68*E69	F70 =F68*F69		
--C72		E72 =1100*'GDP Deflators'!L38	F72 =1100*'GDP Deflators'!L38		
--C73		E73 =IF(D4="BAU",0,E12)	F73 =IF(D4="BAU",0,F12)		
--C74	D74 =D72*D73	E74 =E72*E73	F74 =F72*F73		
--C77		E77 =IF(D4="BAU",0,E12)	F77 =IF(D4="BAU",0,F12)		
--C78	D78 =D76*D77	E78 =E76*E77	F78 =F76*F77		
--C79	D79 =D78+D74+D70+D66+D62+D58+D54	E79 =E78+E74+E70+E66+E62+E58+E54	F79 =F78+F74+F70+F66+F62+F58+F54		
--C83	D83 =80000*'GDP Deflators'!G38	E83 =D83	F83 =E83	G83 =F83	H83 =G83
--C84	D84 =IF(D4="SU",0,D83)	E84 =IF(D4="SU",0,E83)	F84 =IF(D4="SU",0,F83)	G84 =G83	H84 =H83
--C86	D86 =D27	E86 =E27	F86 =F27	G86 =G27	H86 =H27
--C87	D87 =D43	E87 =E43	F87 =F43	G87 =G43	H87 =H43
--C88		E88 =D88	F88 =E88	G88 =F88	H88 =G88
--C89	D89 =D86*(D87*D88)	E89 =E86*(E87*E88)	F89 =F86*(F87*F88)	G89 =G86*(G87*G88)	H89 =H86*(H87*H88)
--C90	D90 =D29	E90 =E29	F90 =F29	G90 =G29	H90 =H29
--C91	D91 =D44	E91 =E47	F91 =F47	G91 =G47	H91 =H47
--C92		E92 =D92	F92 =E92	G92 =F92	H92 =G92
--C93	D93 =D90*(D91*D92)	E93 =E90*(E91*E92)	F93 =F90*(F91*F92)	G93 =G90*(G91*G92)	H93 =H90*(H91*H92)
--C94	D94 =D31	E94 =E31	F94 =F31	G94 =G31	H94 =H31
--C95	D95 =D45	E95 =E45	F95 =F45	G95 =G45	H95 =H45
--C96		E96 =D96	F96 =E96	G96 =F96	H96 =G96
--C97	D97 =D94*(D95*D96)	E97 =E94*(E95*E96)	F97 =F94*(F95*F96)	G97 =G94*(G95*G96)	H97 =H94*(H95*H96)
--C98	D98 =D33	E98 =E33	F98 =F33	G98 =G33	H98 =H33
--C99	D99 =D46	E99 =E49	F99 =F49	G99 =G49	H99 =H49
--C100		E100 =D100	F100 =E100	G100 =F100	H100 =G100
--C101	D101 =D98*(D99*D100)	E101 =E98*(E99*E100)	F101 =F98*(F99*F100)	G101 =G98*(G99*G100)	H101 =H98*(H99*H100)
--C102	D102 =D89+D93+D97+D101	E102 =E89+E93+E97+E101	F102 =F89+F93+F97+F101	G102 =G89+G93+G97+G101	H102 =H89+H93+H97+H101
--C104	D104 =IF(D36=0,0,IF(AND(D36>0,D36<0.1),0.25,IF(AND(D36>=0.1,D36<0.25),0.5,IF(AND(D36>=0.25,D36<0.5),0.75,1))))	E104 =IF(E36=0,0,IF(AND(E36>0,E36<0.1),0.25,IF(AND(E36>=0.1,E36<0.25),0.5,IF(AND(E36>=0.25,E36<0.5),0.75,1))))	F104 =IF(F36=0,0,IF(AND(F36>0,F36<0.1),0.25,IF(AND(F36>=0.1,F36<0.25),0.5,IF(AND(F36>=0.25,F36<0.5),0.75,1))))	G104 =IF(G36=0,0,IF(AND(G36>0,G36<0.1),0.25,IF(AND(G36>=0.1,G36<0.25),0.5,IF(AND(G36>=0.25,G36<0.5),0.75,1))))	H104 =IF(H36=0,0,IF(AND(H36>0,H36<0.1),0.25,IF(AND(H36>=0.1,H36<0.25),0.5,IF(AND(H36>=0.25,H36<0.5),0.75,1))))
--C105	D105 =D12	E105 =E12	F105 =F12	G105 =G12	H105 =H12
--C106	D106 =2*'National Data'!$B$9	E106 =D106*(1+'National Data'!$B$25)	F106 =E106*(1+'National Data'!$B$25)	G106 =F106*(1+'National Data'!$B$25)	H106 =G106*(1+'National Data'!$B$25)
--C107	D107 =D104*D105*D106	E107 =E104*E105*E106	F107 =F104*F105*F106	G107 =G104*G105*G106	H107 =H104*H105*H106
--C108	D108 =D107	E108 =E107	F108 =F107	G108 =G107	H108 =H107
--C110	D110 =5940*'GDP Deflators'!L38	E110 =D110	F110 =E110	G110 =F110	H110 =G110
--C111		E111 =D111	F111 =E111	G111 =F111	H111 =G111
--C112	D112 =IF($D4="BAU",D110*D111,0)	E112 =IF($D4="BAU",E110*E111,0)	F112 =IF($D4="BAU",F110*F111,0)	G112 =G110*G111	H112 =H110*H111
--C114		E114 =D114	F114 =E114	G114 =F114	H114 =G114
--C115		E115 =D115	F115 =E115	G115 =F115	H115 =G115
--C116	D116 =IF($D8="BAU",D114*D115,0)	E116 =IF($D8="BAU",E114*E115,0)	F116 =IF($D8="BAU",F114*F115,0)	G116 =G114*G115	H116 =H114*H115
--C118		E118 =D118	F118 =E118	G118 =F118	H118 =G118
--C119	D119 =D118*(D84+D108+D112+D116)	E119 =E118*(E84+E108+E112+E116)	F119 =F118*(F84+F108+F112+F116)	G119 =G118*(G84+G108+G112+G116)	H119 =H118*(H84+H108+H112+H116)
--C120	D120 =1	E120 =D120	F120 =E120	G120 =F120	H120 =G120
--C121	D121 =3*'National Data'!$B$9	E121 =D121*(1+'National Data'!$B$25)	F121 =E121*(1+'National Data'!$B$25)	G121 =F121*(1+'National Data'!$B$25)	H121 =G121*(1+'National Data'!$B$25)
--C122	D122 =D120*D121	E122 =E120*E121	F122 =F120*F121	G122 =G120*G121	H122 =H120*H121
--C123	D123 =1	E123 =1	F123 =1	G123 =1	H123 =1
--C124	D124 =2.5*'National Data'!$B$9	E124 =D124*(1+'National Data'!$B$25)	F124 =E124*(1+'National Data'!$B$25)	G124 =F124*(1+'National Data'!$B$25)	H124 =G124*(1+'National Data'!$B$25)
--C125	D125 =D123*D124	E125 =E123*E124	F125 =F123*F124	G125 =G123*G124	H125 =H123*H124
--C126	D126 =IF(D4="SU",0,D119+D122+D125)	E126 =IF(E4="SU",0,E119+E122+E125)	F126 =IF(F4="SU",0,F119+F122+F125)	G126 =IF(G4="SU",0,G119+G122+G125)	H126 =IF(H4="SU",0,H119+H122+H125)
--C127	D127 =D84+D102+D108+D112+D116+D126	E127 =E84+E102+E108+E112+E116+E126	F127 =F84+F102+F108+F112+F116+F126	G127 =G84+G102+G108+G112+G116+G126	H127 =H84+H102+H108+H112+H116+H126
--C131		E131 =D131	F131 =E131	G131 =F131	H131 =G131
--C132		E132 =D132	F132 =E132	G132 =F132	H132 =G132
--C134	D134 =D133	E134 =E133	F134 =F133	G134 =G133	H134 =H133
--C138	D138 =D79	E138 =E79	F138 =F79		
--C139	D139 =D127	E139 =E127	F139 =F127	G139 =G127	H139 =H127
--C140	D140 =D134	E140 =E134	F140 =F134	G140 =G134	H140 =H134
--C141	D141 =D138+D139+D140	E141 =E138+E139+E140	F141 =F138+F139+F140	G141 =G139+G140	H141 =H139+H140
--C142	D142 =SUM(D141:M141)				
--C144	D144 =AVERAGE(D141:M141)				
--C145	D145 =IF(D4="SU",AVERAGE(G141:M141)+SUM(D138:F138)/7,AVERAGE(D141:M141))				
--C148	D148 ='National Data'!B12				
--C149		E149 =D149+1	F149 =E149+1	G149 =F149+1	H149 =G149+1
--C150	D150 =PV($D148,D149,0,D141)*-1	E150 =PV($D148,E149,0,E141)*-1	F150 =PV($D148,F149,0,F141)*-1	G150 =PV($D148,G149,0,G141)*-1	H150 =PV($D148,H149,0,H141)*-1
--C151	D151 =SUM(D150:M150)				
--C153	D153 =AVERAGE(D150:M150)				
--C154	D154 =IF(D4="SU",AVERAGE(G150:M150)+SUM(D150:F150)/7,AVERAGE(D150:M150))				
--C158	D158 =D$141*'Biofortification targeting'!$H2	E158 =E$141*'Biofortification targeting'!$H2	F158 =F$141*'Biofortification targeting'!$H2	G158 =G$141*'Biofortification targeting'!$H2	H158 =H$141*'Biofortification targeting'!$H2
--C159	D159 =D$141*'Biofortification targeting'!$H3	E159 =E$141*'Biofortification targeting'!$H3	F159 =F$141*'Biofortification targeting'!$H3	G159 =G$141*'Biofortification targeting'!$H3	H159 =H$141*'Biofortification targeting'!$H3
--C160	D160 =D$141*'Biofortification targeting'!$H4	E160 =E$141*'Biofortification targeting'!$H4	F160 =F$141*'Biofortification targeting'!$H4	G160 =G$141*'Biofortification targeting'!$H4	H160 =H$141*'Biofortification targeting'!$H4
--C161	D161 =D$141*'Biofortification targeting'!$H5	E161 =E$141*'Biofortification targeting'!$H5	F161 =F$141*'Biofortification targeting'!$H5	G161 =G$141*'Biofortification targeting'!$H5	H161 =H$141*'Biofortification targeting'!$H5
--C162	D162 =D$141*'Biofortification targeting'!$H6	E162 =E$141*'Biofortification targeting'!$H6	F162 =F$141*'Biofortification targeting'!$H6	G162 =G$141*'Biofortification targeting'!$H6	H162 =H$141*'Biofortification targeting'!$H6
--C163	D163 =D$141*'Biofortification targeting'!$H7	E163 =E$141*'Biofortification targeting'!$H7	F163 =F$141*'Biofortification targeting'!$H7	G163 =G$141*'Biofortification targeting'!$H7	H163 =H$141*'Biofortification targeting'!$H7
--C164	D164 =D$141*'Biofortification targeting'!$H8	E164 =E$141*'Biofortification targeting'!$H8	F164 =F$141*'Biofortification targeting'!$H8	G164 =G$141*'Biofortification targeting'!$H8	H164 =H$141*'Biofortification targeting'!$H8
--C165	D165 =D$141*'Biofortification targeting'!$H9	E165 =E$141*'Biofortification targeting'!$H9	F165 =F$141*'Biofortification targeting'!$H9	G165 =G$141*'Biofortification targeting'!$H9	H165 =H$141*'Biofortification targeting'!$H9
--C195	D195 =PV($D$148,D$149,0,D158)*-1	E195 =PV($D$148,E$149,0,E158)*-1	F195 =PV($D$148,F$149,0,F158)*-1	G195 =PV($D$148,G$149,0,G158)*-1	H195 =PV($D$148,H$149,0,H158)*-1
--C196	D196 =PV($D$148,D$149,0,D159)*-1	E196 =PV($D$148,E$149,0,E159)*-1	F196 =PV($D$148,F$149,0,F159)*-1	G196 =PV($D$148,G$149,0,G159)*-1	H196 =PV($D$148,H$149,0,H159)*-1
--C197	D197 =PV($D$148,D$149,0,D160)*-1	E197 =PV($D$148,E$149,0,E160)*-1	F197 =PV($D$148,F$149,0,F160)*-1	G197 =PV($D$148,G$149,0,G160)*-1	H197 =PV($D$148,H$149,0,H160)*-1
--C198	D198 =PV($D$148,D$149,0,D161)*-1	E198 =PV($D$148,E$149,0,E161)*-1	F198 =PV($D$148,F$149,0,F161)*-1	G198 =PV($D$148,G$149,0,G161)*-1	H198 =PV($D$148,H$149,0,H161)*-1
--C199	D199 =PV($D$148,D$149,0,D162)*-1	E199 =PV($D$148,E$149,0,E162)*-1	F199 =PV($D$148,F$149,0,F162)*-1	G199 =PV($D$148,G$149,0,G162)*-1	H199 =PV($D$148,H$149,0,H162)*-1
--C200	D200 =PV($D$148,D$149,0,D163)*-1	E200 =PV($D$148,E$149,0,E163)*-1	F200 =PV($D$148,F$149,0,F163)*-1	G200 =PV($D$148,G$149,0,G163)*-1	H200 =PV($D$148,H$149,0,H163)*-1
--C201	D201 =PV($D$148,D$149,0,D164)*-1	E201 =PV($D$148,E$149,0,E164)*-1	F201 =PV($D$148,F$149,0,F164)*-1	G201 =PV($D$148,G$149,0,G164)*-1	H201 =PV($D$148,H$149,0,H164)*-1
--C202	D202 =PV($D$148,D$149,0,D165)*-1	E202 =PV($D$148,E$149,0,E165)*-1	F202 =PV($D$148,F$149,0,F165)*-1	G202 =PV($D$148,G$149,0,G165)*-1	H202 =PV($D$148,H$149,0,H165)*-1
--C232	D232 =SUM(D195:M195)				
--C233	D233 =SUM(D196:M196)				
--C234	D234 =SUM(D197:M197)				
--C235	D235 =SUM(D198:M198)				
--C236	D236 =SUM(D199:M199)				
--C237	D237 =SUM(D200:M200)				
--C238	D238 =SUM(D201:M201)				
--C239	D239 =SUM(D202:M202)						




delete from intervention_data_json
where intervention_id = int_id;

insert into intervention_data_json
(intervention_id, intervention_data)
values
(int_id, cells_all);	

end;

$function$
;

comment on function update_intervention_data_totals is 'This function takes all the intervention costing data as json,from one intervention and recalculates all the totals where a formula is applied, as copied and translated from the excel work sheet.';
