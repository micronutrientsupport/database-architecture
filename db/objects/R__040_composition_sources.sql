CREATE OR REPLACE VIEW composition_data_sources AS
with fcts as (
    select 
        fct_source.id as composition_data_id
        , fct_source.name as composition_data_name
        , fct_source.description as composition_data_description
        , fct_source.geonetwork_uuid as composition_data_metadata_id
        , country.id as country_id
        , frm.reported_micronutrients 
        , micronutrient_id 
        , ROW_NUMBER() over 
          (partition by country.id, micronutrient_id order BY			
			ST_AREA(fct_source.geometry) ASC
			, publication_date desc) 
            as rank

from country 
join fct_source on ST_COVERS(ST_ENVELOPE(fct_source.geometry), country.geometry)
join fct_reported_micronutrients frm on fct_source.id=frm.fct_source_id 
CROSS  JOIN unnest (frm.reported_micronutrients) micronutrient_id
)
select country_id, micronutrient_id, composition_data_id, composition_data_name, composition_data_description, composition_data_metadata_id from fcts
where rank = 1;

COMMENT ON VIEW composition_data_sources IS 'View of simplified algorithm for "best" FCT for a given country';