create or replace function create_country_intake_composition_scenario(_fct_source_id numeric, _food_genus text[], _field text, _new_value numeric[])
returns setof country_intake as
$$
BEGIN
  return QUERY
  SELECT
        cc.country_id
        , fooditem.fct_source_id
        , data_source_id
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
        , sum(Carbohydrates_in_g             / 100 * amount_consumed_in_g) as Carbohydrates_in_g
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
        create_scenario_fct(_fct_source_id, _food_genus, _field, _new_value) as fooditem
        JOIN food_genus ON food_genus.id = fooditem.food_genus_id
        JOIN COUNTRY_CONSUMPTION as cc ON cc.food_genus_id = food_genus.id
        --JOIN survey on household.survey_id = survey.id
    GROUP BY data_source_id, fooditem.fct_source_id, cc.country_id;
END
$$
language plpgsql;

--select * from create_country_intake_composition_scenario(24, ARRAY['1341.01', '1594.01', '1312.01'], 'Mg'::text, ARRAY[5000, 75, 20]::numeric[]);
