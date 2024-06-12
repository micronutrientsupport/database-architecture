CREATE TABLE intervention_expected_losses(
    id                     integer primary key generated by default as identity,
    intervention_id             integer  NOT NULL REFERENCES intervention(id),
    micronutrient_id            text references micronutrient (id),
    expected_losses             numeric,
    expected_losses_default     numeric,
    source                      text,
    CHECK (expected_losses BETWEEN 0 AND 1)
)
;

COMMENT ON TABLE intervention_expected_losses IS 'The percentage of micronutrient that is expect to be lost between fortification and consumption e.g. some micronutrients deteriorate if exposed to heat on the way from the factory to the kitchen';

COMMENT ON COLUMN intervention_expected_losses.expected_losses IS 'How much micronutrient is lost, in percent.';
