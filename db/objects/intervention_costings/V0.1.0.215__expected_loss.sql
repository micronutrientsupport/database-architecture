
CREATE TABLE expected_loss(
    micronutrient_id            text     NOT NULL REFERENCES micronutrient(id),
    intervention_id             integer  NOT NULL REFERENCES intervention(id),
    expected_loss_percentage    numeric,
    CONSTRAINT "expected_loss_pk" PRIMARY KEY (micronutrient_id, intervention_id)
)
;

COMMENT ON TABLE expected_loss IS 'The percentage of micronutrient that is expect to be lost between fortification and consumption e.g. some micronutrients deteriorate if exposed to heat on the way from the factory to the kitchen';

COMMENT ON COLUMN expected_loss.expected_loss_percentage IS 'How much micronutrient is lost, in percent.';
