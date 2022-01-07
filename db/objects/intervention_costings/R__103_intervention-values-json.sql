CREATE
OR REPLACE VIEW intervention_values_json AS
SELECT
    intervention_data.intervention_id,
    intervention_data.header1,
    COALESCE(
        NULLIF(intervention_data.header2, '' :: text),
        'All' :: text
    ) AS header2,
    json_agg(
        json_build_object(
            'rowIndex',
            intervention_data.row_index,
            'labelText',
            intervention_data.factor_text,
            'rowName',
            intervention_data.row_name,
            'year0',
            intervention_data.year_0,
            'year1',
            intervention_data.year_1,
            'year2',
            intervention_data.year_2,
            'year3',
            intervention_data.year_3,
            'year4',
            intervention_data.year_4,
            'year5',
            intervention_data.year_5,
            'year6',
            intervention_data.year_6,
            'year7',
            intervention_data.year_7,
            'year8',
            intervention_data.year_8,
            'year9',
            intervention_data.year_9
        )
        ORDER BY
            intervention_data.row_index
    ) AS data
FROM
    intervention_data
WHERE
    intervention_data.header1 IS NOT NULL
GROUP BY
    intervention_data.intervention_id,
    intervention_data.header1,
    intervention_data.header2;

comment ON view intervention_baseline_assumptions IS 'Aggregate intervention_data year fields into json object';