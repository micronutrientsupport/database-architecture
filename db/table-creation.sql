

DROP TABLE IF EXISTS FOOD_GROUP CASCADE;
CREATE TABLE FOOD_GROUP (
	id               integer primary key
	, name           text
);

DROP TABLE IF EXISTS FOODITEM CASCADE;
CREATE TABLE FOODITEM (
	id                   integer primary key
	, food_group         integer REFERENCES FOOD_GROUP (id)
	, soil_class         text
	, energy             numeric(20,10)
	, phytate            numeric(20,10)
	, calcium            numeric(20,10)
	, copper             numeric(20,10)
	, iron               numeric(20,10)
	, iodine             numeric(20,10)
	, magnesium          numeric(20,10)
	, selenium           numeric(20,10)
	, zinc               numeric(20,10)
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


