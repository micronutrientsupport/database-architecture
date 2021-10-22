create table intervention_cell_formula
(
intervention_id     integer,
cell_reference      text,
cell_formula        text
);

COMMENT on table intervention_cell_formula is 'Table to store cell formulae loaded from excel spreadsheet costing models';