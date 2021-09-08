CREATE OR REPLACE VIEW biomarker_data_sources AS
with surveys as (
    select 
        survey.id as survey_id
        , the_biomarker_name as biomarker_name
        , the_biomarker_groups as group_id
        , micronutrient_id
        , survey.name as survey_name
        , survey.description as survey_description
        , survey.geonetwork_uuid as survey_metadata_id
        , country.id as country_id
        , ROW_NUMBER() over                    --negate rank
          (partition by country.id, the_biomarker_name order BY			
			ST_AREA(survey.geometry) ASC
			, publication_date desc
			) 
            as rank

from country join survey on ST_COVERS(ST_ENVELOPE(survey.geometry), country.geometry)
join survey_reported_biomarkers srb on survey.id=srb.survey_id 
join survey_reported_groups srg on survey.id=srg.survey_id
CROSS  JOIN unnest (srb.reported_biomarkers) as the_biomarker_name
CROSS  JOIN unnest (srg.reported_groups) as the_biomarker_groups
join biomarker_micronutrient_mapping bmm on the_biomarker_name=bmm.biomarker_name
where survey.survey_type = 'biomarker' 
)
select country_id, biomarker_name, group_id, micronutrient_id, survey_id, survey_name, survey_description, survey_metadata_id from surveys
where rank = 1;

COMMENT ON VIEW biomarker_data_sources IS 'View of simplified algorithm for "best" biomarker data source for a given country';