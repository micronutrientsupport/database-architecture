INSERT INTO
biomarker (
    id, name, unit, sampled_matter
)
VALUES
    ( 'haemoglobin'   , 'Hemoglobin'                           , 'g/L'    , 'blood' ),
    ( 'ferritin'      , 'Ferritin'                             , 'µg/L'   , 'blood' ),
    ( 'stfr'          , 'Soluble Transferrin Receptors (sTfR)' , 'mg/L'   , 'blood' ),
    ( 'rbp'           , 'Retinol Binding Protein (RBP)'        , 'µmol/L' , 'blood' ),
    ( 'serum_retinol' , 'Serum Retinol'                        , 'µmol/L' , 'blood' ),
    ( 'rbc_folate'    , 'RBC Folate'                           , 'nmol/L' , 'blood' ),
    ( 'serum_folate'  , 'Serum Folate'                         , 'nmol/L' , 'blood' ),
    ( 'vitamin_b12'   , 'Vitamin B12'                          , 'pmol/L' , 'blood' ),
    ( 'zinc'          , 'Zinc'                                 , 'µg/dL'  , 'blood' ),
    ( 'crp'           , 'C-reactive Protein (CRP)'             , 'mg/L'   , 'blood' ),
    ( 'agp'           , 'Alpha 1 acid GlycoProtein (AGP)'      , 'g/L'    , 'blood' ),
    ( 'iodine'        , 'Iodine'                               , 'µg/L'   , 'urine' ),
	( 'selenium'      , 'Selenium'                             , 'ng/mL'  , 'blood' )



