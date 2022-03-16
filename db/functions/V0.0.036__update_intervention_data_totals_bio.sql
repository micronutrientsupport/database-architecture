CREATE OR REPLACE FUNCTION update_intervention_data_totals_bio(int_id integer)
 RETURNS void
 LANGUAGE plpgsql
AS $function$

declare 

cells_all jsonb;

test1 integer;

num_var numeric;

ii numeric;

begin
	
cells_all := get_intervention_data_as_json(int_id);


-- C1		E1 =D1+1	F1 =E1+1	G1 =F1+1	H1 =G1+1
-- C4		E4 =D4	F4 =E4		
-- C5		E5 =D5	F5 =E5		H5 =G5
-- C6		E6 =D6	F6 =E6		H6 =G6
-- C7		E7 =D7	F7 =E7		H7 =G7
-- C8		E8 =D8	F8 =E8	G8 =F8	H8 =G8
-- C11	D11 ='Biofortification targeting'!B35	E11 =D11	F11 =E11	G11 =F11	H11 =G11
-- C12	D12 ='Biofortification targeting'!C35	E12 =D12	F12 =E12	G12 =F12	H12 =G12
-- C13	D13 ='IMPACT projections'!B2*'Biofortification targeting'!$F35	E13 ='IMPACT projections'!C2*'Biofortification targeting'!$F35	F13 ='IMPACT projections'!D2*'Biofortification targeting'!$F35	G13 ='IMPACT projections'!E2*'Biofortification targeting'!$F35	H13 ='IMPACT projections'!F2*'Biofortification targeting'!$F35
-- C14		E14 =D14	F14 =E14	G14 =F14	H14 =G14

-- C15	D15 =D13*(1-D14)	E15 =E13*(1-E14)	F15 =F13*(1-F14)	G15 =G13*(1-G14)	H15 =H13*(1-H14)

	for i in 0 .. 9 loop
    
        cells_all := cells_all || to_json_null('15_' || i::text, (cells_all->>('13_' || i)::text)::numeric * (1 - (cells_all->>('14_' || i)::text)::numeric));
    
    end loop;

-- C16		E16 =D16	F16 =E16	G16 =F16	H16 =G16
-- C17		E17 =D17	F17 =E17	G17 =F17	H17 =G17
-- C18		E18 =D18	F18 =E18	G18 =F18	H18 =G18
   
-- C19	D19 =1-SUM(D16:D18)	E19 =1-SUM(E16:E18)	F19 =1-SUM(F16:F18)	G19 =1-SUM(G16:G18)	H19 =1-SUM(H16:H18)
   
   
   
