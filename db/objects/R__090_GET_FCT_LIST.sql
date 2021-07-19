CREATE OR REPLACE FUNCTION get_fct_list(geometry(Point, 4326))
RETURNS SETOF integer AS

-- returns fct_source_id's ordered by their priority for the given location.
-- The priority is based on distance, area and publication date.

$BODY$
BEGIN
    -- lists Food Composition Tables, ordered by their distance to the input geometry, area and publication_date.
	RETURN query
	select a.id from 
		(
        -- list Food Composition Tables which contain or overlap with the given geometry.
        SELECT
			id, 0 as "distance", ST_AREA(geometry) as "area", publication_date
		FROM
			fct_source
		WHERE
			ST_Contains(geometry, $1) OR ST_Overlaps(geometry, $1)
		UNION
        -- list all other FCT's, with a calulcated distance and area.
		select id, ST_DISTANCE($1, geometry) as "distance", ST_AREA(geometry) as "area", publication_date
		FROM fct_source) a
	ORDER BY
	--priority asc
	a.distance asc,
	a."area" asc,
	a.publication_date desc;

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
