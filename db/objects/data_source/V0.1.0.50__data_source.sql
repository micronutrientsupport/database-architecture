CREATE TABLE DATA_SOURCE (
	id                            integer primary key
	, name                        text
	, author                      text
	, publication                 text
	, isbn                        text
	, notes                       text
);
INSERT INTO DATA_SOURCE (id, name) VALUES (1, 'Malawi');
INSERT INTO DATA_SOURCE (id, name) VALUES (2, 'Gambia Prynand Paul');