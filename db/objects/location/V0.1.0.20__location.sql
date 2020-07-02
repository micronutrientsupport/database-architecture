CREATE TABLE LOCATION (
	id                     integer primary key
	, Country              text NOT NULL REFERENCES country (id)
	, Name                 text
	, Geometry             text --change to geometry
);