-- C20	D20 =D$15*D16	E20 =E$15*E16	F20 =F$15*F16	G20 =G$15*G16	H20 =H$15*H16
-- C21	D21 =D$15*D17	E21 =E$15*E17	F21 =F$15*F17	G21 =G$15*G17	H21 =H$15*H17
-- C22	D22 =D$15*D18	E22 =E$15*E18	F22 =F$15*F18	G22 =G$15*G18	H22 =H$15*H18
-- C23	D23 =D$15*D19	E23 =E$15*E19	F23 =F$15*F19	G23 =G$15*G19	H23 =H$15*H19
-- C27	D27 =D20*D5	E27 =E20*E5	F27 =F20*F5	G27 =G20*G5	H27 =H20*H5
-- C29	D29 =D21*D6	E29 =E21*E6	F29 =F21*F6	G29 =G21*G6	H29 =H21*H6
-- C31	D31 =D22*D7	E31 =E22*E7	F31 =F22*F7	G31 =G22*G7	H31 =H22*H7
-- C33	D33 =D23*D8	E33 =E23*E8	F33 =F23*F8	G33 =G23*G8	H33 =H23*H8
-- C35	D35 =D27+D29+D31+D33	E35 =E27+E29+E31+E33	F35 =F27+F29+F31+F33	G35 =G27+G29+G31+G33	H35 =H27+H29+H31+H33
-- C36	D36 =D35/D15	E36 =E35/E15	F36 =F35/F15	G36 =G35/G15	H36 =H35/H15
-- C39	D39 =301*0.00222	E39 =D39	F39 =E39	G39 =F39	H39 =G39
-- C40	D40 =254*0.00222	E40 =D40	F40 =E40	G40 =F40	H40 =G40
-- C41	D41 =362*0.00222	E41 =D41	F41 =E41	G41 =F41	H41 =G41
-- C42		E42 =D42	F42 =E42	G42 =F42	H42 =G42
-- C43	D43 =D$42-D39	E43 =E$42-E39	F43 =F$42-F39	G43 =G$42-G39	H43 =H$42-H39
-- C44	D44 =D$42-D40	E44 =E$42-E40	F44 =F$42-F40	G44 =G$42-G40	H44 =H$42-H40
-- C45	D45 =D$42-D41	E45 =E$42-E41	F45 =F$42-F41	G45 =G$42-G41	H45 =H$42-H41
-- C46	D46 =D$42	E46 =E$42	F46 =F$42	G46 =G$42	H46 =H$42
-- C50	D50 =IF(D4="SU",200000*'GDP Deflators'!G62,0)				
-- C51	D51 =IF(D4="BAU",0,15000)				
-- C52	D52 =IF(D4="BAU",0,10000)				
-- C53	D53 =IF(D4="SU", 10000,IF(D4="SC",5000,0))				
-- C54	D54 =SUM(D50:D53)	E54 =SUM(E50:E53)	F54 =SUM(F50:F53)		
-- C56		E56 =18460*'GDP Deflators'!L38	F56 =18460*'GDP Deflators'!L38		
-- C57		E57 =IF(D4="BAU",0,3)	F57 =IF(D4="BAU",0,3)		
-- C58	D58 =D56*D57	E58 =E56*E57	F58 =F56*F57		
-- C61		E61 =IF(D4="BAU",0,E12)	F61 =IF(D4="BAU",0,E12)		
-- C62	D62 =D60*D61	E62 =E60*E61	F62 =F60*F61		
-- C65		E65 =IF(D4="BAU",0,3)	F65 =IF(D4="BAU",0,3)		
-- C66	D66 =D64*D65	E66 =E64*E65	F66 =F64*F65		
-- C68		E68 =6500*'GDP Deflators'!L38			
-- C69		E69 =IF(D4="BAU",0,E12)			
-- C70	D70 =D68*D69	E70 =E68*E69	F70 =F68*F69		
-- C72		E72 =1100*'GDP Deflators'!L38	F72 =1100*'GDP Deflators'!L38		
-- C73		E73 =IF(D4="BAU",0,E12)	F73 =IF(D4="BAU",0,F12)		
-- C74	D74 =D72*D73	E74 =E72*E73	F74 =F72*F73		
-- C77		E77 =IF(D4="BAU",0,E12)	F77 =IF(D4="BAU",0,F12)		
-- C78	D78 =D76*D77	E78 =E76*E77	F78 =F76*F77		
-- C79	D79 =D78+D74+D70+D66+D62+D58+D54	E79 =E78+E74+E70+E66+E62+E58+E54	F79 =F78+F74+F70+F66+F62+F58+F54		
-- C83	D83 =80000*'GDP Deflators'!G38	E83 =D83	F83 =E83	G83 =F83	H83 =G83
-- C84	D84 =IF(D4="SU",0,D83)	E84 =IF(D4="SU",0,E83)	F84 =IF(D4="SU",0,F83)	G84 =G83	H84 =H83
-- C86	D86 =D27	E86 =E27	F86 =F27	G86 =G27	H86 =H27
-- C87	D87 =D43	E87 =E43	F87 =F43	G87 =G43	H87 =H43
-- C88		E88 =D88	F88 =E88	G88 =F88	H88 =G88
-- C89	D89 =D86*(D87*D88)	E89 =E86*(E87*E88)	F89 =F86*(F87*F88)	G89 =G86*(G87*G88)	H89 =H86*(H87*H88)
-- C90	D90 =D29	E90 =E29	F90 =F29	G90 =G29	H90 =H29
-- C91	D91 =D44	E91 =E47	F91 =F47	G91 =G47	H91 =H47
-- C92		E92 =D92	F92 =E92	G92 =F92	H92 =G92
-- C93	D93 =D90*(D91*D92)	E93 =E90*(E91*E92)	F93 =F90*(F91*F92)	G93 =G90*(G91*G92)	H93 =H90*(H91*H92)
-- C94	D94 =D31	E94 =E31	F94 =F31	G94 =G31	H94 =H31
-- C95	D95 =D45	E95 =E45	F95 =F45	G95 =G45	H95 =H45
-- C96		E96 =D96	F96 =E96	G96 =F96	H96 =G96
-- C97	D97 =D94*(D95*D96)	E97 =E94*(E95*E96)	F97 =F94*(F95*F96)	G97 =G94*(G95*G96)	H97 =H94*(H95*H96)
-- C98	D98 =D33	E98 =E33	F98 =F33	G98 =G33	H98 =H33
-- C99	D99 =D46	E99 =E49	F99 =F49	G99 =G49	H99 =H49
-- C100		E100 =D100	F100 =E100	G100 =F100	H100 =G100
-- C101	D101 =D98*(D99*D100)	E101 =E98*(E99*E100)	F101 =F98*(F99*F100)	G101 =G98*(G99*G100)	H101 =H98*(H99*H100)
-- C102	D102 =D89+D93+D97+D101	E102 =E89+E93+E97+E101	F102 =F89+F93+F97+F101	G102 =G89+G93+G97+G101	H102 =H89+H93+H97+H101
-- C104	D104 =IF(D36=0,0,IF(AND(D36>0,D36<0.1),0.25,IF(AND(D36>=0.1,D36<0.25),0.5,IF(AND(D36>=0.25,D36<0.5),0.75,1))))	E104 =IF(E36=0,0,IF(AND(E36>0,E36<0.1),0.25,IF(AND(E36>=0.1,E36<0.25),0.5,IF(AND(E36>=0.25,E36<0.5),0.75,1))))	F104 =IF(F36=0,0,IF(AND(F36>0,F36<0.1),0.25,IF(AND(F36>=0.1,F36<0.25),0.5,IF(AND(F36>=0.25,F36<0.5),0.75,1))))	G104 =IF(G36=0,0,IF(AND(G36>0,G36<0.1),0.25,IF(AND(G36>=0.1,G36<0.25),0.5,IF(AND(G36>=0.25,G36<0.5),0.75,1))))	H104 =IF(H36=0,0,IF(AND(H36>0,H36<0.1),0.25,IF(AND(H36>=0.1,H36<0.25),0.5,IF(AND(H36>=0.25,H36<0.5),0.75,1))))
-- C105	D105 =D12	E105 =E12	F105 =F12	G105 =G12	H105 =H12
-- C106	D106 =2*'National Data'!$B$9	E106 =D106*(1+'National Data'!$B$25)	F106 =E106*(1+'National Data'!$B$25)	G106 =F106*(1+'National Data'!$B$25)	H106 =G106*(1+'National Data'!$B$25)
-- C107	D107 =D104*D105*D106	E107 =E104*E105*E106	F107 =F104*F105*F106	G107 =G104*G105*G106	H107 =H104*H105*H106
-- C108	D108 =D107	E108 =E107	F108 =F107	G108 =G107	H108 =H107
-- C110	D110 =5940*'GDP Deflators'!L38	E110 =D110	F110 =E110	G110 =F110	H110 =G110
-- C111		E111 =D111	F111 =E111	G111 =F111	H111 =G111
-- C112	D112 =IF($D4="BAU",D110*D111,0)	E112 =IF($D4="BAU",E110*E111,0)	F112 =IF($D4="BAU",F110*F111,0)	G112 =G110*G111	H112 =H110*H111
-- C114		E114 =D114	F114 =E114	G114 =F114	H114 =G114
-- C115		E115 =D115	F115 =E115	G115 =F115	H115 =G115
-- C116	D116 =IF($D8="BAU",D114*D115,0)	E116 =IF($D8="BAU",E114*E115,0)	F116 =IF($D8="BAU",F114*F115,0)	G116 =G114*G115	H116 =H114*H115
-- C118		E118 =D118	F118 =E118	G118 =F118	H118 =G118
-- C119	D119 =D118*(D84+D108+D112+D116)	E119 =E118*(E84+E108+E112+E116)	F119 =F118*(F84+F108+F112+F116)	G119 =G118*(G84+G108+G112+G116)	H119 =H118*(H84+H108+H112+H116)
-- C120	D120 =1	E120 =D120	F120 =E120	G120 =F120	H120 =G120
-- C121	D121 =3*'National Data'!$B$9	E121 =D121*(1+'National Data'!$B$25)	F121 =E121*(1+'National Data'!$B$25)	G121 =F121*(1+'National Data'!$B$25)	H121 =G121*(1+'National Data'!$B$25)
-- C122	D122 =D120*D121	E122 =E120*E121	F122 =F120*F121	G122 =G120*G121	H122 =H120*H121
-- C123	D123 =1	E123 =1	F123 =1	G123 =1	H123 =1
-- C124	D124 =2.5*'National Data'!$B$9	E124 =D124*(1+'National Data'!$B$25)	F124 =E124*(1+'National Data'!$B$25)	G124 =F124*(1+'National Data'!$B$25)	H124 =G124*(1+'National Data'!$B$25)
-- C125	D125 =D123*D124	E125 =E123*E124	F125 =F123*F124	G125 =G123*G124	H125 =H123*H124
-- C126	D126 =IF(D4="SU",0,D119+D122+D125)	E126 =IF(E4="SU",0,E119+E122+E125)	F126 =IF(F4="SU",0,F119+F122+F125)	G126 =IF(G4="SU",0,G119+G122+G125)	H126 =IF(H4="SU",0,H119+H122+H125)
-- C127	D127 =D84+D102+D108+D112+D116+D126	E127 =E84+E102+E108+E112+E116+E126	F127 =F84+F102+F108+F112+F116+F126	G127 =G84+G102+G108+G112+G116+G126	H127 =H84+H102+H108+H112+H116+H126
-- C131		E131 =D131	F131 =E131	G131 =F131	H131 =G131
-- C132		E132 =D132	F132 =E132	G132 =F132	H132 =G132
-- C134	D134 =D133	E134 =E133	F134 =F133	G134 =G133	H134 =H133
-- C137	D137 =D79	E137 =E79	F137 =F79		
-- C138	D138 =D127	E138 =E127	F138 =F127	G138 =G127	H138 =H127
-- C139	D139 =D134	E139 =E134	F139 =F134	G139 =G134	H139 =H134
-- C141	D141 =D137+D138+D139	E141 =E137+E138+E139	F141 =F137+F138+F139	G141 =G138+G139	H141 =H138+H139
-- C144	D144 =SUM(D141:M141)				
-- C145	D145 ='National Data'!B12				
-- C147		E147 =D147+1	F147 =E147+1	G147 =F147+1	H147 =G147+1
-- C148	D148 =PV($D145,D147,0,D141)*-1	E148 =PV($D145,E147,0,E141)*-1	F148 =PV($D145,F147,0,F141)*-1	G148 =PV($D145,G147,0,G141)*-1	H148 =PV($D145,H147,0,H141)*-1
-- C150	D150 =SUM(D148:M148)				
-- C154	D154 =D$141*'Biofortification targeting'!$F3	E154 =E$141*'Biofortification targeting'!$F3	F154 =F$141*'Biofortification targeting'!$F3	G154 =G$141*'Biofortification targeting'!$F3	H154 =H$141*'Biofortification targeting'!$F3
-- C155	D155 =D$141*'Biofortification targeting'!$F4	E155 =E$141*'Biofortification targeting'!$F4	F155 =F$141*'Biofortification targeting'!$F4	G155 =G$141*'Biofortification targeting'!$F4	H155 =H$141*'Biofortification targeting'!$F4
-- C156	D156 =D$141*'Biofortification targeting'!$F5	E156 =E$141*'Biofortification targeting'!$F5	F156 =F$141*'Biofortification targeting'!$F5	G156 =G$141*'Biofortification targeting'!$F5	H156 =H$141*'Biofortification targeting'!$F5
-- C157	D157 =D$141*'Biofortification targeting'!$F6	E157 =E$141*'Biofortification targeting'!$F6	F157 =F$141*'Biofortification targeting'!$F6	G157 =G$141*'Biofortification targeting'!$F6	H157 =H$141*'Biofortification targeting'!$F6
-- C158	D158 =D$141*'Biofortification targeting'!$F7	E158 =E$141*'Biofortification targeting'!$F7	F158 =F$141*'Biofortification targeting'!$F7	G158 =G$141*'Biofortification targeting'!$F7	H158 =H$141*'Biofortification targeting'!$F7
-- C159	D159 =D$141*'Biofortification targeting'!$F8	E159 =E$141*'Biofortification targeting'!$F8	F159 =F$141*'Biofortification targeting'!$F8	G159 =G$141*'Biofortification targeting'!$F8	H159 =H$141*'Biofortification targeting'!$F8
-- C160	D160 =D$141*'Biofortification targeting'!$F9	E160 =E$141*'Biofortification targeting'!$F9	F160 =F$141*'Biofortification targeting'!$F9	G160 =G$141*'Biofortification targeting'!$F9	H160 =H$141*'Biofortification targeting'!$F9
-- C161	D161 =D$141*'Biofortification targeting'!$F10	E161 =E$141*'Biofortification targeting'!$F10	F161 =F$141*'Biofortification targeting'!$F10	G161 =G$141*'Biofortification targeting'!$F10	H161 =H$141*'Biofortification targeting'!$F10
-- C162	D162 =D$141*'Biofortification targeting'!$F11	E162 =E$141*'Biofortification targeting'!$F11	F162 =F$141*'Biofortification targeting'!$F11	G162 =G$141*'Biofortification targeting'!$F11	H162 =H$141*'Biofortification targeting'!$F11
-- C163	D163 =D$141*'Biofortification targeting'!$F12	E163 =E$141*'Biofortification targeting'!$F12	F163 =F$141*'Biofortification targeting'!$F12	G163 =G$141*'Biofortification targeting'!$F12	H163 =H$141*'Biofortification targeting'!$F12
-- C164	D164 =D$141*'Biofortification targeting'!$F13	E164 =E$141*'Biofortification targeting'!$F13	F164 =F$141*'Biofortification targeting'!$F13	G164 =G$141*'Biofortification targeting'!$F13	H164 =H$141*'Biofortification targeting'!$F13
-- C165	D165 =D$141*'Biofortification targeting'!$F14	E165 =E$141*'Biofortification targeting'!$F14	F165 =F$141*'Biofortification targeting'!$F14	G165 =G$141*'Biofortification targeting'!$F14	H165 =H$141*'Biofortification targeting'!$F14
-- C166	D166 =D$141*'Biofortification targeting'!$F15	E166 =E$141*'Biofortification targeting'!$F15	F166 =F$141*'Biofortification targeting'!$F15	G166 =G$141*'Biofortification targeting'!$F15	H166 =H$141*'Biofortification targeting'!$F15
-- C167	D167 =D$141*'Biofortification targeting'!$F16	E167 =E$141*'Biofortification targeting'!$F16	F167 =F$141*'Biofortification targeting'!$F16	G167 =G$141*'Biofortification targeting'!$F16	H167 =H$141*'Biofortification targeting'!$F16
-- C168	D168 =D$141*'Biofortification targeting'!$F17	E168 =E$141*'Biofortification targeting'!$F17	F168 =F$141*'Biofortification targeting'!$F17	G168 =G$141*'Biofortification targeting'!$F17	H168 =H$141*'Biofortification targeting'!$F17
-- C169	D169 =D$141*'Biofortification targeting'!$F18	E169 =E$141*'Biofortification targeting'!$F18	F169 =F$141*'Biofortification targeting'!$F18	G169 =G$141*'Biofortification targeting'!$F18	H169 =H$141*'Biofortification targeting'!$F18
-- C170	D170 =D$141*'Biofortification targeting'!$F19	E170 =E$141*'Biofortification targeting'!$F19	F170 =F$141*'Biofortification targeting'!$F19	G170 =G$141*'Biofortification targeting'!$F19	H170 =H$141*'Biofortification targeting'!$F19
-- C171	D171 =D$141*'Biofortification targeting'!$F20	E171 =E$141*'Biofortification targeting'!$F20	F171 =F$141*'Biofortification targeting'!$F20	G171 =G$141*'Biofortification targeting'!$F20	H171 =H$141*'Biofortification targeting'!$F20
-- C172	D172 =D$141*'Biofortification targeting'!$F21	E172 =E$141*'Biofortification targeting'!$F21	F172 =F$141*'Biofortification targeting'!$F21	G172 =G$141*'Biofortification targeting'!$F21	H172 =H$141*'Biofortification targeting'!$F21
-- C173	D173 =D$141*'Biofortification targeting'!$F22	E173 =E$141*'Biofortification targeting'!$F22	F173 =F$141*'Biofortification targeting'!$F22	G173 =G$141*'Biofortification targeting'!$F22	H173 =H$141*'Biofortification targeting'!$F22
-- C174	D174 =D$141*'Biofortification targeting'!$F23	E174 =E$141*'Biofortification targeting'!$F23	F174 =F$141*'Biofortification targeting'!$F23	G174 =G$141*'Biofortification targeting'!$F23	H174 =H$141*'Biofortification targeting'!$F23
-- C175	D175 =D$141*'Biofortification targeting'!$F24	E175 =E$141*'Biofortification targeting'!$F24	F175 =F$141*'Biofortification targeting'!$F24	G175 =G$141*'Biofortification targeting'!$F24	H175 =H$141*'Biofortification targeting'!$F24
-- C176	D176 =D$141*'Biofortification targeting'!$F25	E176 =E$141*'Biofortification targeting'!$F25	F176 =F$141*'Biofortification targeting'!$F25	G176 =G$141*'Biofortification targeting'!$F25	H176 =H$141*'Biofortification targeting'!$F25
-- C177	D177 =D$141*'Biofortification targeting'!$F26	E177 =E$141*'Biofortification targeting'!$F26	F177 =F$141*'Biofortification targeting'!$F26	G177 =G$141*'Biofortification targeting'!$F26	H177 =H$141*'Biofortification targeting'!$F26
-- C213	D213 =PV($D$145,D$147,0,D176)*-1	E213 =PV($D$145,E$147,0,E176)*-1	F213 =PV($D$145,F$147,0,F176)*-1	G213 =PV($D$145,G$147,0,G176)*-1	H213 =PV($D$145,H$147,0,H176)*-1
-- C178	D178 =D$141*'Biofortification targeting'!$F27	E178 =E$141*'Biofortification targeting'!$F27	F178 =F$141*'Biofortification targeting'!$F27	G178 =G$141*'Biofortification targeting'!$F27	H178 =H$141*'Biofortification targeting'!$F27
-- C179	D179 =D$141*'Biofortification targeting'!$F28	E179 =E$141*'Biofortification targeting'!$F28	F179 =F$141*'Biofortification targeting'!$F28	G179 =G$141*'Biofortification targeting'!$F28	H179 =H$141*'Biofortification targeting'!$F28
-- C180	D180 =D$141*'Biofortification targeting'!$F29	E180 =E$141*'Biofortification targeting'!$F29	F180 =F$141*'Biofortification targeting'!$F29	G180 =G$141*'Biofortification targeting'!$F29	H180 =H$141*'Biofortification targeting'!$F29
-- C181	D181 =D$141*'Biofortification targeting'!$F30	E181 =E$141*'Biofortification targeting'!$F30	F181 =F$141*'Biofortification targeting'!$F30	G181 =G$141*'Biofortification targeting'!$F30	H181 =H$141*'Biofortification targeting'!$F30
-- C182	D182 =D$141*'Biofortification targeting'!$F31	E182 =E$141*'Biofortification targeting'!$F31	F182 =F$141*'Biofortification targeting'!$F31	G182 =G$141*'Biofortification targeting'!$F31	H182 =H$141*'Biofortification targeting'!$F31
-- C183	D183 =D$141*'Biofortification targeting'!$F32	E183 =E$141*'Biofortification targeting'!$F32	F183 =F$141*'Biofortification targeting'!$F32	G183 =G$141*'Biofortification targeting'!$F32	H183 =H$141*'Biofortification targeting'!$F32
-- C184	D184 =D$141*'Biofortification targeting'!$F33	E184 =E$141*'Biofortification targeting'!$F33	F184 =F$141*'Biofortification targeting'!$F33	G184 =G$141*'Biofortification targeting'!$F33	H184 =H$141*'Biofortification targeting'!$F33
-- C185	D185 =D$141*'Biofortification targeting'!$F34	E185 =E$141*'Biofortification targeting'!$F34	F185 =F$141*'Biofortification targeting'!$F34	G185 =G$141*'Biofortification targeting'!$F34	H185 =H$141*'Biofortification targeting'!$F34
-- C191	D191 =PV($D$145,D$147,0,D154)*-1	E191 =PV($D$145,E$147,0,E154)*-1	F191 =PV($D$145,F$147,0,F154)*-1	G191 =PV($D$145,G$147,0,G154)*-1	H191 =PV($D$145,H$147,0,H154)*-1
-- C192	D192 =PV($D$145,D$147,0,D155)*-1	E192 =PV($D$145,E$147,0,E155)*-1	F192 =PV($D$145,F$147,0,F155)*-1	G192 =PV($D$145,G$147,0,G155)*-1	H192 =PV($D$145,H$147,0,H155)*-1
-- C193	D193 =PV($D$145,D$147,0,D156)*-1	E193 =PV($D$145,E$147,0,E156)*-1	F193 =PV($D$145,F$147,0,F156)*-1	G193 =PV($D$145,G$147,0,G156)*-1	H193 =PV($D$145,H$147,0,H156)*-1
-- C194	D194 =PV($D$145,D$147,0,D157)*-1	E194 =PV($D$145,E$147,0,E157)*-1	F194 =PV($D$145,F$147,0,F157)*-1	G194 =PV($D$145,G$147,0,G157)*-1	H194 =PV($D$145,H$147,0,H157)*-1
-- C195	D195 =PV($D$145,D$147,0,D158)*-1	E195 =PV($D$145,E$147,0,E158)*-1	F195 =PV($D$145,F$147,0,F158)*-1	G195 =PV($D$145,G$147,0,G158)*-1	H195 =PV($D$145,H$147,0,H158)*-1
-- C196	D196 =PV($D$145,D$147,0,D159)*-1	E196 =PV($D$145,E$147,0,E159)*-1	F196 =PV($D$145,F$147,0,F159)*-1	G196 =PV($D$145,G$147,0,G159)*-1	H196 =PV($D$145,H$147,0,H159)*-1
-- C197	D197 =PV($D$145,D$147,0,D160)*-1	E197 =PV($D$145,E$147,0,E160)*-1	F197 =PV($D$145,F$147,0,F160)*-1	G197 =PV($D$145,G$147,0,G160)*-1	H197 =PV($D$145,H$147,0,H160)*-1
-- C198	D198 =PV($D$145,D$147,0,D161)*-1	E198 =PV($D$145,E$147,0,E161)*-1	F198 =PV($D$145,F$147,0,F161)*-1	G198 =PV($D$145,G$147,0,G161)*-1	H198 =PV($D$145,H$147,0,H161)*-1
-- C199	D199 =PV($D$145,D$147,0,D162)*-1	E199 =PV($D$145,E$147,0,E162)*-1	F199 =PV($D$145,F$147,0,F162)*-1	G199 =PV($D$145,G$147,0,G162)*-1	H199 =PV($D$145,H$147,0,H162)*-1
-- C200	D200 =PV($D$145,D$147,0,D163)*-1	E200 =PV($D$145,E$147,0,E163)*-1	F200 =PV($D$145,F$147,0,F163)*-1	G200 =PV($D$145,G$147,0,G163)*-1	H200 =PV($D$145,H$147,0,H163)*-1
-- C201	D201 =PV($D$145,D$147,0,D164)*-1	E201 =PV($D$145,E$147,0,E164)*-1	F201 =PV($D$145,F$147,0,F164)*-1	G201 =PV($D$145,G$147,0,G164)*-1	H201 =PV($D$145,H$147,0,H164)*-1
-- C202	D202 =PV($D$145,D$147,0,D165)*-1	E202 =PV($D$145,E$147,0,E165)*-1	F202 =PV($D$145,F$147,0,F165)*-1	G202 =PV($D$145,G$147,0,G165)*-1	H202 =PV($D$145,H$147,0,H165)*-1
-- C203	D203 =PV($D$145,D$147,0,D166)*-1	E203 =PV($D$145,E$147,0,E166)*-1	F203 =PV($D$145,F$147,0,F166)*-1	G203 =PV($D$145,G$147,0,G166)*-1	H203 =PV($D$145,H$147,0,H166)*-1
-- C204	D204 =PV($D$145,D$147,0,D167)*-1	E204 =PV($D$145,E$147,0,E167)*-1	F204 =PV($D$145,F$147,0,F167)*-1	G204 =PV($D$145,G$147,0,G167)*-1	H204 =PV($D$145,H$147,0,H167)*-1
-- C205	D205 =PV($D$145,D$147,0,D168)*-1	E205 =PV($D$145,E$147,0,E168)*-1	F205 =PV($D$145,F$147,0,F168)*-1	G205 =PV($D$145,G$147,0,G168)*-1	H205 =PV($D$145,H$147,0,H168)*-1
-- C206	D206 =PV($D$145,D$147,0,D169)*-1	E206 =PV($D$145,E$147,0,E169)*-1	F206 =PV($D$145,F$147,0,F169)*-1	G206 =PV($D$145,G$147,0,G169)*-1	H206 =PV($D$145,H$147,0,H169)*-1
-- C207	D207 =PV($D$145,D$147,0,D170)*-1	E207 =PV($D$145,E$147,0,E170)*-1	F207 =PV($D$145,F$147,0,F170)*-1	G207 =PV($D$145,G$147,0,G170)*-1	H207 =PV($D$145,H$147,0,H170)*-1
-- C208	D208 =PV($D$145,D$147,0,D171)*-1	E208 =PV($D$145,E$147,0,E171)*-1	F208 =PV($D$145,F$147,0,F171)*-1	G208 =PV($D$145,G$147,0,G171)*-1	H208 =PV($D$145,H$147,0,H171)*-1
-- C209	D209 =PV($D$145,D$147,0,D172)*-1	E209 =PV($D$145,E$147,0,E172)*-1	F209 =PV($D$145,F$147,0,F172)*-1	G209 =PV($D$145,G$147,0,G172)*-1	H209 =PV($D$145,H$147,0,H172)*-1
-- C210	D210 =PV($D$145,D$147,0,D173)*-1	E210 =PV($D$145,E$147,0,E173)*-1	F210 =PV($D$145,F$147,0,F173)*-1	G210 =PV($D$145,G$147,0,G173)*-1	H210 =PV($D$145,H$147,0,H173)*-1
-- C211	D211 =PV($D$145,D$147,0,D174)*-1	E211 =PV($D$145,E$147,0,E174)*-1	F211 =PV($D$145,F$147,0,F174)*-1	G211 =PV($D$145,G$147,0,G174)*-1	H211 =PV($D$145,H$147,0,H174)*-1
-- C212	D212 =PV($D$145,D$147,0,D175)*-1	E212 =PV($D$145,E$147,0,E175)*-1	F212 =PV($D$145,F$147,0,F175)*-1	G212 =PV($D$145,G$147,0,G175)*-1	H212 =PV($D$145,H$147,0,H175)*-1
-- C214	D214 =PV($D$145,D$147,0,D177)*-1	E214 =PV($D$145,E$147,0,E177)*-1	F214 =PV($D$145,F$147,0,F177)*-1	G214 =PV($D$145,G$147,0,G177)*-1	H214 =PV($D$145,H$147,0,H177)*-1
-- C215	D215 =PV($D$145,D$147,0,D178)*-1	E215 =PV($D$145,E$147,0,E178)*-1	F215 =PV($D$145,F$147,0,F178)*-1	G215 =PV($D$145,G$147,0,G178)*-1	H215 =PV($D$145,H$147,0,H178)*-1
-- C216	D216 =PV($D$145,D$147,0,D179)*-1	E216 =PV($D$145,E$147,0,E179)*-1	F216 =PV($D$145,F$147,0,F179)*-1	G216 =PV($D$145,G$147,0,G179)*-1	H216 =PV($D$145,H$147,0,H179)*-1
-- C217	D217 =PV($D$145,D$147,0,D180)*-1	E217 =PV($D$145,E$147,0,E180)*-1	F217 =PV($D$145,F$147,0,F180)*-1	G217 =PV($D$145,G$147,0,G180)*-1	H217 =PV($D$145,H$147,0,H180)*-1
-- C218	D218 =PV($D$145,D$147,0,D181)*-1	E218 =PV($D$145,E$147,0,E181)*-1	F218 =PV($D$145,F$147,0,F181)*-1	G218 =PV($D$145,G$147,0,G181)*-1	H218 =PV($D$145,H$147,0,H181)*-1
-- C219	D219 =PV($D$145,D$147,0,D182)*-1	E219 =PV($D$145,E$147,0,E182)*-1	F219 =PV($D$145,F$147,0,F182)*-1	G219 =PV($D$145,G$147,0,G182)*-1	H219 =PV($D$145,H$147,0,H182)*-1
-- C220	D220 =PV($D$145,D$147,0,D183)*-1	E220 =PV($D$145,E$147,0,E183)*-1	F220 =PV($D$145,F$147,0,F183)*-1	G220 =PV($D$145,G$147,0,G183)*-1	H220 =PV($D$145,H$147,0,H183)*-1
-- C221	D221 =PV($D$145,D$147,0,D184)*-1	E221 =PV($D$145,E$147,0,E184)*-1	F221 =PV($D$145,F$147,0,F184)*-1	G221 =PV($D$145,G$147,0,G184)*-1	H221 =PV($D$145,H$147,0,H184)*-1
-- C222	D222 =PV($D$145,D$147,0,D185)*-1	E222 =PV($D$145,E$147,0,E185)*-1	F222 =PV($D$145,F$147,0,F185)*-1	G222 =PV($D$145,G$147,0,G185)*-1	H222 =PV($D$145,H$147,0,H185)*-1
-- C228	D228 =SUM(D191:M191)				
-- C229	D229 =SUM(D192:M192)				
-- C230	D230 =SUM(D193:M193)				
-- C231	D231 =SUM(D194:M194)				
-- C232	D232 =SUM(D195:M195)				
-- C233	D233 =SUM(D196:M196)				
-- C234	D234 =SUM(D197:M197)				
-- C235	D235 =SUM(D198:M198)				
-- C236	D236 =SUM(D199:M199)				
-- C237	D237 =SUM(D200:M200)				
-- C238	D238 =SUM(D201:M201)				
-- C239	D239 =SUM(D202:M202)				
-- C240	D240 =SUM(D203:M203)				
-- C241	D241 =SUM(D204:M204)				
-- C242	D242 =SUM(D205:M205)				
-- C243	D243 =SUM(D206:M206)				
-- C244	D244 =SUM(D207:M207)				
-- C245	D245 =SUM(D208:M208)				
-- C246	D246 =SUM(D209:M209)				
-- C247	D247 =SUM(D210:M210)				
-- C248	D248 =SUM(D211:M211)				
-- C249	D249 =SUM(D212:M212)				
-- C250	D250 =SUM(D213:M213)				
-- C251	D251 =SUM(D214:M214)				
-- C252	D252 =SUM(D215:M215)				
-- C253	D253 =SUM(D216:M216)				
-- C254	D254 =SUM(D217:M217)				
-- C255	D255 =SUM(D218:M218)				
-- C256	D256 =SUM(D219:M219)				
-- C257	D257 =SUM(D220:M220)				
-- C258	D258 =SUM(D221:M221)				




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
