create materialized VIEW IF NOT EXISTS  intervention_cell_formula_deps as
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
where id.is_user_editable = false

