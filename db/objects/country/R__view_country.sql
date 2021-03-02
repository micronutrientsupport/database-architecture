DROP MATERIALIZED VIEW IF EXISTS vw_country;
CREATE MATERIALIZED VIEW vw_country AS
SELECT
    id
    , name
    , ST_AsGeoJSON(geometry) as geometry-- return as GeoJSON for API consumption

FROM
    country;

COMMENT ON VIEW vw_country IS 'View on country table returning geometry as GeoJSON';
