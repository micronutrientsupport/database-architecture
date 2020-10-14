CREATE TABLE household (
	id                            integer primary key
	, location                    integer  REFERENCES LOCATION (id)-- foreign key to a GIS point, the closest to where the household is actually located
	, location_type_code          text   --- urban, rural, unknown
	-- , household_size              integer
	, household_expenditure       integer
	, wealth_quintile             integer
);

COMMENT ON TABLE Household IS 'A household is a grouping of people that live together and can be treated as a unit for certain pruposes. For example, we may have data on what foods a household as a whole consumed, rather than for individual people who live in that household';
COMMENT on column household.location_type_code    IS 'Whether this household is located in an urban or rural area';
COMMENT on column household.household_expenditure IS 'How much money this household spends per month';
COMMENT on column household.wealth_quintile       IS 'In what quintile of househol wealth this household is (5=richest, 1=poorest)';
