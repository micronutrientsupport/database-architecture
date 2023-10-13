CREATE OR REPLACE view intervention_values_json_subset AS

WITH expanded_data AS (
    SELECT intervention_id, header1, header2, max_row, jsonb_array_elements((data::jsonb)) AS expanded
    FROM intervention_values_json
)
select intervention_id, header1, header2, max(max_row) as max_row, json_agg(data) as data from (
	select intervention_id, header1, header2, max_row, json_build_object(
		'year0', (expanded->>'year0')::numeric,
		'year0Edited', (expanded->>'year0Edited')::boolean,
		'year0Formula', expanded->>'year0Formula',
		'year0Default', (expanded->>'year0Default')::numeric,
		'year1', (expanded->>'year1')::numeric,
		'year1Edited', (expanded->>'year1Edited')::boolean,
		'year1Formula', expanded->>'year1Formula',
		'year1Default', (expanded->>'year1Default')::numeric,
		'rowName', expanded->>'rowName',
		'rowIndex', (expanded->>'rowIndex')::numeric,
		'rowUnits', expanded->>'rowUnits',
		'labelText', expanded->>'labelText',
		'dataSource', expanded->>'dataSource',
		'isEditable', (expanded->>'isEditable')::boolean,
		'missingData', (expanded->>'missingData')::json,
		'missingRows', (expanded->>'missingRows')::json,
		'dataCitation', expanded->>'dataCitation',
		'reportedRows', (expanded->>'reportedRows')::json,
		'dependentRows', (expanded->>'dependentRows')::json,
		'dataSourceDefault', expanded->>'dataSourceDefault'
	) as data from expanded_data ivj 
) subselect
group by intervention_id, header1, header2;

comment ON view intervention_values_json_subset IS 'Subset the intervention_values_json view to only include year0 and year1';

