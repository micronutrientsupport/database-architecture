CREATE TABLE aggregation_area (
	id              integer primary key GENERATED BY DEFAULT AS IDENTITY
	(START WITH 1000 INCREMENT BY 1)
	, name          text
	, country       text REFERENCES country (id) ---ISO 3166  three letter codes
	, type          text CHECK (type IN ('country', 'admin', 'non-admin'))
	, admin_level   integer
	, parent        integer REFERENCES aggregation_area (id)
	, geometry      geometry(MultiPolygon,4326)
);

CREATE INDEX aggregation_area_geometry_idx ON aggregation_area USING GIST (geometry);


COMMENT ON TABLE aggregation_area                IS 'Geographic areas used to aggregate statistical results from the data. Can be official adminstrative regions, or arbitrary geopgraphic polygons.';
COMMENT ON COLUMN aggregation_area.name          IS 'The name of the aggregation area';
COMMENT ON COLUMN aggregation_area.country       IS 'The ISO 3166 alpha-3 code of the country to which this administrative region belongs, if applicable. Areas that are not defined by adminstrative boundaries will have this as NULL';
COMMENT ON COLUMN aggregation_area.type          IS 'Whether this aggregation area is a: country, administrative area, or non-administrative area. Administrative areas are borders defined by their respctive country (e.g. districts) and form a hierarchical relationship with each other. Non-adminstrative area are indepedent of national borders, e.g. user-drawn polygons to select data, or geologic features.'; -- TODO: explain this
COMMENT ON COLUMN aggregation_area.admin_level   IS 'The hierarchichal level of this administrative aggregation area, if this is an adminsitrative area. 0 is a country, 1 is the first level of administrative subdivision, 2 is the second level of administrative subdivision, etc. -1 if it is a combination of several countries (e.g.  https://unstats.un.org/unsd/methodology/m49/ and https://en.m.wikipedia.org/wiki/United_Nations_geoscheme_for_Africa). NULL for non-admin areas';
COMMENT ON COLUMN aggregation_area.parent        IS 'The id of the administrative area containing this one. NULL for countries and for non-admin areas';



