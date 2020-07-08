CREATE TABLE HOUSEHOLD (
	id                            integer primary key
	, household_expenditure       integer
	, location_type_code          text   --- urban, rural, unknown
	, Household_head_type_code    text
	, household_size              integer
	, location                    integer  REFERENCES LOCATION (id)-- foreign key to a GIS polygon, the closest to where the households actually located
);