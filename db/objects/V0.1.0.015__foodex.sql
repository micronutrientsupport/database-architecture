CREATE TABLE foodex (
    id                     text primary key
    , food_name            text
    , description          text
    , food_group         text
    , food_subgroup      text

);

COMMENT ON TABLE foodex IS 'List of fooditems derived from the FOODEX2 database. used to standardise and match food names from the consumption tables to the food composition table (fooditem)';
COMMENT on column foodex.food_name       IS 'The name of the fooditem as given by the FOODEX" database';
COMMENT on column foodex.description     IS 'The description of the fooditem as given by the FOODEX" database';
COMMENT on column foodex.food_group      IS 'The top-level FAO (Food and Agriculture Organisation of the United Nations) food group for this foodex item. See http://www.fao.org/gift-individual-food-consumption/methodology/food-groups-and-sub-groups/en/';
COMMENT on column foodex.food_subgroup   IS 'The subgroup FAO (Food and Agriculture Organisation of the United Nations) food group for this foodex item. See http://www.fao.org/gift-individual-food-consumption/methodology/food-groups-and-sub-groups/en/';
