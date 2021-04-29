CREATE TABLE food_genus (
    id                     text primary key
    , food_name            text
    , description          text
    , food_group_id        integer references food_group (id)

);

COMMENT ON TABLE food_genus IS 'List of fooditems derived from a standardised food name database. used to standardise and match food names from the consumption tables to the food composition table (fooditem)';
COMMENT on column food_genus.food_name       IS 'The name of the fooditem as given by the food name database';
COMMENT on column food_genus.description     IS 'The description of the fooditem as given by the food name database';
COMMENT on column food_genus.food_group_id      IS 'The FAO food group of this food genus. References the food_group table';