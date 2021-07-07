CREATE TABLE subregion (
	id              text primary key
	, name          text
    , country       text REFERENCES country (id) ---ISO 3166  three letter codes
	, type          text
	, admin_level   integer
	, admin0_region text
	, admin1_region text
	, admin2_region text
	, admin3_region text
	, geometry geometry(MultiPolygon,4326)
);

CREATE INDEX subregion_geometry_idx ON Subregion USING GIST (geometry);


COMMENT ON TABLE subregion                IS 'Level 1 subnational regions from GADM';
COMMENT ON COLUMN subregion.name          IS 'The name of the admistrative area';
COMMENT ON COLUMN subregion.country       IS 'The IS O 3166 alpha-3 code of the country to which this administrative region belongs';
COMMENT ON COLUMN subregion.type          IS ''; -- TODO: explain this
COMMENT ON COLUMN subregion.admin_level   IS 'The hierarchichal level of this administrative subregion. 0 is the country itself, 1 is the first level of administrative subdivision, 2 is the second level of administrative subdivision, etc.';
COMMENT ON COLUMN subregion.admin0_region IS 'The id of the adminsitrative region containing this one. NULL if below the level of this region';
COMMENT ON COLUMN subregion.admin1_region IS 'The id of the adminsitrative region containing this one. NULL if below the level of this region';
COMMENT ON COLUMN subregion.admin2_region IS 'The id of the adminsitrative region containing this one. NULL if below the level of this region';
COMMENT ON COLUMN subregion.admin3_region IS 'The id of the adminsitrative region containing this one. NULL if below the level of this region';

