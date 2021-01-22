CREATE TABLE IMPACT_SCENARIO (
	id                 text primary key
	, name              text
	, description       text
);
COMMENT ON TABLE impact_scenario IS 'List of scenarios from the IMPACT model and their description';
COMMENT on column impact_scenario.name is 'Scenario name';
COMMENT on column impact_scenario.description is 'User facing summary of the scenario';