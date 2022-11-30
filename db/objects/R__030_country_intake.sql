CREATE OR REPLACE VIEW country_intake AS

SELECT
        c.id as country_id
        , fct_list_id
        , data_source_id
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'A'             ) as VitaminA_in_RAE_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B6'            ) as VitaminB6_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B12'           ) as VitaminB12_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'C'             ) as VitaminC_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'D'             ) as VitaminD_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'E'             ) as VitaminE_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B1'            ) as Thiamin_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B2'            ) as Riboflavin_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B3'            ) as Niacin_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Folic Acid'    ) as Folicacid_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B9'            ) as Folate_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B5'            ) as Pantothenate_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'B7'            ) as Biotin_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'IP6'           ) as Phytate_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Ca'            ) as Ca_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Cu'            ) as Cu_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Fe'            ) as Fe_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Mg'            ) as Mg_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Mn'            ) as Mn_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'P'             ) as P_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'K'             ) as K_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Na'            ) as Na_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Zn'            ) as Zn_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'I'             ) as I_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'N'             ) as Nitrogen_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Se'            ) as Se_in_mcg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Ash'           ) as Ash_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Fibre'         ) as Fibre_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Carbohydrates' ) as carbohydrates_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Cholesterol'   ) as Cholesterol_in_mg
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Protein'       ) as TotalProtein_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Fat'           ) as TotalFats_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Energy'        ) as Energy_in_kCal
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Moisture'      ) as Moisture_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'Energy_in_kJ'  ) as Energy_in_kJ
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'MUFA'          ) as MonounsaturatedFA_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'PUFA'          ) as PolyunsaturatedFA_in_g
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'SAFA'          ) as SaturatedFA_in_g
    FROM
        fct_list_food_composition as flfc
        JOIN COUNTRY_CONSUMPTION as cc ON cc.food_genus_id = flfc.food_genus_id
        JOIN country_consumption_source ccs on ccs.id = cc.data_source_id 
        JOIN country c ON ST_EQUALS(ccs.geometry, c.geometry)
        --JOIN survey on household.survey_id = survey.id
    GROUP BY data_source_id, flfc.fct_list_id, c.id;
    
COMMENT ON VIEW country_intake IS 'View of amount of micronutrients consumed per capita per year by country';
