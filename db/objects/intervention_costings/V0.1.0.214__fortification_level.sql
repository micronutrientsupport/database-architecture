
CREATE TABLE fortification_level(
    id                            integer   PRIMARY KEY NOT NULL GENERATED BY DEFAULT AS IDENTITY
    , intervention_id             integer   REFERENCES intervention(id)
    , fortificant_id              integer   REFERENCES fortificant(id)
    , year                        integer
    , fortificant_proportion      numeric
    , fortificant_price           numeric
    , target_level                numeric
    , actual_level                numeric
    -- , fortifiable_percentage      numeric,
    -- , fortified_percentage        numeric
)
;

COMMENT ON TABLE fortification_level IS '';
COMMENT ON COLUMN fortification_level.fortificant_proportion IS 'What percentage of the premix this fortificant makes up';
-- COMMENT ON COLUMN fortification_level.fortifiable_percentage IS 'The percentage of the food vehicle (e.g. wheat flour, oil, etc) that is in the food system i.e. commercially produced and transported and thus available for monitoring and modification, as opposed to e.g. homegrown. The percent of e.g. wheat flour that is milled on and insdustrial scale.';
-- COMMENT ON COLUMN fortification_level.fortified_percentage IS 'The percentage of the food vehicle (e.g. wheat flour, oil, etc.) out of the potentially fortifiable food vehicle (see fortifiable_percentage) that is actually fortified';


