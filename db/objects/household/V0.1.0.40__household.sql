CREATE TABLE HOUSEHOLD (
	id                            integer primary key
	, location                    integer  REFERENCES LOCATION (id)-- foreign key to a GIS point, the closest to where the households actually located
	, location_type_code          text   --- urban, rural, unknown
	, household_size              integer
	, household_expenditure       integer
	, wealth_quintile             integer
);
