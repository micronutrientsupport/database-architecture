CREATE OR REPLACE VIEW composition_data_sources AS

with unnest_fct_list as (
select dfl.id, unnest(fct_list::text[])::int as a 
from distinct_fct_list dfl
),
fct_list_description as (
select 
	ufl.id
	, concat('FCT Order: ', string_agg(name,', ')) as description
	from unnest_fct_list ufl 
	join fct_source fs2 
	on fs2.id = ufl.a group by ufl.id
)
SELECT c.id AS country_id,
    m.id AS micronutrient_id,
    cft.fct_list_id AS composition_data_id,
    'FCT Prioritised Hierarchy'::text AS composition_data_name,
    fld.description AS composition_data_description,
    NULL::text AS composition_data_metadata_id
   FROM country c
     JOIN country_consumption_source ccs ON st_covers(st_envelope(ccs.geometry), c.geometry)
     JOIN country_fct_list cft ON ccs.id = cft.id
     join fct_list_description fld on cft.fct_list_id = fld.id
     CROSS JOIN micronutrient m;

COMMENT ON VIEW composition_data_sources IS 'View of simplified algorithm for "best" FCT for a given country';