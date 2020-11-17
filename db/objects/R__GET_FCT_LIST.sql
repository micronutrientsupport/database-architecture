CREATE OR REPLACE FUNCTION get_fct_list(geometry(Point, 4326))
RETURNS SETOF integer AS

-- when given a point, returns a list of fct ids, ordered by FCT_PRIORITY, size, newness.

$BODY$
BEGIN
	-- list Food Composition Tables that overlap, sort them by priority, then area, then publication date
	RETURN query
		SELECT
			id
		FROM
			fct_source
		WHERE
			ST_Contains(geometry, $1)
		ORDER BY
			--priority asc
			ST_AREA(geometry) ASC
			, publication_date DESC
		;

	IF NOT FOUND THEN-- special postgres variable, set depending on if the previous query returns results
		RETURN QUERY
		-- Find several close bounding boxes first, before measuring accurate distance from the search point to the nearest FCT-area border
		WITH closest_candidates AS (
			SELECT
				id,
				publication_date,
				geometry
			FROM FCT_SOURCE
			ORDER BY
				FCT_SOURCE.geometry <#> $1 -- <#> is an operator that find the distance to the nearest bounding-box edge
			LIMIT 10
		)
		SELECT
			id
		FROM
			closest_candidates
		ORDER BY
			--priority asc
			ST_DISTANCE($1, closest_candidates.geometry)
			-- We do not sort by smallest to largest, because smaller FCTs are likely to be more specific to their own area and less likely to be applicable to elsewhere
			--ST_AREA(geometry) ASC,
			, publication_date DESC
		;
	END IF;

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
