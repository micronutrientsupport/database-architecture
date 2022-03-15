

-- drop table intervention_cell_formula;

create table intervention_cell_formula
(
file_name             text,
intervention_id       integer,
row_index 			  integer,
cell_reference        text,
cell_formula_0        text,
cell_formula_1        text,
cell_formula_2        text,
cell_formula_3        text,
cell_formula_4        text
);

COMMENT on table intervention_cell_formula is 'Table to store cell formulae loaded from excel spreadsheet costing models';