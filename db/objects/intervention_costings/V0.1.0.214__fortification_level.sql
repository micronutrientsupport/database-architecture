
CREATE TABLE fortification_level(
    id                            integer   PRIMARY KEY NOT NULL GENERATED BY DEFAULT AS IDENTITY
    , intervention_id             integer   REFERENCES intervention(id)
    , fortificant_id              integer   REFERENCES fortificant(id)
    , year                        integer -- TODO - I don't think we need this column as premix calcs are not year-specific?
    , fortificant_amount          numeric
    , fortificant_proportion      numeric
    , fortificant_price           numeric
    , target_level                numeric
    , actual_level                numeric
)
;

COMMENT ON TABLE fortification_level IS 'Stores fortification levels, costs and amounts per intervention';

COMMENT ON COLUMN fortification_level.intervention_id         IS 'For which intervention these fortification levels apply';
COMMENT ON COLUMN fortification_level.fortificant_id          IS 'Which fortificant this is';
COMMENT ON COLUMN fortification_level.year                    IS 'For which year these fortification levels apply';
COMMENT ON COLUMN fortification_level.fortificant_amount      IS 'in mg/kg of food vehicle';
COMMENT ON COLUMN fortification_level.fortificant_proportion  IS 'What proprotion of the premix this fortificant makes up';
COMMENT ON COLUMN fortification_level.fortificant_price       IS 'The price of the fortificant, in US Dollars per kilogram';
COMMENT ON COLUMN fortification_level.target_level            IS 'The target micronutrient level (or government standard) in milligrams per kilogram';
COMMENT ON COLUMN fortification_level.actual_level            IS 'The actual micronutrient level as measured empirically, if substantially different from the target micronutrient level. This could be the case e.g. if fortification at the factories is not carried out effectively.';
