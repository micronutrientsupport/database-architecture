create table household_fct_list
(
household_id 	integer primary key references household (id),
fct_list 		text,
fct_list_id     integer,
aggregation_area_id integer,
aggregation_area_name text,
aggregation_area_type text,
survey_id       integer,
FOREIGN KEY (fct_list_id) REFERENCES distinct_fct_list(id),
FOREIGN KEY (aggregation_area_id) REFERENCES aggregation_area(id),
FOREIGN KEY (survey_id) REFERENCES survey(id)
);

COMMENT ON TABLE household_fct_list                       IS 'List of prioritised FCTs for a given household';