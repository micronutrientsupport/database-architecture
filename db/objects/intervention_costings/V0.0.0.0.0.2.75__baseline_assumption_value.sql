--
-- TABLE: baseline_assumption_value
--

CREATE TABLE baseline_assumption_value(
    assumption_id      integer    NOT NULL,
    intervention_id    integer    NOT NULL,
    year               integer    NOT NULL,
    value              numeric,
    CONSTRAINT "baseline_assumption_value_pk" PRIMARY KEY (assumption_id, intervention_id)
)
;


--
-- TABLE: baseline_assumption_value
--

ALTER TABLE baseline_assumption_value ADD CONSTRAINT "Refbaseline_assumption91"
    FOREIGN KEY (assumption_id)
    REFERENCES baseline_assumption(assumption_id)
;

ALTER TABLE baseline_assumption_value ADD CONSTRAINT "Refintervention101"
    FOREIGN KEY (intervention_id)
    REFERENCES intervention(intervention_id)
;

ALTER TABLE baseline_assumption_value ADD CONSTRAINT "Refyear141"
    FOREIGN KEY (year)
    REFERENCES year(year)
;
