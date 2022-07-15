create table household_fct_list
(
household_id 	integer primary key references household (id),
fct_list 		text,
fct_list_id     integer,
FOREIGN KEY (fct_list_id) REFERENCES distinct_fct_list(id);
);

COMMENT ON TABLE household_fct_list                       IS 'List of prioritised FCTs for a given household';