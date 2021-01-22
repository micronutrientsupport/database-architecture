INSERT INTO
    micronutrients (id, name, category, unit, description, fooditem_column, in_impact, impact_column )
VALUES
    ('A', 'Vitamin A', 'vitamin', 'mcg', 'Description for Vitamin A', 'VitaminA_in_RAE_in_mcg', 1, 'vit_a')
    ('B6', 'Vitamin B6', 'vitamin', 'mg', 'Description for Vitamin B6', 'VitaminB6_in_mg', 1, 'vit_b6'),
    ('B12', 'Vitamin B12', 'vitamin', 'mcg', 'Description for Vitamin B12', 'VitaminB12_in_mcg', 0),
    ('C', 'Vitamin C', 'vitamin', 'mg', 'Description for Vitamin C', 'VitaminC_in_mg', 1, 'vit_c'),
    ('D', 'Vitamin D', 'vitamin', 'mcg', 'Description for Vitamin D', 'VitaminD_in_mcg', 0),
    ('E', 'Vitamin E', 'vitamin', 'mg', 'Description for Vitamin E', 'VitaminE_in_mg', 0),
    ('B1', 'Thiamin', 'vitamin', 'mg', 'Description for Vitamin B1', 'Thiamin_in_mg', 1, 'thiamin'),
    ('B2', 'Riboflavin', 'vitamin', 'mg', 'Description for Vitamin B2', 'Riboflavin_in_mg', 1, 'riboflavin'),
    ('B3', 'Niacin', 'vitamin', 'mg', 'Description for Vitamin B3', 'Niacin_in_mg', 1, 'niacin'),
    ('B9', 'Folate', 'vitamin', 'mcg', 'Description for Vitamin B9', 'XXXX', 1, 'folate'),
    ('B5', 'Pantothenate', 'vitamin', 'mg', 'Description for Vitamin B5', 'Pantothenate_in_mg', 0),
    ('B7', 'Biotin', 'vitamin', 'mg', 'Description for Vitamin B7', 'Biotin_in_mcg', 0),
    ('IP6', 'Phytic Acid', 'vitamin', 'mg', 'Description for Phytic Acid', 'PhyticAcid_in_mg', 0),

    ('Ca', 'Calcium', 'mineral', 'mg', 'Description for Calcium', 'Ca_in_mg', 1, 'calcium'),
    ('Cu', 'Copper', 'mineral', 'mg', 'Description for Copper', 'Cu_in_mg', 0),
    ('Fe', 'Iron', 'mineral', 'mg', 'Description for Iron', 'Fe_in_mg', 1, 'iron'),
    ('Mg', 'Magnesium', 'mineral', 'mg', 'Description for Magnesium', 'Mg_in_mg', 1, 'magnesium'),
    ('Mn', 'Manganese', 'mineral', 'mcg', 'Description for Manganese', 'Mn_in_mcg', 0),
    ('P', 'Phosphorus', 'mineral', 'mg', 'Description for Phosphorus', 'P_in_mg', 1, 'phosphorus'),
    ('K', 'Potassium', 'mineral', 'mg', 'Description for Potassium', 'K_in_mg', 1, 'potassium'),
    ('Na', 'Sodium', 'mineral', '   mg', 'Description for Sodium', 'Na_in_mg', 0),
    ('Zn', 'Zinc', 'mineral', 'mg', 'Description for Zinc', 'Zn_in_mg', 1, 'zinc'),
    ('I', 'Iodine', 'mineral', 'mg', 'Description for Iodine', 'I_in_mg', 0),
    ('Se', 'Selenium', 'mineral', 'mg', 'Description for Selenium', 'Se_in_mg', 0),
    ('N', 'Nitrogen', 'mineral', 'g', 'Description for Nitrogen', 'Nitrogen_in_g ', 0),

    ('Starch', 'Starch', 'other', 'g', 'Description for Starch', 'Starch_in_g', 0),
    ('Ash', 'Ash', 'other', 'g', 'Description for Ash', 'Ash_in_g', 0),
    ('Fibre', 'Fibre', 'other', 'g', 'Description for Fibre', 'XXXX', 0),
    ('Carbohydrate', 'Carbhohydrate', 'other', 'g', 'Description for Carbohydrate', 'Carbohydrateavailable_in_g', 0),
    ('Cholesterol', 'Cholestorol', 'other', 'mg', 'Description for Cholestorol', 'Cholesterol_in_mg', 0),
    ('Protein', 'Total Protein', 'other', 'g', 'Description for Protetin', 'TotalProtein_in_g', 1, 'protein'),
    ('Fat', 'Total Fats', 'other', 'g', 'Description for Fats', 'TotalFats_in_g', 0),
    ('Energy', 'Energy', 'other', 'kCal', 'Description for Energy', 'XXXX', 0),
    ('Moisture', 'Moisture', 'other', 'g', 'Descriptiom for Moisture', 'Moisture_in_g', 0)