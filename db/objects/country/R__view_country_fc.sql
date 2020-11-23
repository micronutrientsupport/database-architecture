CREATE OR REPLACE VIEW vw_country_fc AS
SELECT json_build_object(
    'type', 'FeatureCollection',
    'features', json_agg(ST_AsGeoJSON(t.*)::json)
    ) as geojson_feature_collection 
    
FROM (
    SELECT 
        id
        , name
        , region
        , ST_ForcePolygonCCW(geometry) AS geometry
    FROM country WHERE geometry NOTNULL
    ) 
AS t;

COMMENT ON VIEW vw_country_fc IS 'View on country table returning a single GeoJSON feature collection';
    