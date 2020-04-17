

DROP TABLE IF EXISTS FOOD_GROUP CASCADE;
CREATE TABLE FOOD_GROUP (
	id               integer primary key
	, name           text
);

DROP TABLE IF EXISTS FOODITEM CASCADE;
CREATE TABLE FOODITEM (
	id                               integer primary key
	, Food_Group                     integer REFERENCES FOOD_GROUP (id)
	, Soil_Class                     text
	, Moisture_in_g                  numeric(20,10)
	, EnergyCalculated_in_kCal       numeric(20,10)
	, EnergyCalculated_in_kJ         numeric(20,10)
	, Nitrogen_in_g                  numeric(20,10)
	, TotalProtein_in_g              numeric(20,10)
	, TotalFats_in_g                 numeric(20,10)
	, SaturatedFA_in_g               numeric(20,10)
	, MonounsaturatedFA_in_g         numeric(20,10)
	, PolyunsaturatedFA_in_g         numeric(20,10)
	, Cholesterol_in_mg              numeric(20,10)
	, TotalCHOforUDB                 numeric(20,10)
	, Carbohydrateavailable_in_g     numeric(20,10)
	, Totalsugars_in_g               numeric(20,10)
	, Addedsugar_in_g                numeric(20,10)
	, Totalfibre_in_g                numeric(20,10)
	, Starch_in_g                    numeric(20,10)
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
	, VitaminA_in_RE_in_mcg          numeric(20,10)
	, Thiamin_in_mg                  numeric(20,10)
	, Riboflavin_in_mg               numeric(20,10)
	, Niacin_in_mg                   numeric(20,10)
	, VitaminB6_in_mg                numeric(20,10)
	, Folicacid_in_mcg               numeric(20,10)
	, VitaminB12_in_mcg              numeric(20,10)
	, Pantothenate_in_mg             numeric(20,10)
	, Biotin_in_mcg                  numeric(20,10)
	, VitaminC_in_mg                 numeric(20,10)
	, VitaminD_in_mcg                numeric(20,10)
	, VitaminE_in_mg                 numeric(20,10)
	, PhyticAcid_in_mg               numeric(20,10)
);

DROP TABLE IF EXISTS HOUSEHOLD CASCADE;
CREATE TABLE HOUSEHOLD (
	id                            integer primary key
	, household_expenditure       integer
	, location_type_code          text   --- urban, rural, unknown
	, Household_head_type_code    text
	, household_size              integer
	, location                    integer  REFERENCES LOCATION (id)-- foreign key to a GIS polygon, the closest to where the households actually located
);


DROP TABLE IF EXISTS COUNTRY CASCADE; 
CREATE TABLE COUNTRY ( 
	id                            text primary key ---ISO 3166  two letter codes
	, name                        text
);


DROP TABLE IF EXISTS LOCATION CASCADE;
CREATE TABLE LOCATION (
	id                     integer primary key
	, Country              text NOT NULL REFERENCES country (id)
	, Name                 text
	, Geometry             text --change to geometry
);

DROP TABLE IF EXISTS DIC_SOIL_TYPE CASCADE;
CREATE TABLE DIC_SOIL_TYPE (
	id                            integer primary key
	, name                        text
);


DROP TABLE IF EXISTS FOOD_DATA_SOURCE_LINK CASCADE;
CREATE TABLE FOOD_DATA_SOURCE_LINK (
	fooditem_id               integer NOT NULL REFERENCES FOODITEM (id)
	, date_source_id          integer NOT NULL REFERENCES DATA_SOURCE (id)
	, PRIMARY KEY (fooditem_id, date_source_id)
);


DROP TABLE IF EXISTS DATA_SOURCE CASCADE;
CREATE TABLE DATA_SOURCE (
	id                            integer primary key
	, name                        text
	, author                      text
	, publication                 text
	, isbn                        text
	, notes                       text
);


