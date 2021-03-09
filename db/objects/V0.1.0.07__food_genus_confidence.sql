CREATE TABLE food_genus_confidence (
    id    text   primary key
);

COMMENT ON TABLE food_genus_confidence IS 'Dictionary table of possible values used for indicating how confident we are in our matches to food_genus2 values';


INSERT INTO food_genus_confidence (id)
VALUES
    ('High')
    , ('Medium')
    , ('Low')

