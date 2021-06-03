CREATE OR REPLACE VIEW household_intake AS

    SELECT
        household.id as household_id
        , household.survey_id
        , fooditem.fct_source_id as fct_source_id
        , subregion.id as subregion_id
        , subregion.name as subregion_name
        , sum(Moisture_in_g                  / 100 * amount_consumed_in_g) as Moisture_in_g
        , sum(Energy_in_kCal                 / 100 * amount_consumed_in_g) as Energy_in_kCal
        , sum(Energy_in_kJ                   / 100 * amount_consumed_in_g) as Energy_in_kJ
        , sum(Nitrogen_in_g                  / 100 * amount_consumed_in_g) as Nitrogen_in_g
        , sum(TotalProtein_in_g              / 100 * amount_consumed_in_g) as TotalProtein_in_g
        , sum(TotalFats_in_g                 / 100 * amount_consumed_in_g) as TotalFats_in_g
        , sum(SaturatedFA_in_g               / 100 * amount_consumed_in_g) as SaturatedFA_in_g
        , sum(MonounsaturatedFA_in_g         / 100 * amount_consumed_in_g) as MonounsaturatedFA_in_g
        , sum(PolyunsaturatedFA_in_g         / 100 * amount_consumed_in_g) as PolyunsaturatedFA_in_g
        , sum(Cholesterol_in_mg              / 100 * amount_consumed_in_g) as Cholesterol_in_mg
        , sum(Carbohydrateavailable_in_g     / 100 * amount_consumed_in_g) as Carbohydrateavailable_in_g
        , sum(Fibre_in_g                     / 100 * amount_consumed_in_g) as Fibre_in_g
        , sum(Ash_in_g                       / 100 * amount_consumed_in_g) as Ash_in_g
        , sum(Ca_in_mg                       / 100 * amount_consumed_in_g) as Ca_in_mg
        , sum(Fe_in_mg                       / 100 * amount_consumed_in_g) as Fe_in_mg
        , sum(Mg_in_mg                       / 100 * amount_consumed_in_g) as Mg_in_mg
        , sum(P_in_mg                        / 100 * amount_consumed_in_g) as P_in_mg
        , sum(K_in_mg                        / 100 * amount_consumed_in_g) as K_in_mg
        , sum(Na_in_mg                       / 100 * amount_consumed_in_g) as Na_in_mg
        , sum(Zn_in_mg                       / 100 * amount_consumed_in_g) as Zn_in_mg
        , sum(Cu_in_mg                       / 100 * amount_consumed_in_g) as Cu_in_mg
        , sum(Mn_in_mcg                      / 100 * amount_consumed_in_g) as Mn_in_mcg
        , sum(I_in_mcg                       / 100 * amount_consumed_in_g) as I_in_mcg
        , sum(Se_in_mcg                      / 100 * amount_consumed_in_g) as Se_in_mcg
        , sum(VitaminA_in_RAE_in_mcg         / 100 * amount_consumed_in_g) as VitaminA_in_RAE_in_mcg
        , sum(Thiamin_in_mg                  / 100 * amount_consumed_in_g) as Thiamin_in_mg
        , sum(Riboflavin_in_mg               / 100 * amount_consumed_in_g) as Riboflavin_in_mg
        , sum(Niacin_in_mg                   / 100 * amount_consumed_in_g) as Niacin_in_mg
        , sum(VitaminB6_in_mg                / 100 * amount_consumed_in_g) as VitaminB6_in_mg
        , sum(Folicacid_in_mcg               / 100 * amount_consumed_in_g) as Folicacid_in_mcg
        , sum(Folate_in_mcg                  / 100 * amount_consumed_in_g) as Folate_in_mcg
        , sum(VitaminB12_in_mcg              / 100 * amount_consumed_in_g) as VitaminB12_in_mcg
        , sum(Pantothenate_in_mg             / 100 * amount_consumed_in_g) as Pantothenate_in_mg
        , sum(Biotin_in_mcg                  / 100 * amount_consumed_in_g) as Biotin_in_mcg
        , sum(VitaminC_in_mg                 / 100 * amount_consumed_in_g) as VitaminC_in_mg
        , sum(VitaminD_in_mcg                / 100 * amount_consumed_in_g) as VitaminD_in_mcg
        , sum(VitaminE_in_mg                 / 100 * amount_consumed_in_g) as VitaminE_in_mg
        , sum(PhyticAcid_in_mg               / 100 * amount_consumed_in_g) as PhyticAcid_in_mg
    FROM
        fooditem
        JOIN food_genus ON food_genus.id = fooditem.food_genus_id
        JOIN HOUSEHOLD_CONSUMPTION as hhc ON hhc.food_genus_id = food_genus.id
        JOIN HOUSEHOLD_MEMBER as hhm ON hhm.id = hhc.HOUSEHOLD_id
        JOIN household ON hhm.household_id = household.id
        JOIN survey on household.survey_id = survey.id
        JOIN subregion on ST_Contains(subregion.geometry,  household.location)
    GROUP BY subregion.id, household.id, fooditem.fct_source_id
    --ORDER BY household.id
