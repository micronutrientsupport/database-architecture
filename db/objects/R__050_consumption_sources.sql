CREATE OR REPLACE VIEW consumption_data_sources AS

with country_consumption as (
    select 
        country_consumption_source.id as consumption_data_id
        , country_consumption_source.name as consumption_data_name
        , country_consumption_source.description as consumption_data_description
        , country_consumption_source.geonetwork_uuid as consumption_data_metadata_id
        , 'country' as consumption_data_type
        , country.id as country_id
        , ROW_NUMBER() over 
          (partition by country.id order BY			
			ST_AREA(country_consumption_source.geometry) ASC
			, publication_date desc) 
            as rank

from country join country_consumption_source on ST_COVERS(ST_ENVELOPE(country_consumption_source.geometry), country.geometry)
)
, household_consumption as (
    select 
        survey.id as consumption_data_id
        , survey.name as consumption_data_name
        , survey.description as consumption_data_description
        , survey.geonetwork_uuid as consumption_data_metadata_id
        , 'household' as consumption_data_type
        , country.id as country_id
        , -ROW_NUMBER() over                    --negate rank
          (partition by country.id order BY			
			ST_AREA(survey.geometry) ASC
			, publication_date desc) 
            as rank

from country join survey on ST_COVERS(ST_ENVELOPE(survey.geometry), country.geometry)
where survey.survey_type = 'food consumption' 
),
combined as (
select * from household_consumption where rank=-1
union 
select * from country_consumption where rank=1
)

-- select minimum means -1 will be selected for household where it exists
-- otherwise rank 1 will be country level
select country_id,
 consumption_data_id, 
 consumption_data_name, 
 consumption_data_description, 
 consumption_data_metadata_id, 
 consumption_data_type
from (
  select country_id, 
  		 rank,
         consumption_data_id,
         consumption_data_name,
         consumption_data_description,
         consumption_data_metadata_id,
         consumption_data_type,
         min(rank) over (partition by country_id) as min_rank
  from combined
) t
where rank = min_rank;

COMMENT ON VIEW consumption_data_sources IS 'View of simplified algorithm for "best" consumption data for a given country';
