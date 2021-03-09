CREATE OR REPLACE VIEW food_genus_nutrients_pivot AS

SELECT
    food_genus_id
    , fct_source_id
    , mn_name
    , mn_value
FROM food_genus_nutrients fi
CROSS JOIN LATERAL (
    VALUES
        ('A'           , VitaminA_in_RAE_in_mcg     ),
        ('B6'          , VitaminB6_in_mg            ),
        ('B12'         , VitaminB12_in_mcg          ),
        ('C'           , VitaminC_in_mg             ),
        ('D'           , VitaminD_in_mcg            ),
        ('E'           , VitaminE_in_mg             ),
        ('B1'          , Thiamin_in_mg              ),
        ('B2'          , Riboflavin_in_mg           ),
        ('B3'          , Niacin_in_mg               ),
        ('Folic Acid'  , Folicacid_in_mcg           ),
        ('B9'          , Folate_in_mcg              ),
        ('B5'          , Pantothenate_in_mg         ),
        ('B7'          , Biotin_in_mcg              ),
        ('IP6'         , PhyticAcid_in_mg           ),
        ('Ca'          , Ca_in_mg                   ),
        ('Cu'          , Cu_in_mg                   ),
        ('Fe'          , Fe_in_mg                   ),
        ('Mg'          , Mg_in_mg                   ),
        ('Mn'          , Mn_in_mcg                  ),
        ('P'           , P_in_mg                    ),
        ('K'           , K_in_mg                    ),
        ('Na'          , Na_in_mg                   ),
        ('Zn'          , Zn_in_mg                   ),
        ('I'           , I_in_mcg                   ),
        ('N'           , Nitrogen_in_g              ),
        ('Se'          , Se_in_mcg                  ),
        ('Ash'         , Ash_in_g                   ),
        ('Fibre'       , Fibre_in_g                 ),
        ('Carbohydrate', Carbohydrateavailable_in_g ),
        ('Cholesterol' , Cholesterol_in_mg          ),
        ('Protein'     , TotalProtein_in_g          ),
        ('Fat'         , TotalFats_in_g             ),
        ('Energy'      , Energy_in_kCal             ),
        ('Moisture'    , Moisture_in_g              )
) AS mn("mn_name", "mn_value")
