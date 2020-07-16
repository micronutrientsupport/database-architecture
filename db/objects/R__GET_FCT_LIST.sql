CREATE OR REPLACE FUNCTION get_fct_list(geometry(Point, 4326))
RETURNS SETOF integer AS

$BODY$
BEGIN
    RETURN QUERY

    -- List of FCT overrides per location
    WITH OVERRIDE_FCTS AS (
        SELECT
            fct_id
            , name
            , "priority"
            , FCT_RIORITY.location_id
        FROM FCT_RIORITY
        LEFT JOIN "LOCATION" ON FCT_RIORITY.location_id = "LOCATION".id
        LEFT JOIN "FOOD_COMPOSITION_TABLE" ON FCT_RIORITY.fct_id = "FOOD_COMPOSITION_TABLE".id
    ),
    -- Smallest location that matches the requested geometry
    FIRST_LOCATION AS (
        SELECT *
        FROM "LOCATION"
        WHERE ST_Contains(geom, $1)
            ORDER BY ST_AREA(geom) ASC
            LIMIT 1
    )

    -- Return ordered list of override FCT priorities
    SELECT OVERRIDE_FCTS.fct_id as fct
    FROM FIRST_LOCATION
    JOIN OVERRIDE_FCTS
        ON OVERRIDE_FCTS.location_id = FIRST_LOCATION.id
    ORDER BY "priority" ASC;

    -- If no rows were returned then a special priority order for this location
    -- has not been specified.  Therefore follow the default ranking
    IF NOT FOUND THEN
        RETURN QUERY
        -- order FCTs for a given location such that the newest FCT is used
        -- (and older FCTs for that location ignored)
        WITH ORDERED_FCTS AS(
            SELECT
                *
                ,row_number() OVER (PARTITION BY location_id ORDER BY date DESC) as order
            FROM "FOOD_COMPOSITION_TABLE"
        )

        -- return the newest FCT for each matching location
        -- with the smallest area match first
        SELECT
            ORDERED_FCTS.id as fct
        FROM
            "LOCATION"
            LEFT JOIN ORDERED_FCTS ON ORDERED_FCTS.location_id = "LOCATION".id
            AND ORDERED_FCTS.order = 1
        WHERE
            ST_Contains(geom, $1)
        ORDER BY
            ST_AREA(geom) ASC;
    END IF;

    RETURN;
END
$BODY$
LANGUAGE plpgsql;

-- Example call for Malawi
-- SELECT get_fct_list(ST_SetSRID( ST_Point( 34, -14), 4326));

-- Example call for Ethiopia
--SELECT get_fct_list(ST_SetSRID( ST_Point( 38, 8), 4326));

-- Example call for UK
--SELECT get_fct_list(ST_SetSRID( ST_Point( 0, 52), 4326));
