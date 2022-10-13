INSERT INTO
    micronutrient (id, name, category, unit, description, fooditem_column, is_in_impact, impact_column, is_diet, is_biomarker, is_user_visible, methods_text )
VALUES
    ('A'                                      , 'Vitamin A (REA)'             , 'vitamin' , 'mcg'   , 'Description for Vitamin A'                   , 'VitaminA_in_RAE_in_mcg'     , '1' , 'vit_a'       , '1' , '0', '1', 'Thresholds used are those proposed by IOM (Institute of Medicine. Dietary Reference Intakes for vitamin A, vitamin K, arsenic, boron, chromium, copper, iodine, iron, manganese, molybdenum, nickel, silicon, vanadium, and zinc. Washington (DC): National Academies Press; 2000)') ,
    ('B6'                                     , 'Vitamin B6'                  , 'vitamin' , 'mg'    , 'Description for Vitamin B6'                  , 'VitaminB6_in_mg'            , '1' , 'vit_b6'      , '1' , '0', '1', '') ,
    ('B12'                                    , 'Vitamin B12'                 , 'vitamin' , 'mcg'   , 'Description for Vitamin B12'                 , 'VitaminB12_in_mcg'          , '0' , NULL          , '1' , '0', '1', '') ,
    ('C'                                      , 'Vitamin C'                   , 'vitamin' , 'mg'    , 'Description for Vitamin C'                   , 'VitaminC_in_mg'             , '1' , 'vit_c'       , '1' , '0', '1', '') ,
    ('D'                                      , 'Vitamin D'                   , 'vitamin' , 'mcg'   , 'Description for Vitamin D'                   , 'VitaminD_in_mcg'            , '0' , NULL          , '1' , '0', '1', '') ,
    ('E'                                      , 'Vitamin E'                   , 'vitamin' , 'mg'    , 'Description for Vitamin E'                   , 'VitaminE_in_mg'             , '0' , NULL          , '1' , '0', '1', '') ,
    ('B1'                                     , 'Thiamin'                     , 'vitamin' , 'mg'    , 'Description for Vitamin B1'                  , 'Thiamin_in_mg'              , '1' , 'thiamin'     , '1' , '0', '1', '') ,
    ('B2'                                     , 'Riboflavin'                  , 'vitamin' , 'mg'    , 'Description for Vitamin B2'                  , 'Riboflavin_in_mg'           , '1' , 'riboflavin'  , '1' , '0', '1', '') ,
    ('B3'                                     , 'Niacin'                      , 'vitamin' , 'mg'    , 'Description for Vitamin B3'                  , 'Niacin_in_mg'               , '1' , 'niacin'      , '1' , '0', '1', '') ,
    ('Folic Acid'                             , 'Folic Acid'                  , 'vitamin' , 'mcg'   , 'Description for Vitamin B9 - Folic Acid'     , 'Folicacid_in_mcg'           , '0' , NULL          , '1' , '0', '0', '') ,
    ('B9'                                     , 'Folate'                      , 'vitamin' , 'mcg'   , 'Description for Vitamin B9 - Folate'         , 'Folate_in_mcg'              , '1' , 'folate'      , '1' , '1', '1', '') ,
    ('B5'                                     , 'Pantothenate'                , 'vitamin' , 'mg'    , 'Description for Vitamin B5'                  , 'Pantothenate_in_mg'         , '0' , NULL          , '1' , '0', '1', '') ,
    ('B7'                                     , 'Biotin'                      , 'vitamin' , 'mg'    , 'Description for Vitamin B7'                  , 'Biotin_in_mcg'              , '0' , NULL          , '1' , '0', '1', '') ,
    ('IP6'                                    , 'Phytate'                     , 'vitamin' , 'mg'    , 'Description for Phytic Acid'                 , 'Phytate_in_mg'           , '0' , NULL          , '1' , '0', '1', '') ,
    ('Ca'                                     , 'Calcium'                     , 'mineral' , 'mg'    , 'Description for Calcium'                     , 'Ca_in_mg'                   , '1' , 'calcium'     , '1' , '0', '1', '') ,
    ('Cu'                                     , 'Copper'                      , 'mineral' , 'mg'    , 'Description for Copper'                      , 'Cu_in_mg'                   , '0' , NULL          , '1' , '0', '1', '') ,
    ('Fe'                                     , 'Iron'                        , 'mineral' , 'mg'    , 'Description for Iron'                        , 'Fe_in_mg'                   , '1' , 'iron'        , '1' , '0', '1', 'Bioavailability of iron from dietary sources was assumed to be 10%. Adequacy of iron was assessed using the full probability method.') ,
    ('Mg'                                     , 'Magnesium'                   , 'mineral' , 'mg'    , 'Description for Magnesium'                   , 'Mg_in_mg'                   , '1' , 'magnesium'   , '1' , '0', '1', '') ,
    ('Mn'                                     , 'Manganese'                   , 'mineral' , 'mcg'   , 'Description for Manganese'                   , 'Mn_in_mcg'                  , '0' , NULL          , '1' , '0', '1', '') ,
    ('P'                                      , 'Phosphorus'                  , 'mineral' , 'mg'    , 'Description for Phosphorus'                  , 'P_in_mg'                    , '1' , 'phosphorus'  , '1' , '0', '1', '') ,
    ('K'                                      , 'Potassium'                   , 'mineral' , 'mg'    , 'Description for Potassium'                   , 'K_in_mg'                    , '1' , 'potassium'   , '1' , '0', '1', '') ,
    ('Na'                                     , 'Sodium'                      , 'mineral' , 'mg'    , 'Description for Sodium'                      , 'Na_in_mg'                   , '0' , NULL          , '1' , '0', '1', '') ,
    ('Zn'                                     , 'Zinc'                        , 'mineral' , 'mg'    , 'Description for Zinc'                        , 'Zn_in_mg'                   , '1' , 'zinc'        , '1' , '1', '1', '') ,
    ('I'                                      , 'Iodine'                      , 'mineral' , 'mcg'   , 'Description for Iodine'                      , 'I_in_mcg'                   , '0' , NULL          , '1' , '1', '1', '') ,
    ('N'                                      , 'Nitrogen'                    , 'mineral' , 'g'     , 'Description for Nitrogen'                    , 'Nitrogen_in_g'              , '0' , NULL          , '1' , '0', '1', '') ,
    ('Se'                                     , 'Selenium'                    , 'mineral' , 'mcg'   , 'Description for Selenium'                    , 'Se_in_mcg'                  , '0' , NULL          , '1' , '0', '1', '') ,
    ('Ash'                                    , 'Ash'                         , 'other'   , 'g'     , 'Description for Ash'                         , 'Ash_in_g'                   , '0' , NULL          , '1' , '0', '1', '') ,
    ('Fibre'                                  , 'Fibre'                       , 'other'   , 'g'     , 'Description for Fibre'                       , 'Fibre_in_g'                 , '0' , NULL          , '1' , '0', '1', '') ,
    ('Carbohydrates'                          , 'Carbhohydrate'               , 'other'   , 'g'     , 'Description for Carbohydrate'                , 'carbohydrates_in_g'         , '0' , NULL          , '1' , '0', '1', '') ,
    ('Cholesterol'                            , 'Cholestorol'                 , 'other'   , 'mg'    , 'Description for Cholestorol'                 , 'Cholesterol_in_mg'          , '0' , NULL          , '1' , '0', '1', '') ,
    ('Protein'                                , 'Total Protein'               , 'other'   , 'g'     , 'Description for Protetin'                    , 'TotalProtein_in_g'          , '1' , 'protein'     , '1' , '0', '1', '') ,
    ('Fat'                                    , 'Total Fats'                  , 'other'   , 'g'     , 'Description for Fats'                        , 'TotalFats_in_g'             , '0' , NULL          , '1' , '0', '1', '') ,
    ('Energy'                                 , 'Energy'                      , 'other'   , 'kCal'  , 'Description for Energy'                      , 'Energy_in_kCal'             , '0' , NULL          , '1' , '0', '1', '') ,
    ('Moisture'                               , 'Moisture'                    , 'other'   , 'g'     , 'Descriptiom for Moisture'                    , 'Moisture_in_g'              , '0' , NULL          , '1' , '0', '1', '') ,
    ('Energy_in_kJ'                           , 'Energy in kJ'                , 'other'   , 'kJ'    , ''                                            , 'Energy_in_kJ'               , '0' , NULL          , '1' , '0', '0', '') ,
    ('MUFA'                                   , 'Monounsaturated Fatty Acids' , 'other'   , 'g'     , ''                                            , 'MonounsaturatedFA_in_g'     , '0' , NULL          , '1' , '0', '0', '') ,
    ('PUFA'                                   , 'Polyunsaturated Fatty Acids' , 'other'   , 'g'     , ''                                            , 'PolyunsaturatedFA_in_g'     , '0' , NULL          , '1' , '0', '0', '') ,
    ('SAFA'                                   , 'Saturated Fatty Acids'       , 'other'   , 'g'     , ''                                            , 'SaturatedFA_in_g'           , '0' , NULL          , '1' , '0', '0', '')
