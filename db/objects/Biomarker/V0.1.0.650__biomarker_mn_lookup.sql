CREATE TABLE biomarker_micronutrient_mapping (
	biomarker_name               text primary key
    , micronutrient_id           text REFERENCES micronutrient (id)
);

COMMENT ON TABLE biomarker_micronutrient_mapping IS 'Mapping between biomarker measurement fields and micronutrient IDs';
COMMENT ON COLUMN biomarker_micronutrient_mapping.biomarker_name IS 'Name of the biomarker';
COMMENT ON COLUMN biomarker_micronutrient_mapping.micronutrient_id IS 'ID of the corresponding micronutrient from the micronutrients table';

INSERT INTO biomarker_micronutrient_mapping (biomarker_name, micronutrient_id)
VALUES
 ('haemoglobin'), 'Fe')
,('ferritin', 'Fe' )
,('stfr', 'Fe' )
,('rbp', null )
,('retinol'), null )
,('rbc_folate', 'B9' )
,('ps_folate', 'B9' )
,('vitamin_b12', 'B12' )
,('zinc', 'Zn' )
,('crp', null )
,('agp', null )
,('iodine', 'I' );