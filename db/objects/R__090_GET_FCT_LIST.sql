CREATE OR REPLACE FUNCTION get_fct_list(geometry(Point, 4326))
RETURNS SETOF integer AS

-- returns fct_source_id's ordered by their priority for the given location.
-- The priority is based on distance, area and publication date.

$BODY$
BEGIN
    -- lists Food Composition Tables, ordered by their distance to the input geometry, area of the region covered by the FCT and publication_date.
	RETURN query
		select id
		FROM fct_source
		ORDER BY
			--priority asc
			ST_DISTANCE($1, geometry) asc,
			area asc,
			publication_date desc;
	RETURN;

END
$BODY$
LANGUAGE plpgsql;

-- Example call for Malawi
-- SELECT get_fct_list(ST_SetSRID( ST_Point( 33, -14), 4326));

-- Example call for Ethiopia
-- SELECT get_fct_list(ST_SetSRID( ST_Point( 38,   8), 4326));

-- Example call for UK
-- SELECT get_fct_list(ST_SetSRID( ST_Point( 0, 52), 4326));
