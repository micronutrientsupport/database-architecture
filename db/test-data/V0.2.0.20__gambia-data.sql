
INSERT INTO
    "fooditem" (
      data_source
      , Food_Code
      , Food_name
      , EnergyCalculated_in_kCal
      , EnergyCalculated_in_kJ
      , TotalProtein_in_g
      , TotalFats_in_g
      , Carbohydrateavailable_in_g
      , Totalfibre_in_g
      , PhyticAcid_in_mg
      , Moisture_in_g
      , Ca_in_mg
      , P_in_mg
      , Mg_in_mg
      , K_in_mg
      , Fe_in_mg
      , Zn_in_mg
      -- carotene
      , VitaminC_in_mg
    )
VALUES
  (
    2,
    4393,
    'Mani dempetengo',
    388,
    1414,
    7.2,
    1.2,
    79.5,
    7.8,
    .18*1000,
    10,
    6,
    238,
    66,
    223,
    3.7,
    1.2,
    -- carotene
    0
  );
