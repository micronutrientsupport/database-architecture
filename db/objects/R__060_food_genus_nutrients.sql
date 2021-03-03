CREATE OR REPLACE VIEW food_genus_nutrients AS

SELECT
    food_genus_id
    , avg(moisture_in_g              )  as moisture_in_g
    , avg(energy_in_kcal             )  as energy_in_kcal
    , avg(energy_in_kj               )  as energy_in_kj
    , avg(nitrogen_in_g              )  as nitrogen_in_g
    , avg(totalprotein_in_g          )  as totalprotein_in_g
    , avg(totalfats_in_g             )  as totalfats_in_g
    , avg(saturatedfa_in_g           )  as saturatedfa_in_g
    , avg(monounsaturatedfa_in_g     )  as monounsaturatedfa_in_g
    , avg(polyunsaturatedfa_in_g     )  as polyunsaturatedfa_in_g
    , avg(cholesterol_in_mg          )  as cholesterol_in_mg
    , avg(carbohydrateavailable_in_g )  as carbohydrateavailable_in_g
    , avg(fibre_in_g                 )  as fibre_in_g
    , avg(ash_in_g                   )  as ash_in_g
    , avg(ca_in_mg                   )  as ca_in_mg
    , avg(fe_in_mg                   )  as fe_in_mg
    , avg(mg_in_mg                   )  as mg_in_mg
    , avg(p_in_mg                    )  as p_in_mg
    , avg(k_in_mg                    )  as k_in_mg
    , avg(na_in_mg                   )  as na_in_mg
    , avg(zn_in_mg                   )  as zn_in_mg
    , avg(cu_in_mg                   )  as cu_in_mg
    , avg(mn_in_mcg                  )  as mn_in_mcg
    , avg(i_in_mcg                   )  as i_in_mcg
    , avg(se_in_mcg                  )  as se_in_mcg
    , avg(vitamina_in_rae_in_mcg     )  as vitamina_in_rae_in_mcg
    , avg(thiamin_in_mg              )  as thiamin_in_mg
    , avg(riboflavin_in_mg           )  as riboflavin_in_mg
    , avg(niacin_in_mg               )  as niacin_in_mg
    , avg(vitaminb6_in_mg            )  as vitaminb6_in_mg
    , avg(folicacid_in_mcg           )  as folicacid_in_mcg
    , avg(folate_in_mcg              )  as folate_in_mcg
    , avg(vitaminb12_in_mcg          )  as vitaminb12_in_mcg
    , avg(pantothenate_in_mg         )  as pantothenate_in_mg
    , avg(biotin_in_mcg              )  as biotin_in_mcg
    , avg(vitaminc_in_mg             )  as vitaminc_in_mg
    , avg(vitamind_in_mcg            )  as vitamind_in_mcg
    , avg(vitamine_in_mg             )  as vitamine_in_mg
    , avg(phyticacid_in_mg           )  as phyticacid_in_mg

    -- , avg(Starch_in_g               )
from
    fooditem
    JOIN food_genus ON fooditem.food_genus_id = food_genus.id
    GROUP BY food_genus_id
