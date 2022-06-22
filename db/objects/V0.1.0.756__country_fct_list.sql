	create table country_fct_list
	(
	id 	integer primary key references country_consumption_source (id),
	fct_list 		text
	fct_list_id     integer,
	FOREIGN KEY (fct_list_id) REFERENCES distinct_fct_list(id);
	)
	;