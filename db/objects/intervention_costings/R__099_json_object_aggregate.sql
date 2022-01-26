--New aggregate function to support aggregation of
--json objects into a single json object
--
-- See: https://dba.stackexchange.com/questions/255127/merging-many-jsonb-objects-using-aggregate-functions-in-postgresql
--      https://faraday.ai/blog/how-to-aggregate-jsonb-in-postgres/
CREATE or replace AGGREGATE jsonb_object_aggregate(jsonb) (
    SFUNC = 'jsonb_concat',
    STYPE = jsonb,
    INITCOND = '{}'
);