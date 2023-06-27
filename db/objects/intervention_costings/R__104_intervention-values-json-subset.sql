CREATE OR REPLACE view intervention_values_json_subset AS

select intervention_id, header1, header2, jsonb_agg(data) from (
	select intervention_id, header1, header2, json_build_object(
		'year0', jsonb_array_elements((data::jsonb))->>'year0',
		'year0Edited', jsonb_array_elements((data::jsonb))->>'year0Edited',
		'year0Formula', jsonb_array_elements((data::jsonb))->>'year0Formula',
		'year0Default', jsonb_array_elements((data::jsonb))->>'year0Default',
		'year1', jsonb_array_elements((data::jsonb))->>'year1',
		'year1Edited', jsonb_array_elements((data::jsonb))->>'year1Edited',
		'year1Formula', jsonb_array_elements((data::jsonb))->>'year1Formula',
		'year1Default', jsonb_array_elements((data::jsonb))->>'year1Default',
		'rowName', jsonb_array_elements((data::jsonb))->>'rowName',
		'rowIndex', jsonb_array_elements((data::jsonb))->>'rowIndex',
		'rowUnits', jsonb_array_elements((data::jsonb))->>'rowUnits',
		'labelText', jsonb_array_elements((data::jsonb))->>'labelText',
		'dataSource', jsonb_array_elements((data::jsonb))->>'dataSource',
		'isEditable', jsonb_array_elements((data::jsonb))->>'isEditable',
		'missingData', jsonb_array_elements((data::jsonb))->>'missingData',
		'missingRows', jsonb_array_elements((data::jsonb))->>'missingRows',
		'dataSource', jsonb_array_elements((data::jsonb))->>'dataSource',
		'dataCitation', jsonb_array_elements((data::jsonb))->>'dataCitation',
		'reportedRows', jsonb_array_elements((data::jsonb))->>'reportedRows',
		'dependentRows', jsonb_array_elements((data::jsonb))->>'dependentRows',
		'dataSourceDefault', jsonb_array_elements((data::jsonb))->>'dataSourceDefault'
	) as data from intervention_values_json ivj 
) subselect
group by intervention_id, header1, header2;

comment ON view intervention_values_json_subset IS 'Subset the intervention_values_json view to only include year0 and year1';

