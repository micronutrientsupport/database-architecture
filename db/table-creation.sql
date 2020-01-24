



DROP TABLE IF EXISTS FOODITEM;
CREATE TABLE FOODITEM (
	id                   integer primary key
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

DROP TABLE IF EXISTS HOUSEHOLD;
CREATE TABLE HOUSEHOLD (
	id                            integer primary key
	, household_expenditure       integer
	, location_type_code          text   --- urban, rural, unknown
	, Household_head_type_code    text
	, household_size              integer
	, location                    integer  -- foregin key to a GIS polygon, the closest to where the houeholis actually located
);


DROP TABLE IF EXISTS LOCATION;
CREATE TABLE LOCATION (
	id                     integer primary key
	, Country              text
	, Name                 text
	, Geometry             text --change to geometry
);

DROP TABLE IF EXISTS DIC_SOIL_TYPE;
CREATE TABLE DIC_SOIL_TYPE (
	id                            integer primary key
	, name                        text
);


DROP TABLE IF EXISTS FOOD_DATA_SOURCE_LINK;
CREATE TABLE FOOD_DATA_SOURCE_LINK (
	fooditem_id               integer NOT NULL
	, date_source_id          integer NOT NULL
	, PRIMARY KEY (fooditem_id, date_source_id)
);


DROP TABLE IF EXISTS DATA_SOURCE;
CREATE TABLE DATA_SOURCE (
	id                            integer primary key
	, name                        text
	, author                      text
	, publication                 text
	, isbn                        text
	, notes                       text
);