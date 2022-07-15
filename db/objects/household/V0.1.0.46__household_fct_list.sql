create table household_fct_list
(
household_id 	integer primary key references household (id),
fct_list 		text
);

COMMENT ON TABLE household_fct_list                       IS 'List of prioritised FCTs for a given household';