CREATE TABLE FCT_SOURCE (
	id                            integer primary key
	, name                        text
	, notes                       text
);
INSERT INTO FCT_SOURCE (id, name) VALUES (1, 'Malawi');
INSERT INTO FCT_SOURCE (id, name) VALUES (2, 'Gambia Prynand Paul');

COMMENT ON TABLE FCT_SOURCE IS 'The names of the various Food Composition Tables from which we derive the information about food composition';
