CREATE TABLE fortification_type(
    id                   text  PRIMARY KEY  NOT NULL,
    name                 text
)
;

comment on table fortification_type IS 'whether the intervention is Large-Scale fortificaion, biofortification, or agro-fortification';
