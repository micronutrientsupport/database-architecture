--
-- TABLE: expected_loss
--

CREATE TABLE expected_loss(
    micronutrient_id    text    NOT NULL,
    intervention_id     integer    NOT NULL,
    expected_loss_pc    numeric,
    CONSTRAINT "expected_loss_pk" PRIMARY KEY (micronutrient_id, intervention_id)
)
;


--
-- TABLE: expected_loss
--

ALTER TABLE expected_loss ADD CONSTRAINT "Refmicronutrient151"
    FOREIGN KEY (micronutrient_id)
    REFERENCES micronutrient(micronutrient_id)
;

ALTER TABLE expected_loss ADD CONSTRAINT "Refintervention161"
    FOREIGN KEY (intervention_id)
    REFERENCES intervention(intervention_id)
;
