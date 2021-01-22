CREATE TABLE foodex_confidence (
    id    text   primary key
);

COMMENT ON TABLE foodex_confidence IS 'Dictionary table of possible values used for indicating how confident we are in our matches to foodex2 values';


INSERT INTO foodex_confidence (id)
VALUES
    ('High')
    , ('Medium')
    , ('Low')

