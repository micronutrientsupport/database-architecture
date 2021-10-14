--
-- TABLE: intervention_type
--

CREATE TABLE intervention_type(
    id                   text  PRIMARY KEY  NOT NULL,
    name                 text
)
;

comment on table intervention_type IS 'whether the intervention is industrial fortificaion, biofortification, or agro-fortification';
