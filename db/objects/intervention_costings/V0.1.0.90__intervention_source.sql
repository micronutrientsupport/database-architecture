CREATE TABLE intervention_source(
    id    integer   NOT NULL GENERATED BY DEFAULT AS IDENTITY,
    intervention_source       text,
    CONSTRAINT "intervention_source_pk" PRIMARY KEY (data_source_id)
)
;

