CREATE OR REPLACE view food_genus_composition AS
/*
    view food_genus_composition returns composition data for each food genus
    (rather than by food item, which is how it is stored in the fooditem table).
    The micronutrient values are averaged because sometimes there are many
    fooditems within the same fct_source which have the same food genus.
    This is only a temporary problem as we are going to sort out the
    original data so no food genus is repeated for a fct_source. This view
    sorts that for now anyway.
*/
SELECT food_genus_id,fct_source_id,
	AVG(moisture_in_g)               AS moisture_in_g,
	AVG(energy_in_kcal)              AS energy_in_kcal,
	AVG(energy_in_kj)                AS energy_in_kj,
	AVG(nitrogen_in_g)               AS nitrogen_in_g,
    AVG(totalprotein_in_g)           AS totalprotein_in_g,
    AVG(totalfats_in_g)              AS totalfats_in_g,
    AVG(saturatedfa_in_g)            AS saturatedfa_in_g,
    AVG(monounsaturatedfa_in_g)      AS monounsaturatedfa_in_g,
    AVG(polyunsaturatedfa_in_g)      AS polyunsaturatedfa_in_g,
    AVG(cholesterol_in_mg)           AS cholesterol_in_mg,
    AVG(carbohydrates_in_g)          AS carbohydrates_in_g,
    AVG(fibre_in_g)                  AS fibre_in_g,
    AVG(ash_in_g)                    AS ash_in_g,
    AVG(ca_in_mg)                    AS ca_in_mg,
    AVG(fe_in_mg)                    AS fe_in_mg,
    AVG(mg_in_mg)                    AS mg_in_mg,
    AVG(p_in_mg)                     AS p_in_mg,
    AVG(k_in_mg)                     AS k_in_mg,
    AVG(na_in_mg)                    AS na_in_mg,
    AVG(zn_in_mg)                    AS zn_in_mg,
    AVG(cu_in_mg)                    AS cu_in_mg, 
    AVG(mn_in_mcg)                   AS mn_in_mcg, 
    AVG(i_in_mcg)                    AS i_in_mcg, 
    AVG(se_in_mcg)                   AS se_in_mcg, 
    AVG(vitamina_in_rae_in_mcg)      AS vitamina_in_rae_in_mcg, 
    AVG(thiamin_in_mg)               AS thiamin_in_mg, 
    AVG(riboflavin_in_mg)            AS riboflavin_in_mg, 
    AVG(niacin_in_mg)                AS niacin_in_mg, 
    AVG(vitaminb6_in_mg)             AS vitaminb6_in_mg, 
    AVG(folicacid_in_mcg)            AS folicacid_in_mcg, 
    AVG(folate_in_mcg)               AS folate_in_mcg, 
    AVG(vitaminb12_in_mcg)           AS vitaminb12_in_mcg, 
    AVG(pantothenate_in_mg)          AS pantothenate_in_mg, 
    AVG(biotin_in_mcg)               AS biotin_in_mcg, 
    AVG(vitaminc_in_mg)              AS vitaminc_in_mg, 
    AVG(vitamind_in_mcg)             AS vitamind_in_mcg, 
    AVG(vitamine_in_mg)              AS vitamine_in_mg, 
    AVG(Phytate_in_mg)            AS Phytate_in_mg
FROM fooditem
group by food_genus_id,fct_source_id
order by food_genus_id ;