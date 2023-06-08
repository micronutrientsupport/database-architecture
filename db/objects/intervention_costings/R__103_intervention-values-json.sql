CREATE OR REPLACE VIEW intervention_values_json AS
SELECT
    intervention_data.intervention_id,
    intervention_data.header1,
    COALESCE(
        NULLIF(intervention_data.header2, ''),
        'All'
    ) AS header2,
    json_agg(
        json_build_object(
            'rowIndex',
            intervention_data.row_index,
            'labelText',
            intervention_data.factor_text,
            'rowName',
            intervention_data.row_name,
            'rowUnits',
            intervention_data.units,
            'isEditable',
            intervention_data.is_user_editable,
            'year0',
            intervention_data.year_0,
            'year0Default',
            intervention_parent.year_0,
            'year0Edited',
            intervention_data.year_0 != intervention_parent.year_0,
            'year1',
            intervention_data.year_1,
            'year1Default',
            intervention_parent.year_1,
            'year1Edited',
            intervention_data.year_1 != intervention_parent.year_1,
            'year2',
            intervention_data.year_2,
            'year2Default',
            intervention_parent.year_2,
            'year2Edited',
            intervention_data.year_2 != intervention_parent.year_2,
            'year3',
            intervention_data.year_3,
            'year3Default',
            intervention_parent.year_3,
            'year3Edited',
            intervention_data.year_3 != intervention_parent.year_3,
            'year4',
            intervention_data.year_4,
            'year4Default',
            intervention_parent.year_4,
            'year4Edited',
            intervention_data.year_4 != intervention_parent.year_4,
            'year5',
            intervention_data.year_5,
            'year5Default',
            intervention_parent.year_5,
            'year5Edited',
            intervention_data.year_5 != intervention_parent.year_5,
            'year6',
            intervention_data.year_6,
            'year6Default',
            intervention_parent.year_6,
            'year6Edited',
            intervention_data.year_6 != intervention_parent.year_6,
            'year7',
            intervention_data.year_7,
            'year7Default',
            intervention_parent.year_7,
            'year7Edited',
            intervention_data.year_7 != intervention_parent.year_7,
            'year8',
            intervention_data.year_8,
            'year8Default',
            intervention_parent.year_8,
            'year8Edited',
            intervention_data.year_8 != intervention_parent.year_8,
            'year9',
            intervention_data.year_9,
            'year9Default',
            intervention_parent.year_9,
            'year9Edited',
            intervention_data.year_9 != intervention_parent.year_9,
            'dataSource',
            data_citation.short_text,
            'dataSource',
	            case
                    when (
                        (intervention_data.year_0 != intervention_parent.year_0)
                        OR (intervention_data.year_1 != intervention_parent.year_1)
                        OR (intervention_data.year_2 != intervention_parent.year_2)
                        OR (intervention_data.year_3 != intervention_parent.year_3)
                        OR (intervention_data.year_4 != intervention_parent.year_4)
                        OR (intervention_data.year_5 != intervention_parent.year_5)
                        OR (intervention_data.year_6 != intervention_parent.year_6)
                        OR (intervention_data.year_7 != intervention_parent.year_7)
                        OR (intervention_data.year_8 != intervention_parent.year_8)
                        OR (intervention_data.year_9 != intervention_parent.year_9)
                    ) then
                        'User Edited'
                    else
                        data_citation.short_text
                end,
            'dataSourceDefault',
            data_citation.short_text,
            'dataCitation',
            data_citation.citation_text,
            'year0Formula',
            case when intervention_data.is_user_editable = false
            then 
            	icf.cell_formula_0
            else
            	null
            end,
            'year1Formula',
            case when intervention_data.is_user_editable = false
            then 
            	icf.cell_formula_1
            else
            	null
            end,
            'year2Formula',
            case when intervention_data.is_user_editable = false
            then 
            	icf.cell_formula_2
            else
            	null
            end,
            'year3Formula',
            case when intervention_data.is_user_editable = false
            then 
            	icf.cell_formula_3
            else
            	null
            end,
            'year4Formula',
            case when intervention_data.is_user_editable = false
            then 
            	icf.cell_formula_4
            else
            	null
            end
        )
        ORDER BY
            intervention_data.row_index ASC
    ) AS data
FROM
    intervention_data intervention_data
    join intervention on intervention_data.intervention_id = intervention.id
    left join data_citation on data_citation.id = intervention.data_citation_id
    -- Re-join intervention_data to get the values for the parent intervention
    left join intervention_data intervention_parent
    	ON intervention_parent.row_index = intervention_data.row_index
    	and intervention_parent.intervention_id = intervention.parent_intervention
    left join intervention_cell_formula icf on icf.intervention_id = intervention_data.parent_intervention
     and icf.row_index = intervention_data.row_index 
WHERE
    intervention_data.header1 IS NOT null
GROUP BY
    intervention_data.intervention_id,
    intervention_data.header1,
    intervention_data.header2;

comment ON view intervention_values_json IS 'Aggregate intervention_data year fields into json object';
