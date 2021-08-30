create or replace view diet_data_sources as 

select comds.country_id
, micronutrient_id
, consumption_data_type
, consumption_data_id
, consumption_data_description
, consumption_data_metadata_id
, composition_data_id
, composition_data_description
, composition_data_metadata_id
, 'Dietary supply estimate (' || consumption_data_name || ', ' || composition_data_name || ' FCT)' as combined_name

from composition_data_sources comds 
join consumption_data_sources conds 
on comds.country_id =conds.country_id;

COMMENT ON VIEW diet_data_sources IS 'Almagam view of "best" consumption and composition data for a given country';
