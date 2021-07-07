CREATE TABLE subregion (
	id            text primary key ---ISO 3166  two letter codes
	, name        text
    , country     text REFERENCES country (id)
	, type        text
	, admin_level integer

	, geometry geometry(MultiPolygon,4326)
);

CREATE INDEX subregion_geometry_idx ON Subregion USING GIST (geometry);


COMMENT ON TABLE subregion              IS 'Level 1 subnational regions from GADM';
COMMENT ON COLUMN subregion.name        IS 'The name of the admistrative area';
COMMENT ON COLUMN subregion.country     IS 'The ISO 3166 alpha-2 code of the country to which this administrative region belongs';
COMMENT ON COLUMN subregion.type        IS ''; -- TODO: explain this
COMMENT ON COLUMN subregion.admin_level IS 'The hierarchichal level of this administrative subregion. 0 is the country itself, 1 is the first level of administrative subdivision, 2 is the second level of administrative subdivision, etc.';

