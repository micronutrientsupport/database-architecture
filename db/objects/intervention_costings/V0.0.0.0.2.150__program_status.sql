-- TABLE: program_status

create table program_status(
	program_status_id text not null,
	program_status_description text,
	CONSTRAINT "program_status_pk" PRIMARY KEY (program_status_id)
)
;
