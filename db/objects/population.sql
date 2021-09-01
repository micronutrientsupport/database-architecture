CREATE TABLE population_source (
	id                          integer primary key,
	"name" text,
	description text
);
COMMENT ON TABLE population_source IS 'The names of the data sources for population data';

create TABLE population (
	id                          integer primary key GENERATED BY DEFAULT AS IDENTITY,
	aggregation_area_id			integer REFERENCES aggregation_area (id),
	"year"						integer,
	population_source_id		integer REFERENCES population_source (id),
	min_age_in_years			integer,
	max_age_in_years			integer,
	sex							char(1),
	population					float8,
	CONSTRAINT population_sex_check CHECK ((sex = ANY (ARRAY['m'::text, 'f'::text])))
);

COMMENT ON TABLE population IS 'population of people of each sex within an age range inclusive of the min and max age living in an aggregation area ';