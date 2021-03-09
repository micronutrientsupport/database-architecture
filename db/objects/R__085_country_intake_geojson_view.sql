update country_consumption set data_source_id = 1 where date_consumed = '2018-01-01';

DROP MATERIALIZED VIEW IF EXISTS country_intake_geojson;
CREATE MATERIALIZED VIEW country_intake_geojson AS

select ci.country_id, ci.fct_source_id, ci.data_source_id, mn.mn_name, mn.mn_value, geojson.* 
from country_intake ci
     CROSS JOIN LATERAL (select id, fooditem_column from micronutrient)
		AS mn("mn_name", "mn_value")
		, get_country_intake_geojson(ci.country_id, ci.fct_source_id, ci.data_source_id, mn.mn_value) geojson