CREATE TABLE food_genus (
    id                     text primary key
    , food_name            text
    , description          text
    , food_group         text
    , food_subgroup      text

);

COMMENT ON TABLE food_genus IS 'List of fooditems derived from a standardised food name database. used to standardise and match food names from the consumption tables to the food composition table (fooditem)';
COMMENT on column food_genus.food_name       IS 'The name of the fooditem as given by the food name database';
COMMENT on column food_genus.description     IS 'The description of the fooditem as given by the food name database';
COMMENT on column food_genus.food_group      IS 'The top-level FAO (Food and Agriculture Organisation of the United Nations) food group for this food_genus item. See http://www.fao.org/gift-individual-food-consumption/methodology/food-groups-and-sub-groups/en/';
COMMENT on column food_genus.food_subgroup   IS 'The subgroup FAO (Food and Agriculture Organisation of the United Nations) food group for this food_genus item. See http://www.fao.org/gift-individual-food-consumption/methodology/food-groups-and-sub-groups/en/';
