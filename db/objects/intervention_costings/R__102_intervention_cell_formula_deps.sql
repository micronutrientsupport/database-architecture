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

DROP MATERIALIZED VIEW IF EXISTS intervention_cell_formula_deps;
create materialized VIEW intervention_cell_formula_deps as
select 
icf.intervention_id
, icf.row_index
, cell_formula_1 as year_0_formula
, cell_formula_2 as year_1_formula
, cell_formula_3 as year_2_formula
, cell_formula_4 as year_3_formula
, cell_formula_5 as year_4_formula
, cell_formula_6 as year_5_formula
, cell_formula_7 as year_6_formula
, cell_formula_8 as year_7_formula
, cell_formula_9 as year_8_formula
, cell_formula_10 as year_9_formula
, parse_dependent_rows_from_excel_formulae_array(
     ARRAY[
       icf.cell_formula_1,
       icf.cell_formula_2,
       icf.cell_formula_3,
       icf.cell_formula_4,
       icf.cell_formula_5,
       icf.cell_formula_6,
       icf.cell_formula_7,
       icf.cell_formula_8,
       icf.cell_formula_9,
       icf.cell_formula_10
     ]
) as dependent_rows


from intervention_cell_formula icf 
join intervention_data id on id.intervention_id = icf.intervention_id AND id.row_index = icf.row_index
where id.is_user_editable = false OR id.is_calculated = true;


create or replace view intervention_formulae as 
 select  	
 	id.intervention_id,
 	id.row_index,
 	id.year_0_overriden,
 	icfd.year_0_formula,
 	id.year_1_overriden,
 	icfd.year_1_formula,
 	id.year_2_overriden,
 	icfd.year_2_formula,
 	id.year_3_overriden,
 	icfd.year_3_formula,
 	id.year_4_overriden,
 	icfd.year_4_formula,
 	id.year_5_overriden,
 	icfd.year_5_formula,
 	id.year_6_overriden,
 	icfd.year_6_formula,
 	id.year_7_overriden,
 	icfd.year_7_formula,
 	id.year_8_overriden,
 	icfd.year_8_formula,
 	id.year_9_overriden,
 	icfd.year_9_formula,
 	icfd.dependent_rows

 from  intervention_data id join intervention i on id.intervention_id = i.id
 join intervention_cell_formula_deps icfd on icfd.intervention_id = i.template_intervention  and icfd.row_index = id.row_index  
 