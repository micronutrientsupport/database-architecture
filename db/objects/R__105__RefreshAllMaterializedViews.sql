CREATE OR REPLACE FUNCTION RefreshAllMaterializedViews(schema_arg TEXT)
RETURNS INT
AS $$
DECLARE
    r RECORD;
BEGIN
    RAISE NOTICE 'Refreshing materialized view in schema %', schema_arg;
    FOR r IN
    	SELECT matviewname, schemaname
    	FROM pg_matviews
    	WHERE schemaname = schema_arg
    LOOP
        RAISE NOTICE 'Refreshing %.%', schema_arg, r.matviewname;
        EXECUTE 'REFRESH MATERIALIZED VIEW ' || quote_ident(r.schemaname) || '.' || quote_ident(r.matviewname);
    END LOOP;

    RETURN 1;
END
$$ LANGUAGE plpgsql;
