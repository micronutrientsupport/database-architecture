﻿Insert into BIOMARKER_THRESHOLD
   (biomarker_id,group_id,conditional_info,threshold_type,source,matrix,lower_threshold,upper_threshold,comments,condition_time_of_day_sampled,condition_was_fasting,condition_age_in_months)
VALUES
 ('ferritin','MEN',NULL,'deficiency','WHO 2020','Plasma or Serum',0,15,'Lower',NULL,NULL,NULL)
,('ferritin','MEN',NULL,'excess','WHO 2020','Plasma or Serum',200,NULL,'upper, to define excess in healthy people',NULL,NULL,NULL)
,('ferritin','MEN',NULL,'excess','WHO 2020','Plasma or Serum',500,NULL,'upper, to define excess in non-healthy people',NULL,NULL,NULL)
,('ferritin','PREG','first trimester','deficiency','WHO 2020','Plasma or Serum',0,15,'lower',NULL,NULL,NULL)
,('ferritin','PSC',NULL,'deficiency','WHO 2020','Plasma or Serum',0,12,'Lower',NULL,NULL,NULL)
,('ferritin','SAC',NULL,'deficiency','WHO 2020','Plasma or Serum',0,15,'lower',NULL,NULL,NULL)
,('ferritin','SAC',NULL,'excess','WHO 2020','Plasma or Serum',150,NULL,'upper, to define excess in healthy people',NULL,NULL,NULL)
,('ferritin','SAC',NULL,'excess','WHO 2020','Plasma or Serum',200,NULL,'upper, to define excess in healthy people',NULL,NULL,NULL)
,('ferritin','SAC',NULL,'excess','WHO 2020','Plasma or Serum',500,NULL,'upper, to define excess in non-healthy people',NULL,NULL,NULL)
,('ferritin','WRA',NULL,'deficiency','WHO 2020','Plasma or Serum',0,15,'lower',NULL,NULL,NULL)
,('ferritin','WRA',NULL,'excess','WHO 2020','Plasma or Serum',150,NULL,'upper, to define excess in healthy people',NULL,NULL,NULL)
,('ferritin','WRA',NULL,'excess','WHO 2020','Plasma or Serum',500,NULL,'upper, to define excess in non-healthy people',NULL,NULL,NULL)
,('haemoglobin','MEN','must have been adjusted for altitude and smoking','deficiency - severe','WHO, 2011','Whole blood',0,79,'lower, to define severe anemia',NULL,NULL,NULL)
,('haemoglobin','MEN','must have been adjusted for altitude and smoking','deficiency - moderate','WHO, 2011','Whole blood',80,109,'lower, to define moderate anemia',NULL,NULL,NULL)
,('haemoglobin','MEN','must have been adjusted for altitude and smoking','deficiency - mild','WHO, 2011','Whole blood',110,129,'lower, to define mild anemia',NULL,NULL,NULL)
,('haemoglobin','PREG','must have been adjusted for altitude and smoking','deficiency - severe','WHO, 2011','Whole blood',0,69,'lower, to define severe anemia',NULL,NULL,NULL)
,('haemoglobin','PREG','must have been adjusted for altitude and smoking','deficiency - moderate','WHO, 2011','Whole blood',70,99,'lower, to define moderate anemia',NULL,NULL,NULL)
,('haemoglobin','PREG','must have been adjusted for altitude and smoking','deficiency - mild','WHO, 2011','Whole blood',100,109,'lower, to define mild anemia',NULL,NULL,NULL)
,('haemoglobin','PSC','must have been adjusted for altitude and smoking','deficiency - severe','WHO, 2011','Whole blood',0,69,'lower, to define severe anemia',NULL,NULL,NULL)
,('haemoglobin','PSC','must have been adjusted for altitude and smoking','deficiency - moderate','WHO, 2011','Whole blood',70,99,'lower, to define moderate anemia',NULL,NULL,NULL)
,('haemoglobin','PSC','must have been adjusted for altitude and smoking','deficiency - mild','WHO, 2011','Whole blood',100,109,'lower, to define mild anemia',NULL,NULL,NULL)
,('haemoglobin','SAC','must have been adjusted for altitude and smoking','deficiency - severe','WHO, 2011','Whole blood',0,79,'lower, to define severe anemia',NULL,NULL,NULL)
,('haemoglobin','SAC','must have been adjusted for altitude and smoking','deficiency - moderate','WHO, 2011','Whole blood',80,109,'lower, to define moderate anemia',NULL,NULL,NULL)
,('haemoglobin','SAC','must have been adjusted for altitude and smoking','deficiency - mild','WHO, 2011','Whole blood',110,114,'lower, to define mild anemia',NULL,NULL,NULL)
,('haemoglobin','SAC','must have been adjusted for altitude and smoking','deficiency - mild','WHO, 2011','Whole blood',110,119,'lower, to define mild anemia',NULL,NULL,NULL)
,('haemoglobin','WRA','must have been adjusted for altitude and smoking','deficiency - severe','WHO, 2011','Whole blood',0,79,'lower, to define severe anemia',NULL,NULL,NULL)
,('haemoglobin','WRA','must have been adjusted for altitude and smoking','deficiency - moderate','WHO, 2011','Whole blood',80,109,'lower, to define moderate anemia',NULL,NULL,NULL)
,('haemoglobin','WRA','must have been adjusted for altitude and smoking','deficiency - mild','WHO, 2011','Whole blood',110,119,'lower, to define mild anemia',NULL,NULL,NULL)
,('ps_folate','MEN',NULL,'deficiency','WHO 2015','Plasma or Serum',0,6.8,'lower, deficiency using macrocytic anaemia as a haematological indicato',NULL,NULL,NULL)
,('ps_folate','MEN',NULL,'deficiency','WHO 2015','Plasma or Serum',0,10,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('ps_folate','MEN',NULL,'deficiency','WHO 2015','Plasma or Serum',0,13.5,'lower, possible deficiency, using macrocytic anemia as hematological indicator',NULL,NULL,NULL)
,('ps_folate','MEN',NULL,'excess','WHO 2015','Plasma or Serum',45.3,NULL,'upper',NULL,NULL,NULL)
,('ps_folate','PSC',NULL,'deficiency','WHO 2015','Plasma or Serum',0,6.8,'lower, deficiency using macrocytic anaemia as a haematological indicato',NULL,NULL,NULL)
,('ps_folate','PSC',NULL,'deficiency','WHO 2015','Plasma or Serum',0,10,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('ps_folate','PSC',NULL,'deficiency','WHO 2015','Plasma or Serum',0,13.5,'lower, possible deficiency, using macrocytic anemia as hematological indicator',NULL,NULL,NULL)
,('ps_folate','PSC',NULL,'excess','WHO 2015','Plasma or Serum',45.3,NULL,'upper',NULL,NULL,NULL)
,('ps_folate','SAC',NULL,'deficiency','WHO 2015','Plasma or Serum',0,6.8,'lower, deficiency using macrocytic anaemia as a haematological indicato',NULL,NULL,NULL)
,('ps_folate','SAC',NULL,'deficiency','WHO 2015','Plasma or Serum',0,10,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('ps_folate','SAC',NULL,'deficiency','WHO 2015','Plasma or Serum',0,13.5,'lower, possible deficiency, using macrocytic anemia as hematological indicator',NULL,NULL,NULL)
,('ps_folate','SAC',NULL,'excess','WHO 2015','Plasma or Serum',45.3,NULL,'upper',NULL,NULL,NULL)
,('ps_folate','WRA',NULL,'deficiency','WHO 2015','Plasma or Serum',0,6.8,'lower, deficiency using macrocytic anaemia as a haematological indicato',NULL,NULL,NULL)
,('ps_folate','WRA',NULL,'deficiency','WHO 2015','Plasma or Serum',0,10,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('ps_folate','WRA',NULL,'deficiency','WHO 2015','Plasma or Serum',0,13.5,'lower, possible deficiency, using macrocytic anemia as hematological indicator',NULL,NULL,NULL)
,('ps_folate','WRA',NULL,'excess','WHO 2015','Plasma or Serum',45.3,NULL,'upper',NULL,NULL,NULL)
,('rbc_folate','MEN',NULL,'deficiency','WHO 2015','Red blood cell',0,226.5,'lower, using macrocytic anaemia as a haematological indicator',NULL,NULL,NULL)
,('rbc_folate','MEN',NULL,'deficiency','WHO 2015','Red blood cell',0,340,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('rbc_folate','PSC',NULL,'deficiency','WHO 2015','Red blood cell',0,226.5,'lower, using macrocytic anaemia as a haematological indicator',NULL,NULL,NULL)
,('rbc_folate','PSC',NULL,'deficiency','WHO 2015','Red blood cell',0,340,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('rbc_folate','SAC',NULL,'deficiency','WHO 2015','Red blood cell',0,226.5,'lower, using macrocytic anaemia as a haematological indicator',NULL,NULL,NULL)
,('rbc_folate','SAC',NULL,'deficiency','WHO 2015','Red blood cell',0,340,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('rbc_folate','WRA',NULL,'deficiency','WHO 2015','Red blood cell',0,226.5,'lower, using macrocytic anaemia as a haematological indicator',NULL,NULL,NULL)
,('rbc_folate','WRA',NULL,'deficiency','WHO 2015','Red blood cell',0,340,'lower, using homocysteine concentrations as metabolic indicator',NULL,NULL,NULL)
,('rbc_folate','WRA',NULL,'deficiency','WHO 2015','Red blood cell',0,906,'lower, to prevent NTD',NULL,NULL,NULL)
,('retinol','MEN',NULL,'deficiency','WHO 2011','Plasma or Serum',0,0.7,'lower',NULL,NULL,NULL)
,('retinol','PSC',NULL,'deficiency','WHO 2011','Plasma or Serum',0,0.7,'lower',NULL,NULL,NULL)
,('retinol','SAC',NULL,'deficiency','WHO 2011','Plasma or Serum',0,0.7,'lower',NULL,NULL,NULL)
,('retinol','WRA',NULL,'deficiency','WHO 2011','Plasma or Serum',0,0.7,'lower',NULL,NULL,NULL)
,('selenium','WRA',NULL,'deficiency','Phiri 2019, based on Thomson 2004     ),
((no WHO ref)','Plasma or Serum',0,30,'lower, to define the risk of Keshan disease',NULL,NULL,NULL)
,('selenium','WRA',NULL,'deficiency','Phiri 2019, based on Thomson 2004     ),
((no WHO ref)','Plasma or Serum',0,64.8,'lower, to define optimal activity of IDI',NULL,NULL,NULL)
,('selenium','WRA',NULL,'deficiency','Phiri 2019, based on Thomson 2004     ),
((no WHO ref)','Plasma or Serum',0,84.9,'lower, to define optimal activity of GPx3',NULL,NULL,NULL)
,('vitamin_b12','MEN',NULL,'deficiency - severe','BONDS 2018','Plasma or Serum',0,75,'lower, to define severe deficiency',NULL,NULL,NULL)
,('vitamin_b12','MEN',NULL,'deficiency','BONDS 2018','Plasma or Serum',76,150,'lower, to define deficiency',NULL,NULL,NULL)
,('vitamin_b12','MEN',NULL,'deficiency','BONDS 2018','Plasma or Serum',151,221,'lower, to define depletion',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'deficiency','BONDS 2018','Plasma or Serum',0,119,'lower, to define depletion',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'deficiency','BONDS 2018','Plasma or Serum',0,120,'lower, to define depletion',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'deficiency','BONDS 2018','Plasma or Serum',0,164,'lower, to define depletion',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'deficiency','BONDS 2018','Plasma or Serum',0,182,'lower, to define depletion',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'excess','BONDS 2018','Plasma or Serum',120,691,'upper, to define inadequacy',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'excess','BONDS 2018','Plasma or Serum',121,521,'upper, to define inadequacy',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'excess','BONDS 2018','Plasma or Serum',165,581,'upper, to define inadequacy',NULL,NULL,NULL)
,('vitamin_b12','PSC',NULL,'excess','BONDS 2018','Plasma or Serum',183,261,'upper, to define inadequacy',NULL,NULL,NULL)
,('vitamin_b12','WRA',NULL,'deficiency - severe','BONDS 2018','Plasma or Serum',0,75,'lower, to define severe deficiency',NULL,NULL,NULL)
,('vitamin_b12','WRA',NULL,'deficiency','BONDS 2018','Plasma or Serum',76,150,'lower, to define deficiency',NULL,NULL,NULL)
,('vitamin_b12','WRA',NULL,'deficiency','BONDS 2018','Plasma or Serum',151,221,'lower, to define depletion',NULL,NULL,NULL)
,('zinc','MEN','After midday (sample time >12:00)','deficiency','BOND (KING 2016)','Plasma or Serum',0,61,'Lower','pm',NULL,NULL)
,('zinc','MEN','Morning (sample time <= 12:00), non fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,70,'Lower','am','FALSE',NULL)
,('zinc','MEN','Morning (sample time <= 12:00), fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,74,'Lower','am','TRUE',NULL)
,('zinc','PSC','After midday (sample time >12:00)','deficiency','BOND (KING 2016)','Plasma or Serum',0,57,'Lower','pm',NULL,NULL)
,('zinc','PSC','Morning (sample time <= 12:00), non fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,65,'Lower','am','FALSE',NULL)
,('zinc','SAC','After midday (sample time >12:00)','deficiency','BOND (KING 2016)','Plasma or Serum',0,57,'Lower','pm',NULL,NULL)
,('zinc','SAC','After midday (sample time >12:00)','deficiency','BOND (KING 2016)','Plasma or Serum',0,59,'Lower','pm',NULL,NULL)
,('zinc','SAC','After midday (sample time >12:00)','deficiency','BOND (KING 2016)','Plasma or Serum',0,61,'Lower','pm',NULL,NULL)
,('zinc','SAC','Morning (sample time <= 12:00), non fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,65,'Lower','am','FALSE',NULL)
,('zinc','SAC','Morning (sample time <= 12:00), non fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,66,'Lower','am','FALSE',NULL)
,('zinc','SAC','Morning (sample time <= 12:00), fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,70,'Lower','am','TRUE',NULL)
,('zinc','SAC','Morning (sample time <= 12:00), non fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,70,'Lower','am','FALSE',NULL)
,('zinc','SAC','Morning (sample time <= 12:00),  fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,74,'lower','am','TRUE',NULL)
,('zinc','WRA','After midday (sample time >12:00)','deficiency','BOND (KING 2016)','Plasma or Serum',0,59,'Lower','pm',NULL,NULL)
,('zinc','WRA','Morning (sample time <= 12:00), non fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,66,'Lower','am','FALSE',NULL)
,('zinc','WRA','Morning (sample time <= 12:00), fasting','deficiency','BOND (KING 2016)','Plasma or Serum',0,70,'Lower','am','TRUE',NULL);
