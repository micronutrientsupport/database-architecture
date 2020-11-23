CREATE TABLE COUNTRY (
	id         text primary key ---ISO 3166  two letter codes
	, name     text
	, region   integer  REFERENCES region (id)
	, geometry geometry(MultiPolygon,4326)
);
COMMENT ON TABLE COUNTRY IS 'ISO 3166 list of countries';
COMMENT on column country.region is 'geogrpahic regions as used by the World Health Organisation methodology Standard country or area codes for statistical use (M49). see https://unstats.un.org/unsd/methodology/m49/ and https://en.m.wikipedia.org/wiki/United_Nations_geoscheme_for_Africa';
