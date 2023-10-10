
create or replace function array_unique (a text[]) returns text[] as $$
  select array (
    select distinct v from unnest(a) as b(v)
  )
$$ language sql;

create or replace function array_unique (a integer[]) returns integer[] as $$
  select array (
    select distinct v from unnest(a) as b(v)
  )
$$ language sql;

create or replace FUNCTION parse_dependent_cells_from_excel_formula(text) RETURNS text[]
AS 'select array_agg(distinct cells) from REGEXP_MATCHES(RIGHT($1, -(POSITION(''='' IN $1))), ''\$?[A-Z]+\$?\d+'',''g'') cells;'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

create or replace FUNCTION parse_dependent_cells_from_excel_formulae_array(text[]) RETURNS text[]
AS '
	with dependencies as (
	select unnest(parse_dependent_cells_from_excel_formula(formulae)) as cells
	from unnest(
		$1
	)
	as formulae
	)
	select array_unique(array_agg(cells)) from dependencies
'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

create or replace FUNCTION parse_dependent_rows_from_excel_formula(text) RETURNS integer[]
AS 'select array_agg(distinct cells:: integer[]) from REGEXP_MATCHES(RIGHT($1, -(POSITION(''='' IN $1))), ''\$?[A-Z]+\$?(\d+)'',''g'') cells;'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

create or replace FUNCTION parse_dependent_rows_from_excel_formulae_array(text[]) RETURNS integer[]
AS '
	with dependencies as (
	select unnest(parse_dependent_rows_from_excel_formula(formulae)) as rows
	from unnest(
		$1
	)
	as formulae
	)
	select array_unique(array_agg(rows)) from dependencies
'
LANGUAGE SQL
IMMUTABLE
RETURNS NULL ON NULL INPUT;

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
            data_citation.citation_text
           )::jsonb || json_build_object(
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
            case when intervention_data.is_user_editable = false
            then 
            	gr.reported_rows
            else
            	null
            end,
            'missingRows',
            case when intervention_data.is_user_editable = false
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
            case when intervention_data.is_user_editable = false
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
    	and intervention_parent.intervention_id = intervention.parent_intervention
    left join intervention_cell_formula_deps icf on icf.intervention_id = coalesce(intervention.parent_intervention, intervention.id)
     and icf.row_index = intervention_data.row_index 
    left join grouped_rows gr 
    	on intervention_data.intervention_id = gr.intervention_id and intervention_data.header1 = gr.header1 and intervention_data.header2 = gr.header2
WHERE
    intervention_data.header1 IS NOT null
    and not (intervention_data.row_name = ANY (omitfields.mapping))
GROUP BY
    intervention_data.intervention_id,
    intervention_data.header1,
    intervention_data.header2;
    
comment ON view intervention_values_json IS 'Aggregate intervention_data year fields into json object';