UNION ALL
    SELECT
        household.id as household_id
        , household.survey_id
        , individual_intake.fct_source_id as fct_source_id
        , subregion.id as subregion_id
        , subregion.name as subregion_name
        , sum(Moisture_in_g              ) as  Moisture_in_g
        , sum(Energy_in_kCal             ) as  Energy_in_kCal
        , sum(Energy_in_kJ               ) as  Energy_in_kJ
        , sum(Nitrogen_in_g              ) as  Nitrogen_in_g
        , sum(TotalProtein_in_g          ) as  TotalProtein_in_g
        , sum(TotalFats_in_g             ) as  TotalFats_in_g
        , sum(SaturatedFA_in_g           ) as  SaturatedFA_in_g
        , sum(MonounsaturatedFA_in_g     ) as  MonounsaturatedFA_in_g
        , sum(PolyunsaturatedFA_in_g     ) as  PolyunsaturatedFA_in_g
        , sum(Cholesterol_in_mg          ) as  Cholesterol_in_mg
        , sum(Carbohydrateavailable_in_g ) as  Carbohydrateavailable_in_g
        , sum(Fibre_in_g                 ) as  Fibre_in_g
        , sum(Ash_in_g                   ) as  Ash_in_g
        , sum(Ca_in_mg                   ) as  Ca_in_mg
        , sum(Fe_in_mg                   ) as  Fe_in_mg
        , sum(Mg_in_mg                   ) as  Mg_in_mg
        , sum(P_in_mg                    ) as  P_in_mg
        , sum(K_in_mg                    ) as  K_in_mg
        , sum(Na_in_mg                   ) as  Na_in_mg
        , sum(Zn_in_mg                   ) as  Zn_in_mg
        , sum(Cu_in_mg                   ) as  Cu_in_mg
        , sum(Mn_in_mcg                  ) as  Mn_in_mcg
        , sum(I_in_mcg                   ) as  I_in_mcg
        , sum(Se_in_mcg                  ) as  Se_in_mcg
        , sum(VitaminA_in_RAE_in_mcg     ) as  VitaminA_in_RAE_in_mcg
        , sum(Thiamin_in_mg              ) as  Thiamin_in_mg
        , sum(Riboflavin_in_mg           ) as  Riboflavin_in_mg
        , sum(Niacin_in_mg               ) as  Niacin_in_mg
        , sum(VitaminB6_in_mg            ) as  VitaminB6_in_mg
        , sum(Folicacid_in_mcg           ) as  Folicacid_in_mcg
        , sum(Folate_in_mcg              ) as  Folate_in_mcg
        , sum(VitaminB12_in_mcg          ) as  VitaminB12_in_mcg
        , sum(Pantothenate_in_mg         ) as  Pantothenate_in_mg
        , sum(Biotin_in_mcg              ) as  Biotin_in_mcg
        , sum(VitaminC_in_mg             ) as  VitaminC_in_mg
        , sum(VitaminD_in_mcg            ) as  VitaminD_in_mcg
        , sum(VitaminE_in_mg             ) as  VitaminE_in_mg
        , sum(PhyticAcid_in_mg           ) as  PhyticAcid_in_mg
    FROM individual_intake
    JOIN household on individual_intake.household_id = household.id
    JOIN survey on household.survey_id = survey.id
    JOIN subregion on ST_Contains(subregion.geometry,  household.location)
    GROUP BY subregion.id, household.id, individual_intake.fct_source_id
;

COMMENT ON VIEW household_intake IS 'View of amount of micronutrients consumed in total by individual households ';
