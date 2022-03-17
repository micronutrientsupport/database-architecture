

create table impact_projections
(id                 integer primary key GENERATED BY DEFAULT AS identity,
file_name           text,
row_index           integer,
food_vehicle_id	    integer REFERENCES food_vehicle (id),
crop				text,
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
source              text);

comment on table impact_projections is 'A table to store the data in IMPACT projections worksheets included in intervention costings excel files';

comment on column impact_projections.file_name is 'The name of the excel file from which this data was loaded';
comment on column impact_projections.row_index is 'Row number of the worksheet from where this data was taken';
comment on column impact_projections.food_vehicle_id is 'Identifier for the food vehicle referencing the food_vehicle table';
comment on column impact_projections.crop is 'Text which matches the IMPACT project name of the crop';
comment on column impact_projections.year_0 is 'The data applicable to the start year of this intervention and so on with other year columns';
comment on column impact_projections.source is 'The cited source of the data';
