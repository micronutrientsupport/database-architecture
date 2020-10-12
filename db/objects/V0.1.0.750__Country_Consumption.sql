
CREATE TABLE COUNTRY_CONSUMPTION (
    id                     integer primary key GENERATED BY DEFAULT AS IDENTITY
    , fooditem_id          integer references fooditem (id)
    , country_id           text    references country (id)
    , amount_consumed_in_g numeric(10,3)

);

COMMENT ON TABLE COUNTRY_CONSUMPTION IS 'What food items what been consumed per capita per year in a country, and in what quantity.';
COMMENT on column COUNTRY_CONSUMPTION.fooditem_id          IS 'The id of the fooditem that was consumed';
COMMENT on column COUNTRY_CONSUMPTION.country_id           IS 'The id of the country that consumed the food item';
COMMENT on column COUNTRY_CONSUMPTION.amount_consumed_in_g IS 'How much of the fooditem was consumed, in grams';
