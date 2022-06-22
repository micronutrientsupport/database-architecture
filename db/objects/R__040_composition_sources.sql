CREATE OR REPLACE VIEW composition_data_sources AS
select 
	c.id as country_id
	, m.id as micronutrient_id
	, cft.fct_list_id as composition_data_id
	, 'FCT hierarchy' as composition_data_name
	, 'FCT hierarchy' as composition_data_description
	, null as composition_data_metadata_id

from country c
join country_consumption_source ccs on ST_COVERS(ST_ENVELOPE(ccs.geometry), c.geometry)
join country_fct_list cft on ccs.id = cft.id
cross join micronutrient m;

COMMENT ON VIEW composition_data_sources IS 'View of simplified algorithm for "best" FCT for a given country';