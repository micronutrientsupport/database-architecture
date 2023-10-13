
--drop table intervention_data;

create table intervention_data
(
id                  integer primary key GENERATED BY DEFAULT AS identity,
intervention_id     integer REFERENCES intervention (id),
row_index           integer,
row_name            text,
header1             text,
header2             text,
factor_text         text,
year_0              numeric,
year_1              numeric,
year_2              numeric,
year_3              numeric,
year_4              numeric,
year_5              numeric,
year_6              numeric,
year_7              numeric,
year_8              numeric,
year_9              numeric,
notes               text,
units               text,
is_user_editable    boolean,
is_calculated       boolean default false,
year_0_overriden    boolean default false,
year_1_overriden    boolean default false,
year_2_overriden    boolean default false,
year_3_overriden    boolean default false,
year_4_overriden    boolean default false,
year_5_overriden    boolean default false,
year_6_overriden    boolean default false,
year_7_overriden    boolean default false,
year_8_overriden    boolean default false,
year_9_overriden    boolean default false
);

COMMENT on table intervention_data is 'Table to store data directly loaded from excel spreadsheet intervention costing models';

COMMENT ON COLUMN intervention_data.row_index           IS 'The row number of the data as it was in the excel spreadsheet e.g. cell B11 would have row_index = 11';
COMMENT ON COLUMN intervention_data.row_name            IS 'a script-friendly name for a row that is the same for all food vehicles of a given intervetnion type e.g. Large-Scale Food Fortification (LSFF) will have "number_domestic_factories" for both wheat flour interventions and oil interventions, even though the factor_text is different ("Number of domestic industrial mills (capacity of > 20 MT/day)" vs. "Number of domstic industrial edible oil refineries (capacity of > 5 MT/day)") ';
COMMENT ON COLUMN intervention_data.header1             IS 'The header/section to which this fields belongs. Relates directly to headings in the UI';
COMMENT ON COLUMN intervention_data.header2             IS 'The subheader/subsection to which this fields belongs. Relates directly to subheadings in the UI';
COMMENT ON COLUMN intervention_data.factor_text         IS 'The full text for this factor, as written in the excel sheet. Will be displayed like this in the UI';
COMMENT ON COLUMN intervention_data.year_0              IS 'year_0 through year_9 contain the data values for the 10 years for this factor.';
COMMENT ON COLUMN intervention_data.notes               IS 'Additional notes about the data e.g. assumptions and citation sources. Imported for completeness, will not be displayed in the UI';
COMMENT ON COLUMN intervention_data.units               IS 'The units applicable to the values in the year columns, whether percentages, units of measure or counts of items.';
COMMENT ON COLUMN intervention_data.is_user_editable    IS 'Indication of whether this row is editable by the user, i.e. the value can be updated in the front-end, or is calculated or sourced elsewhere.';
COMMENT ON COLUMN intervention_data.is_calculated       IS 'Indication of whether this row should be calculated based on its cell formula (unless overridden)';
COMMENT ON COLUMN intervention_data.year_0_overriden    IS 'Indication of whether this cell which contained a formula has been overriden by a user and should no longer be auto-calculated';
