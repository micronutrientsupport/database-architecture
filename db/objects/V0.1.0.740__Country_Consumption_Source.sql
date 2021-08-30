CREATE TABLE COUNTRY_CONSUMPTION_SOURCE (
	id                            integer primary key generated by default as IDENTITY
	, name                        text
	, description                 text
	, geometry                    geometry(MultiPolygon,4326)
	, publication_date            date
	, notes                       text
);

COMMENT ON TABLE COUNTRY_CONSUMPTION_SOURCE IS 'The names of the data sources for country level food availability (primarily Food Balance Sheets (FBS))';
