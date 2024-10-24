CREATE OR REPLACE VIEW household_intake_afe_normalised AS
SELECT 
        hi.household_id
        , hi.survey_id
        , hi.fct_source_id
        , hi.aggregation_area_id
        , hi.aggregation_area_name
        , hi.aggregation_area_type
        , (hi.Moisture_in_g/hn.afe_factor              ) AS  Moisture_in_g
        , (hi.Energy_in_kCal/hn.afe_factor             ) AS  Energy_in_kCal
        , (hi.Energy_in_kJ/hn.afe_factor               ) AS  Energy_in_kJ
        , (hi.Nitrogen_in_g/hn.afe_factor              ) AS  Nitrogen_in_g
        , (hi.TotalProtein_in_g/hn.afe_factor          ) AS  TotalProtein_in_g
        , (hi.TotalFats_in_g/hn.afe_factor             ) AS  TotalFats_in_g
        , (hi.SaturatedFA_in_g/hn.afe_factor           ) AS  SaturatedFA_in_g
        , (hi.MonounsaturatedFA_in_g/hn.afe_factor     ) AS  MonounsaturatedFA_in_g
        , (hi.PolyunsaturatedFA_in_g/hn.afe_factor     ) AS  PolyunsaturatedFA_in_g
        , (hi.Cholesterol_in_mg/hn.afe_factor          ) AS  Cholesterol_in_mg
        , (hi.carbohydrates_in_g/hn.afe_factor         ) AS  carbohydrates_in_g
        , (hi.Fibre_in_g/hn.afe_factor                 ) AS  Fibre_in_g
        , (hi.Ash_in_g/hn.afe_factor                   ) AS  Ash_in_g
        , (hi.Ca_in_mg/hn.afe_factor                   ) AS  Ca_in_mg
        , (hi.Fe_in_mg/hn.afe_factor                   ) AS  Fe_in_mg
        , (hi.Mg_in_mg/hn.afe_factor                   ) AS  Mg_in_mg
        , (hi.P_in_mg/hn.afe_factor                    ) AS  P_in_mg
        , (hi.K_in_mg/hn.afe_factor                    ) AS  K_in_mg
        , (hi.Na_in_mg/hn.afe_factor                   ) AS  Na_in_mg
        , (hi.Zn_in_mg/hn.afe_factor                   ) AS  Zn_in_mg
        , (hi.Cu_in_mg/hn.afe_factor                   ) AS  Cu_in_mg
        , (hi.Mn_in_mcg/hn.afe_factor                  ) AS  Mn_in_mcg
        , (hi.I_in_mcg/hn.afe_factor                   ) AS  I_in_mcg
        , (hi.Se_in_mcg/hn.afe_factor                  ) AS  Se_in_mcg
        , (hi.VitaminA_in_RAE_in_mcg/hn.afe_factor     ) AS  VitaminA_in_RAE_in_mcg
        , (hi.Thiamin_in_mg/hn.afe_factor              ) AS  Thiamin_in_mg
        , (hi.Riboflavin_in_mg/hn.afe_factor           ) AS  Riboflavin_in_mg
        , (hi.Niacin_in_mg/hn.afe_factor               ) AS  Niacin_in_mg
        , (hi.VitaminB6_in_mg/hn.afe_factor            ) AS  VitaminB6_in_mg
        , (hi.Folicacid_in_mcg/hn.afe_factor           ) AS  Folicacid_in_mcg
        , (hi.Folate_in_mcg/hn.afe_factor              ) AS  Folate_in_mcg
        , (hi.VitaminB12_in_mcg/hn.afe_factor          ) AS  VitaminB12_in_mcg
        , (hi.Pantothenate_in_mg/hn.afe_factor         ) AS  Pantothenate_in_mg
        , (hi.Biotin_in_mcg/hn.afe_factor              ) AS  Biotin_in_mcg
        , (hi.VitaminC_in_mg/hn.afe_factor             ) AS  VitaminC_in_mg
        , (hi.VitaminD_in_mcg/hn.afe_factor            ) AS  VitaminD_in_mcg
        , (hi.VitaminE_in_mg/hn.afe_factor             ) AS  VitaminE_in_mg
        , (hi.Phytate_in_mg/hn.afe_factor           ) AS  Phytate_in_mg


FROM household_intake hi JOIN household_normalisation hn ON hi.household_id=hn.household_id and hn.afe_factor > 0;

COMMENT ON VIEW household_intake_afe_normalised IS 'View of amount of micronutrients consumed in total by individual households normalised to Adult Female Equivalent (AFE)';
