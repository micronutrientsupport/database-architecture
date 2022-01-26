CREATE TABLE fortification_type(
    id                   text  PRIMARY KEY  NOT NULL,
    name                 text
)
;

COMMENT ON TABLE fortification_type IS 'whether the intervention is Large-Scale Food Fortificaion (LSFF), Biofortification (BF), or Bgro-Fortification (AF)';
COMMENT ON COLUMN fortification_type.id IS 'LSFF, BF, or AF';
COMMENT ON COLUMN fortification_type.name IS ' Large-Scale Food Fortificaion, Biofortification (BF), or Agro-Fortification';
