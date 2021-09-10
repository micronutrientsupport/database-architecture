
CREATE TABLE expected_loss(
    micronutrient_id    text     NOT NULL REFERENCES micronutrient(id),
    intervention_id     integer  NOT NULL REFERENCES intervention(id),
    expected_loss_pc    numeric,
    CONSTRAINT "expected_loss_pk" PRIMARY KEY (micronutrient_id, intervention_id)
)
;


