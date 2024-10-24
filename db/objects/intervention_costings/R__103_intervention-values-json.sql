CREATE OR REPLACE FUNCTION get_intervention_template_parent_id(int_id integer, OUT parent_id integer)
 RETURNS integer
 LANGUAGE plpgsql
AS $function$
declare

    schema text = CURRENT_SCHEMA();
    BEGIN
        EXECUTE '
			with recursive rec_a (id, name, parent_id) AS
			    (
			      SELECT intervention.* FROM "' || schema || '".intervention WHERE id = ' || int_id || '
			      UNION ALL
			      SELECT intervention.* FROM rec_a, "' || schema || '".intervention WHERE intervention.id = rec_a.parent_intervention
			    )
			    SELECT id as template_parent FROM rec_a where is_premade = true;
		' INTO  parent_id;
    END;
$function$
;



CREATE OR REPLACE VIEW intervention_values_json AS

with omitfields as (
    select
        array[
        	'total_startup_cost_gov',
            'total_startup_cost_industry',
            'total_gov_recurring_monitoring_cost',
            'total_recurring_premix_cost',
            'total_industry_recurring_fortification_cost'
        ] as mapping
), grouped_rows as (
	select 
		intervention_id
		, header1
		, header2
		, array_agg(row_index) as reported_rows
	from intervention_data
	WHERE
    header1 IS NOT null
GROUP BY
    intervention_id,
   	header1,
    header2
)
SELECT
    intervention_data.intervention_id,
    intervention_data.header1,
    max(intervention_data.row_index) as max_row,
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
            'isCalculated',
            intervention_data.is_calculated,
            'year0',
            intervention_data.year_0,
            'year0Default',
            intervention_parent.year_0,
            'year0Edited',
            coalesce(intervention_data.year_0 != intervention_parent.year_0,false),
            'year1',
            intervention_data.year_1,
            'year1Default',
            intervention_parent.year_1,
            'year1Edited',
            coalesce(intervention_data.year_1 != intervention_parent.year_1,false),
            'year2',
            intervention_data.year_2,
            'year2Default',
            intervention_parent.year_2,
            'year2Edited',
            coalesce(intervention_data.year_2 != intervention_parent.year_2,false),
            'year3',
            intervention_data.year_3,
            'year3Default',
            intervention_parent.year_3,
            'year3Edited',
            coalesce(intervention_data.year_3 != intervention_parent.year_3,false),
            'year4',
            intervention_data.year_4,
            'year4Default',
            intervention_parent.year_4,
            'year4Edited',
            coalesce(intervention_data.year_4 != intervention_parent.year_4,false),
            'year5',
            intervention_data.year_5,
            'year5Default',
            intervention_parent.year_5,
            'year5Edited',
            coalesce(intervention_data.year_5 != intervention_parent.year_5,false),
            'year6',
            intervention_data.year_6,
            'year6Default',
            intervention_parent.year_6,
            'year6Edited',
            coalesce(intervention_data.year_6 != intervention_parent.year_6,false),
            'year7',
            intervention_data.year_7,
            'year7Default',
            intervention_parent.year_7,
            'year7Edited',
            coalesce(intervention_data.year_7 != intervention_parent.year_7,false),
            'year8',
            intervention_data.year_8,
            'year8Default',
            intervention_parent.year_8,
            'year8Edited',
            coalesce(intervention_data.year_8 != intervention_parent.year_8,false),
            'year9',
            intervention_data.year_9,
            'year9Default',
            intervention_parent.year_9,
            'year9Edited',
            coalesce(intervention_data.year_9 != intervention_parent.year_9,false),
            'year0Overriden',
            intervention_data.year_0_overriden,
            'year1Overriden',
            intervention_data.year_1_overriden,
            'year2Overriden',
            intervention_data.year_2_overriden,
            'year3Overriden',
            intervention_data.year_3_overriden,
            'year4Overriden',
            intervention_data.year_4_overriden,
            'year5Overriden',
            intervention_data.year_5_overriden,
            'year6Overriden',
            intervention_data.year_6_overriden,
            'year7Overriden',
            intervention_data.year_7_overriden,
            'year8Overriden',
            intervention_data.year_8_overriden,
            'year9Overriden',
            intervention_data.year_9_overriden,
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
                        intervention_data.source
                end,
            'dataSourceDefault',
            intervention_data.source,
            'dataCitation',
            data_citation.citation_text
           )::jsonb || json_build_object(
            'rowNotes',
            intervention_data.notes,
            'year0Formula',
			year_0_formula,
            'year1Formula',
            year_1_formula,
            'year2Formula',
            year_2_formula,
            'year3Formula',
            year_3_formula,
            'year4Formula',
            year_4_formula,
            'year5Formula',
            year_5_formula,
            'year6Formula',
            year_6_formula,
            'year7Formula',
            year_7_formula,
            'year8Formula',
            year_8_formula,
            'year9Formula',
            year_9_formula,
            'dependentRows',
            dependent_rows,
            'reportedRows',
            case when intervention_data.is_user_editable = false or intervention_data.is_calculated = true
            then 
            	gr.reported_rows
            else
            	null
            end,
            'missingRows',
            case when intervention_data.is_user_editable = false or intervention_data.is_calculated = true
            then 
            	(SELECT array_agg(unnest ORDER BY unnest)
	            FROM (
	            SELECT * FROM unnest(
                   dependent_rows
                )
	            except 
	            	select * from unnest(gr.reported_rows)) as sub)
            else
            	null
            end,
            'missingData',
            case when intervention_data.is_user_editable = false  or intervention_data.is_calculated = true
            then 
	            (select 
	           		json_object_agg(row_index, 
	           			json_build_object(
	           				'rowIndex', row_index, 
	           				'year0', year_0,
	           				'year1', year_1,
	           				'year2', year_2,
	           				'year3', year_3,
	           				'year4', year_4,
	           				'year5', year_5,
	           				'year6', year_6,
	           				'year7', year_7,
	           				'year8', year_8,
	           				'year9', year_9
	           			)
	           		) from (
	            	select 
	            		year_0
	            		, year_1
	            		, year_2
	            		, year_3
	            		, year_4
	            		, year_5
	            		, year_6
	            		, year_7
	            		, year_8
	            		, year_9
	            		, not_reported.row_index 
	            	from intervention_data i
	            	JOIN	(
	            		-- select ids that are in the missingRows but not in reported rows
		            	SELECT unnest as row_index FROM unnest(
		            		dependent_rows
		            	)
		            		except 
		            	select * from unnest(gr.reported_rows) as index
	            	) as not_reported
	            	on not_reported.row_index = i.row_index
	            	where i.intervention_id = intervention_data.intervention_id
	            	) 
	            as missing_data)
            else
            	null
            end
        )::jsonb
        ORDER BY
            intervention_data.row_index ASC
    ) AS data
FROM
    omitfields,
    intervention_data intervention_data
    join intervention on intervention_data.intervention_id = intervention.id
    left join data_citation on data_citation.id = intervention.data_citation_id
    -- Re-join intervention_data to get the values for the parent intervention
    left join intervention_data intervention_parent
    	ON intervention_parent.row_index = intervention_data.row_index
    	and intervention_parent.intervention_id = intervention.template_intervention
        and intervention_parent.intervention_status = intervention.intervention_status
        and intervention_parent.intervention_nature = intervention.intervention_nature
    left join intervention_cell_formula_deps icf on icf.intervention_id = coalesce(intervention.template_intervention, intervention.parent_intervention, intervention.id)
     and icf.row_index = intervention_data.row_index 
    left join grouped_rows gr 
    	on intervention_data.intervention_id = gr.intervention_id and intervention_data.header1 = gr.header1 and intervention_data.header2 = gr.header2
WHERE
    intervention.is_premade = false
    and intervention_data.header1 IS NOT null
    and not (intervention_data.row_name = ANY (omitfields.mapping))
GROUP BY
    intervention_data.intervention_id,
    intervention_data.header1,
    intervention_data.header2;
    
comment ON view intervention_values_json IS 'Aggregate intervention_data year fields into json object';
