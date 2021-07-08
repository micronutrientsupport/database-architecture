create or replace view household_intake_normalised as
select 
        hi.household_id
        , hi.survey_id
        , hi.fct_source_id
        , hi.subregion_id
        , hi.subregion_name
        , (hi.Moisture_in_g/hn.afe_factor              ) as  Moisture_in_g
        , (hi.Energy_in_kCal/hn.afe_factor             ) as  Energy_in_kCal
        , (hi.Energy_in_kJ/hn.afe_factor               ) as  Energy_in_kJ
        , (hi.Nitrogen_in_g/hn.afe_factor              ) as  Nitrogen_in_g
        , (hi.TotalProtein_in_g/hn.afe_factor          ) as  TotalProtein_in_g
        , (hi.TotalFats_in_g/hn.afe_factor             ) as  TotalFats_in_g
        , (hi.SaturatedFA_in_g/hn.afe_factor           ) as  SaturatedFA_in_g
        , (hi.MonounsaturatedFA_in_g/hn.afe_factor     ) as  MonounsaturatedFA_in_g
        , (hi.PolyunsaturatedFA_in_g/hn.afe_factor     ) as  PolyunsaturatedFA_in_g
        , (hi.Cholesterol_in_mg/hn.afe_factor          ) as  Cholesterol_in_mg
        , (hi.carbohydrates_in_g/hn.afe_factor         ) as  carbohydrates_in_g
        , (hi.Fibre_in_g/hn.afe_factor                 ) as  Fibre_in_g
        , (hi.Ash_in_g/hn.afe_factor                   ) as  Ash_in_g
        , (hi.Ca_in_mg/hn.afe_factor                   ) as  Ca_in_mg
        , (hi.Fe_in_mg/hn.afe_factor                   ) as  Fe_in_mg
        , (hi.Mg_in_mg/hn.afe_factor                   ) as  Mg_in_mg
        , (hi.P_in_mg/hn.afe_factor                    ) as  P_in_mg
        , (hi.K_in_mg/hn.afe_factor                    ) as  K_in_mg
        , (hi.Na_in_mg/hn.afe_factor                   ) as  Na_in_mg
        , (hi.Zn_in_mg/hn.afe_factor                   ) as  Zn_in_mg
        , (hi.Cu_in_mg/hn.afe_factor                   ) as  Cu_in_mg
        , (hi.Mn_in_mcg/hn.afe_factor                  ) as  Mn_in_mcg
        , (hi.I_in_mcg/hn.afe_factor                   ) as  I_in_mcg
        , (hi.Se_in_mcg/hn.afe_factor                  ) as  Se_in_mcg
        , (hi.VitaminA_in_RAE_in_mcg/hn.afe_factor     ) as  VitaminA_in_RAE_in_mcg
        , (hi.Thiamin_in_mg/hn.afe_factor              ) as  Thiamin_in_mg
        , (hi.Riboflavin_in_mg/hn.afe_factor           ) as  Riboflavin_in_mg
        , (hi.Niacin_in_mg/hn.afe_factor               ) as  Niacin_in_mg
        , (hi.VitaminB6_in_mg/hn.afe_factor            ) as  VitaminB6_in_mg
        , (hi.Folicacid_in_mcg/hn.afe_factor           ) as  Folicacid_in_mcg
        , (hi.Folate_in_mcg/hn.afe_factor              ) as  Folate_in_mcg
        , (hi.VitaminB12_in_mcg/hn.afe_factor          ) as  VitaminB12_in_mcg
        , (hi.Pantothenate_in_mg/hn.afe_factor         ) as  Pantothenate_in_mg
        , (hi.Biotin_in_mcg/hn.afe_factor              ) as  Biotin_in_mcg
        , (hi.VitaminC_in_mg/hn.afe_factor             ) as  VitaminC_in_mg
        , (hi.VitaminD_in_mcg/hn.afe_factor            ) as  VitaminD_in_mcg
        , (hi.VitaminE_in_mg/hn.afe_factor             ) as  VitaminE_in_mg
        , (hi.PhyticAcid_in_mg/hn.afe_factor           ) as  PhyticAcid_in_mg


from household_intake hi join household_normalisation hn on hi.household_id=hn.household_id;

COMMENT ON VIEW household_intake_normalised IS 'View of amount of micronutrients consumed in total by individual households normalised to AFE';
