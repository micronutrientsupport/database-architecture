CREATE TABLE COUNTRY (
	id        text primary key ---ISO 3166  two letter codes
	, name    text
	, geometry geometry(Polygon,4326)
);
COMMENT ON TABLE COUNTRY IS 'ISO 3166 list of countries';
