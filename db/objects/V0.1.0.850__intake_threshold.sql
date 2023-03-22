CREATE TABLE intake_threshold (
    id                     integer primary key generated by default as IDENTITY
    , nutrient             text
    , nutrient_name        text
    , unit_adequacy        text
    , unit_excess          text
    , reference_person     text
    , EAR                  numeric(20,10)
    , UL                   numeric(20,10)
    , notes                text
    , source               text
);
