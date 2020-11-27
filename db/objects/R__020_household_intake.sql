CREATE OR REPLACE VIEW household_intake AS

SELECT
    household.id
    , sum(Moisture_in_g                  / 100 * amount_consumed_in_g) as Moisture_in_g
    , sum(EnergyCalculated_in_kCal       / 100 * amount_consumed_in_g) as EnergyCalculated_in_kCal
    , sum(EnergyCalculated_in_kJ         / 100 * amount_consumed_in_g) as EnergyCalculated_in_kJ
    , sum(Nitrogen_in_g                  / 100 * amount_consumed_in_g) as Nitrogen_in_g
    , sum(TotalProtein_in_g              / 100 * amount_consumed_in_g) as TotalProtein_in_g
    , sum(TotalFats_in_g                 / 100 * amount_consumed_in_g) as TotalFats_in_g
    , sum(SaturatedFA_in_g               / 100 * amount_consumed_in_g) as SaturatedFA_in_g
    , sum(MonounsaturatedFA_in_g         / 100 * amount_consumed_in_g) as MonounsaturatedFA_in_g
    , sum(PolyunsaturatedFA_in_g         / 100 * amount_consumed_in_g) as PolyunsaturatedFA_in_g
    , sum(Cholesterol_in_mg              / 100 * amount_consumed_in_g) as Cholesterol_in_mg
    , sum(TotalCHOforUDB                 / 100 * amount_consumed_in_g) as TotalCHOforUDB
    , sum(Carbohydrateavailable_in_g     / 100 * amount_consumed_in_g) as Carbohydrateavailable_in_g
    , sum(Totalsugars_in_g               / 100 * amount_consumed_in_g) as Totalsugars_in_g
    , sum(Addedsugar_in_g                / 100 * amount_consumed_in_g) as Addedsugar_in_g
    , sum(Totalfibre_in_g                / 100 * amount_consumed_in_g) as Totalfibre_in_g
    , sum(Starch_in_g                    / 100 * amount_consumed_in_g) as Starch_in_g
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
    , sum(VitaminA_in_RE_in_mcg          / 100 * amount_consumed_in_g) as VitaminA_in_RE_in_mcg
    , sum(Thiamin_in_mg                  / 100 * amount_consumed_in_g) as Thiamin_in_mg
    , sum(Riboflavin_in_mg               / 100 * amount_consumed_in_g) as Riboflavin_in_mg
    , sum(Niacin_in_mg                   / 100 * amount_consumed_in_g) as Niacin_in_mg
    , sum(VitaminB6_in_mg                / 100 * amount_consumed_in_g) as VitaminB6_in_mg
    , sum(Folicacid_in_mcg               / 100 * amount_consumed_in_g) as Folicacid_in_mcg
    , sum(VitaminB12_in_mcg              / 100 * amount_consumed_in_g) as VitaminB12_in_mcg
    , sum(Pantothenate_in_mg             / 100 * amount_consumed_in_g) as Pantothenate_in_mg
    , sum(Biotin_in_mcg                  / 100 * amount_consumed_in_g) as Biotin_in_mcg
    , sum(VitaminC_in_mg                 / 100 * amount_consumed_in_g) as VitaminC_in_mg
    , sum(VitaminD_in_mcg                / 100 * amount_consumed_in_g) as VitaminD_in_mcg
    , sum(VitaminE_in_mg                 / 100 * amount_consumed_in_g) as VitaminE_in_mg
    , sum(PhyticAcid_in_mg               / 100 * amount_consumed_in_g) as PhyticAcid_in_mg
FROM
    fooditem as food
    JOIN HOUSEHOLD_CONSUMPTION as hhc ON hhc.fooditem_id = food.id
    JOIN HOUSEHOLD_MEMBER as household ON household.id = hhc.HOUSEHOLD_id
GROUP BY household.id
--ORDER BY household.id
UNION ALL
SELECT
    household_id
    , sum(Moisture_in_g              ) as  Moisture_in_g
    , sum(EnergyCalculated_in_kCal   ) as  EnergyCalculated_in_kCal
    , sum(EnergyCalculated_in_kJ     ) as  EnergyCalculated_in_kJ
    , sum(Nitrogen_in_g              ) as  Nitrogen_in_g
    , sum(TotalProtein_in_g          ) as  TotalProtein_in_g
    , sum(TotalFats_in_g             ) as  TotalFats_in_g
    , sum(SaturatedFA_in_g           ) as  SaturatedFA_in_g
    , sum(MonounsaturatedFA_in_g     ) as  MonounsaturatedFA_in_g
    , sum(PolyunsaturatedFA_in_g     ) as  PolyunsaturatedFA_in_g
    , sum(Cholesterol_in_mg          ) as  Cholesterol_in_mg
    , sum(TotalCHOforUDB             ) as  TotalCHOforUDB
    , sum(Carbohydrateavailable_in_g ) as  Carbohydrateavailable_in_g
    , sum(Totalsugars_in_g           ) as  Totalsugars_in_g
    , sum(Addedsugar_in_g            ) as  Addedsugar_in_g
    , sum(Totalfibre_in_g            ) as  Totalfibre_in_g
    , sum(Starch_in_g                ) as  Starch_in_g
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
    , sum(VitaminA_in_RE_in_mcg      ) as  VitaminA_in_RE_in_mcg
    , sum(Thiamin_in_mg              ) as  Thiamin_in_mg
    , sum(Riboflavin_in_mg           ) as  Riboflavin_in_mg
    , sum(Niacin_in_mg               ) as  Niacin_in_mg
    , sum(VitaminB6_in_mg            ) as  VitaminB6_in_mg
    , sum(Folicacid_in_mcg           ) as  Folicacid_in_mcg
    , sum(VitaminB12_in_mcg          ) as  VitaminB12_in_mcg
    , sum(Pantothenate_in_mg         ) as  Pantothenate_in_mg
    , sum(Biotin_in_mcg              ) as  Biotin_in_mcg
    , sum(VitaminC_in_mg             ) as  VitaminC_in_mg
    , sum(VitaminD_in_mcg            ) as  VitaminD_in_mcg
    , sum(VitaminE_in_mg             ) as  VitaminE_in_mg
    , sum(PhyticAcid_in_mg           ) as  PhyticAcid_in_mg
FROM individual_intake
GROUP BY household_id
;

COMMENT ON VIEW household_intake IS 'View of amount of micronutrients consumed in total by individual households ';
