CREATE TABLE Subregion (
	id         text primary key ---ISO 3166  two letter codes
	, name     text
    , country  text REFERENCES country (id)
	, type     text
	, geometry geometry(MultiPolygon,4326)
);
COMMENT ON TABLE Subregion IS 'Level 1 subnational regions from GADM';

CREATE INDEX subregion_geometry_idx ON Subregion USING GIST (geometry);
