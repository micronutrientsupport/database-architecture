CREATE TABLE fooditem (
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

)


Create Table Household (
	id                            integer primary key
	, household_expenditure       integer
	, location_type_code          text   --- urban, rural, unknown
	, Household_head_type_code    text
	, household_size              integer
	, location                    integer  -- foregin key to a GIS polygon, the closest to where the houeholis actually located
)

Create table location (
	id                     integer primary key
	, Country              text
	, Name                 text
	, Geometry             text --change to geometry
)

Create table dic_soil_type (
	id                            integer primary key
	, name
)

create table food_date_source_link (


Create table data_source (
	id                            integer primary key
	, name                        text
	, author                      text
	, publication                 text
	, isbn                        text
	, notes                       text
)