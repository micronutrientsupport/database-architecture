CREATE
OR replace view household_intake_afe_deficiency_pivot AS
SELECT
    household_supply.*,
    afe_ear_threshold.afe_ear,
    (
        household_supply.micronutrient_supply < afe_ear_threshold.afe_ear
    ) AS is_deficient
FROM
    (
        SELECT
            hin.survey_id,
            hin.household_id,
            hin.fct_source_id,
            hin.subregion_id,
            subregion_name,
            mn.micronutrient_id,
            mn.micronutrient_supply
        FROM
            household_intake_afe_normalised hin
            CROSS JOIN LATERAL (
                VALUES
                    ('A', VitaminA_in_RAE_in_mcg),
                    ('B6', VitaminB6_in_mg),
                    ('B12', VitaminB12_in_mcg),
                    ('C', VitaminC_in_mg),
                    ('D', VitaminD_in_mcg),
                    ('E', VitaminE_in_mg),
                    ('B1', Thiamin_in_mg),
                    ('B2', Riboflavin_in_mg),
                    ('B3', Niacin_in_mg),
                    ('Folic Acid', Folicacid_in_mcg),
                    ('B9', Folate_in_mcg),
                    ('B5', Pantothenate_in_mg),
                    ('B7', Biotin_in_mcg),
                    ('IP6', PhyticAcid_in_mg),
                    ('Ca', Ca_in_mg),
                    ('Cu', Cu_in_mg),
                    ('Fe', Fe_in_mg),
                    ('Mg', Mg_in_mg),
                    ('Mn', Mn_in_mcg),
                    ('P', P_in_mg),
                    ('K', K_in_mg),
                    ('Na', Na_in_mg),
                    ('Zn', Zn_in_mg),
                    ('I', I_in_mcg),
                    ('N', Nitrogen_in_g),
                    ('Se', Se_in_mcg),
                    ('Ash', Ash_in_g),
                    ('Fibre', Fibre_in_g),
                    ('Carbohydrates', carbohydrates_in_g),
                    ('Cholesterol', Cholesterol_in_mg),
                    ('Protein', TotalProtein_in_g),
                    ('Fat', TotalFats_in_g),
                    ('Energy', Energy_in_kCal),
                    ('Moisture', Moisture_in_g)
            ) AS mn("micronutrient_id", "micronutrient_supply")
    ) AS household_supply
    JOIN afe_ear_threshold ON afe_ear_threshold.micronutrient_id = household_supply.micronutrient_id;

COMMENT ON VIEW household_intake_afe_deficiency_pivot IS 'View to extract the household intake, Estimated Average Requirement (EAR) and deficency status for a household pivoted by Micronutrient';
