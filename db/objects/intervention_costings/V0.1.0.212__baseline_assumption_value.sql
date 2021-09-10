
CREATE TABLE baseline_assumption_value(
    baseline_assumption_id       integer    NOT NULL REFERENCES baseline_assumption(id),
    intervention_id              integer    NOT NULL REFERENCES intervention(id),
    year                         integer    NOT NULL REFERENCES year(year),
    value                        numeric,
    CONSTRAINT "baseline_assumption_value_pk" PRIMARY KEY (baseline_assumption_id, intervention_id)
)
;


