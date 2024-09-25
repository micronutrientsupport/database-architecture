-- DROP TABLE household_intake_afe_deficiency_pivot_tbl;

CREATE TABLE household_intake_afe_deficiency_pivot_tbl (
	survey_id int4 NULL,
	household_id int8 NULL,
	fct_source_id int4 NULL,
	aggregation_area_id int4 NULL,
	aggregation_area_name text NULL,
	aggregation_area_type text NULL,
	micronutrient_id text NULL,
	micronutrient_supply numeric NULL,
	afe_ear numeric NULL,
	is_deficient bool NULL
);