CREATE OR REPLACE VIEW composition_data_sources AS
with fcts as (
    select 
        fct_source.id as composition_data_id
        , fct_source.name as composition_data_name
        , country.id as country_id
        , ROW_NUMBER() over 
          (partition by country.id order BY			
			ST_AREA(fct_source.geometry) ASC
			, publication_date desc) 
            as rank

from country left join fct_source on ST_COVERS(ST_ENVELOPE(fct_source.geometry), country.geometry)
)
select composition_data_id, composition_data_name, country_id from fcts where fcts.rank=1;

COMMENT ON VIEW composition_data_sources IS 'View of simplified algorithm for "best" FCT for a given country';
