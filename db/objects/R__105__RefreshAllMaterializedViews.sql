CREATE OR REPLACE FUNCTION RefreshAllMaterializedViews(schema_arg TEXT)
RETURNS INT
AS $$
DECLARE
    r RECORD;
    starttime TIMESTAMP := clock_timestamp();
    sectionstarttime TIMESTAMP := clock_timestamp();
BEGIN
    RAISE NOTICE 'Refreshing materialized views for schema % at %', quote_ident(schema_arg), current_time;

    FOR r IN
    	SELECT matviewname, schemaname
    	FROM pg_matviews
    	WHERE schemaname = schema_arg
    	ORDER BY matviewname
    LOOP
        RAISE NOTICE 'Refreshing %.%', schema_arg, r.matviewname;

        EXECUTE 'REFRESH MATERIALIZED VIEW ' || quote_ident(r.schemaname) || '.' || r.matviewname;

        RAISE NOTICE '% %', r.matviewname, lpad((clock_timestamp() - sectionstarttime)::text, 75 - length(r.matviewname));
        sectionstarttime := clock_timestamp();
    END LOOP;

    RAISE NOTICE 'Cumulative time spent is %', clock_timestamp() - starttime ;
    RETURN 1;
END
$$ LANGUAGE plpgsql;
