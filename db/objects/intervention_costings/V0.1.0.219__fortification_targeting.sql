create table fortification_targeting(
    id                 integer primary key GENERATED BY DEFAULT AS identity,
    targeting_type	    text  CHECK (targeting_type in ('biofortification','agro-fortification')),
    file_name           text,
    row_index           integer,
    food_vehicle_id	    integer REFERENCES food_vehicle (id),
    crop				text,
    region	            text,
    is_region_targeted  boolean,
    zones_targeted 	    numeric,
    cultivation_area_ha numeric,
    targeted_area_ha    numeric,
    regional_share_pc	numeric
);


comment on table fortification_targeting is 'Table to store intervention costing fortification targeting data';

comment on column fortification_targeting.targeting_type      is 'The type of targeting - either biofortification or agro-fortification';
comment on column fortification_targeting.file_name           is 'The name of the excel file from which this data was loaded';
comment on column fortification_targeting.row_index           is 'Row number of the worksheet from where this data was taken';
comment on column fortification_targeting.food_vehicle_id     is 'Identifier for the food vehicle referencing the food_vehicle table';
comment on column fortification_targeting.crop                is 'Text which matches the IMPACT project name of the crop';
comment on column fortification_targeting.region              is 'Name of region';
comment on column fortification_targeting.is_region_targeted  is 'Region targeted for biofortification - Modeling assumption (changeable by user)';
comment on column fortification_targeting.zones_targeted      is 'Number of districts/zones within region targeted for biofortification - Modeling assumption (changeable by user)';
comment on column fortification_targeting.cultivation_area_ha is 'Area (ha) under cultivation';
comment on column fortification_targeting.targeted_area_ha    is 'Targeted area (ha) under cultivation';
comment on column fortification_targeting.regional_share_pc   is 'Regional share of total targeted area - percentage';
