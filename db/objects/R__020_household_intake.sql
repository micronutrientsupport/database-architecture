CREATE OR REPLACE VIEW household_intake AS

WITH consumption_items AS (
    SELECT
         hc.food_genus_id
         , hc.id AS household_consumption_id
         , NULL AS household_member_consumption_id
         , h.id AS household_id
         , hc.original_food_name AS consumption_original_food_name
         , hc.amount_consumed_in_g
        FROM
            household_consumption hc
            join household h
            on hc.household_id = h.id
    union all
    select
           hmc.food_genus_id
         , NULL AS household_consumption_id
         , hmc.id AS household_member_consumption_id
         , hh.id AS household_id
         , hmc.original_food_name
         , hmc.amount_consumed_in_g
        FROM
        household_member_consumption hmc
        join household_member hhm
        on hhm.id = hmc.household_member_id
        join household hh
        on hhm.household_id = hh.id
)
SELECT
    household.survey_id
    , household.id AS household_id
--    , fct_used AS fct_source_id --TODO: we need to figure out how to carry forward the "FCT used" data to the other views and, ultmiately, the API
    , NULL AS fct_source_id --TODO: we need to figure out how to carry forward the "FCT used" data to the other views and, ultmiately, the API
    , aggregation_area.id as aggregation_area_id
    , aggregation_area.name as aggregation_area_name
    , aggregation_area.type as aggregation_area_type
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
    , sum(micronutrient_composition / 100 * amount_consumed_in_g) FILTER (WHERE micronutrient_id = 'IP6'           ) as PhyticAcid_in_mg
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
    , NULL as Energy_in_kJ           -- TODO: When these are added to the micronutrient table, update this view to forward the data
    , NULL as MonounsaturatedFA_in_g -- TODO: When these are added to the micronutrient table, update this view to forward the data
    , NULL as PolyunsaturatedFA_in_g -- TODO: When these are added to the micronutrient table, update this view to forward the data
    , NULL as SaturatedFA_in_g       -- TODO: When these are added to the micronutrient table, update this view to forward the data
FROM household
JOIN consumption_composition_match AS ccm ON ccm.household_id = household.id
LEFT JOIN consumption_items ci ON household.id = ci.household_id AND ci.food_genus_id = ccm.food_genus_id
JOIN aggregation_area on ST_Contains(aggregation_area.geometry,  household.location)
WHERE aggregation_area.type='admin' AND aggregation_area.admin_level=1
GROUP BY aggregation_area_id, survey_id, household.id
;

COMMENT ON VIEW household_intake IS 'View of amount of micronutrients consumed in total by individual households ';
