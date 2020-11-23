CREATE OR REPLACE VIEW vw_country AS
SELECT
    id
    , name
    , ST_AsGeoJSON(geometry) as geometry-- return as GeoJSON for API consumption

FROM
    country

COMMENT ON VIEW vw_country IS 'View on country table returning geometry as GeoJSON'