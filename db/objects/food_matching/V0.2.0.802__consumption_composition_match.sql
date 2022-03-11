
-- drop table if exists consumption_composition_match;

create table consumption_composition_match
(
    id                          integer primary key GENERATED BY DEFAULT AS identity,
    food_genus_id               text,
    household_id                integer,
    household_member_id         integer,
    fct_list                    text,
    micronutrient_id            text,
    micronutrient_composition   numeric,
    fct_used                    integer
);

COMMENT ON TABLE consumption_composition_match IS 'Table to store optimised match between food consumption and food composition';
COMMENT on column consumption_composition_match.fct_list is 'Prioritised list of food comsumption table sources (FCT) as generated by function get_fct_list';
COMMENT on column consumption_composition_match.food_genus_id is 'Identifier for the food item from fooditem table';
COMMENT on column consumption_composition_match.micronutrient_id is 'Micronutrient identifier';
COMMENT on column consumption_composition_match.micronutrient_composition is 'Amount of this micronutrient typically found in this food item';
COMMENT on column fct_list_food_compostion.fooditem_column is 'Name of food item';
COMMENT on column consumption_composition_match.fct_used is 'Which FCT is the source of the micronutrient_composition value in this record';  

comment on column consumption_composition_match.household_id is 'Identifier for the household';
comment on column consumption_composition_match.household_member_id is 'Identifier for the household member';
