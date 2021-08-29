create or replace view survey_reported_biomarkers as

with survey_measurements as 
(
select h.survey_id, bm.* from biomarker_measurement bm 
join household_member hm 
on bm.household_member_id=hm.id
join household h 
on hm.household_id = h.id
)

select survey_id, 

       string_to_array(
       		CONCAT_WS(',', 
				CASE WHEN sum(haemoglobin) IS NULL THEN NULL ELSE 'haemoglobin' END,
				CASE WHEN sum(ferritin) IS NULL THEN NULL ELSE 'ferritin' END,
				CASE WHEN sum(stfr) IS NULL THEN NULL ELSE 'stfr' END,
				CASE WHEN sum(rbp) IS NULL THEN NULL ELSE 'rbp' END,
				CASE WHEN sum(retinol) IS NULL THEN NULL ELSE 'retinol' END,
				CASE WHEN sum(rbc_folate) IS NULL THEN NULL ELSE 'rbc_folate' END,
				CASE WHEN sum(ps_folate) IS NULL THEN NULL ELSE 'ps_folate' END,
				CASE WHEN sum(vitamin_b12) IS NULL THEN NULL ELSE 'vitamin_b12' END,
				CASE WHEN sum(zinc) IS NULL THEN NULL ELSE 'zinc' END,
				CASE WHEN sum(crp) IS NULL THEN NULL ELSE 'crp' END,
				CASE WHEN sum(agp) IS NULL THEN NULL ELSE 'agp' END,
				CASE WHEN sum(iodine) IS NULL THEN NULL ELSE 'iodine' END
			)
       , ',')
       AS "reported_biomarkers"

from survey_measurements group by survey_id;

COMMENT ON VIEW survey_reported_biomarkers IS 'View of array of reported biomarkers for a given biomarker survey';
