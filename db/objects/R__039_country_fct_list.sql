	create table country_fct_list
	(
	id 	integer primary key references country_consumption_source (id),
	fct_list 		text
	)
	;