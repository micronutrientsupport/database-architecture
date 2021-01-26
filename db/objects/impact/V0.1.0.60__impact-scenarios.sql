CREATE TABLE IMPACT_SCENARIO (
	id                  text primary key
	, name              text
	, brief_description text
	, description       text
	, is_baseline       boolean
);
COMMENT ON TABLE impact_scenario IS 'List of scenarios from the IMPACT model and their description';
COMMENT on column impact_scenario.name is 'Scenario name';
COMMENT on column impact_scenario.description is 'User facing summary of the scenario';
COMMENT on column impact_scenario.brief_description is 'User facing brief summary of the scenario';
COMMENT on column impact_scenario.is_baseline is 'Is this scenario used as a baseline for comparison';