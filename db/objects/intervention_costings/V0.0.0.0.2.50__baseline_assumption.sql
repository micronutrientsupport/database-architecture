--
-- TABLE: baseline_assumption
--

CREATE TABLE baseline_assumption(
    assumption_id      integer NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    assumption_name    text,
    intervention_id    integer    NOT NULL,
    CONSTRAINT "baseline_assumption_pk" PRIMARY KEY (assumption_id)
)
;

--
-- TABLE: baseline_assumption
--

ALTER TABLE baseline_assumption ADD CONSTRAINT "Refintervention341"
    FOREIGN KEY (intervention_id)
    REFERENCES intervention(intervention_id)
;