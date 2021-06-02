CREATE TABLE FOODITEM (
	id                               integer primary key GENERATED BY DEFAULT AS IDENTITY
    (START WITH 10000 INCREMENT BY 1)
	, Original_Food_Id               text
	, Original_Food_Name             text
	, food_genus_id                  text REFERENCEs food_genus (id)
	, food_genus_confidence          text REFERENCES food_genus_confidence (id)
    , FCT_SOURCE_ID                  integer REFERENCES FCT_SOURCE (ID)
	, DATA_REFERENCE_ID              text
	, Moisture_in_g                  numeric(20,10)
	, Energy_in_kCal                 numeric(20,10)
	, Energy_in_kJ                   numeric(20,10)
	, Nitrogen_in_g                  numeric(20,10)
	, TotalProtein_in_g              numeric(20,10)
	, TotalFats_in_g                 numeric(20,10)
	, SaturatedFA_in_g               numeric(20,10)
	, MonounsaturatedFA_in_g         numeric(20,10)
	, PolyunsaturatedFA_in_g         numeric(20,10)
	, Cholesterol_in_mg              numeric(20,10)
	, Carbohydrateavailable_in_g     numeric(20,10)
	, Fibre_in_g                     numeric(20,10)
	, Ash_in_g                       numeric(20,10)
	, Ca_in_mg                       numeric(20,10)
	, Fe_in_mg                       numeric(20,10)
	, Mg_in_mg                       numeric(20,10)
	, P_in_mg                        numeric(20,10)
	, K_in_mg                        numeric(20,10)
	, Na_in_mg                       numeric(20,10)
	, Zn_in_mg                       numeric(20,10)
	, Cu_in_mg                       numeric(20,10)
	, Mn_in_mcg                      numeric(20,10)
	, I_in_mcg                       numeric(20,10)
	, Se_in_mcg                      numeric(20,10)
	, VitaminA_in_RAE_in_mcg         numeric(20,10)
	, Thiamin_in_mg                  numeric(20,10)
	, Riboflavin_in_mg               numeric(20,10)
	, Niacin_in_mg                   numeric(20,10)
	, VitaminB6_in_mg                numeric(20,10)
	, Folicacid_in_mcg               numeric(20,10)
	, Folate_in_mcg                  numeric(20,10)
	, VitaminB12_in_mcg              numeric(20,10)
	, Pantothenate_in_mg             numeric(20,10)
	, Biotin_in_mcg                  numeric(20,10)
	, VitaminC_in_mg                 numeric(20,10)
	, VitaminD_in_mcg                numeric(20,10)
	, VitaminE_in_mg                 numeric(20,10)
	, PhyticAcid_in_mg               numeric(20,10)
);
