CREATE FUNCTION get_fct_data(geometry(Point, 4326),text)
RETURNS TABLE(
	moisture_in_g numeric(),
	energy_in_kcal numeric(),
	energy_in_kj numeric(),
	nitrogen_in_g numeric(),
	totalprotein_in_g numeric(),
	totalfats_in_g numeric(),
	saturatedfa_in_g numeric(),
	monounsaturatedfa_in_g numeric(),
	polyunsaturatedfa_in_g numeric(),
	cholesterol_in_mg numeric(),
	carbohydrates_in_g numeric(),
	fibre_in_g numeric(),
	ash_in_g numeric(),
	ca_in_mg numeric(),
	fe_in_mg numeric(),
	mg_in_mg numeric(),
	p_in_mg numeric(),
	k_in_mg numeric(),
	na_in_mg numeric(),
	zn_in_mg numeric(),
	cu_in_mg numeric(),
	mn_in_mcg numeric(),
	i_in_mcg numeric(),
	se_in_mcg numeric(),
	vitamina_in_rae_in_mcg numeric(),
	thiamin_in_mg numeric(),
	riboflavin_in_mg numeric(),
	niacin_in_mg numeric(),
	vitaminb6_in_mg numeric(),
	folicacid_in_mcg numeric(),
	folate_in_mcg numeric(),
	vitaminb12_in_mcg numeric(),
	pantothenate_in_mg numeric(),
	biotin_in_mcg numeric(),
	vitaminc_in_mg numeric(),
	vitamind_in_mcg numeric(),
	vitamine_in_mg numeric(),
	phyticacid_in_mg numeric()
)
    AS $$

		WITH a AS (
		select a.*
		from food_genus_composition a,
		(select get_fct_list($1) as id) b
		where a.fct_source_id = b.id
		and a.food_genus_id = $2)
	select * from
           (select a.moisture_in_g from a where a.moisture_in_g is not null LIMIT 1) moisture_in_g 
 FULL JOIN (select a.energy_in_kcal from a where a.energy_in_kcal is not null LIMIT 1) energy_in_kcal ON TRUE
 FULL JOIN (select a.energy_in_kj from a where a.energy_in_kj is not null LIMIT 1) energy_in_kj ON TRUE
 FULL JOIN (select a.nitrogen_in_g from a where a.nitrogen_in_g is not null LIMIT 1) nitrogen_in_g ON TRUE
 FULL JOIN (select a.totalprotein_in_g from a where a.totalprotein_in_g is not null LIMIT 1) totalprotein_in_g ON TRUE
 FULL JOIN (select a.totalfats_in_g from a where a.totalfats_in_g is not null LIMIT 1) totalfats_in_g ON TRUE
 FULL JOIN (select a.saturatedfa_in_g from a where a.saturatedfa_in_g is not null LIMIT 1) saturatedfa_in_g ON TRUE
 FULL JOIN (select a.monounsaturatedfa_in_g from a where a.monounsaturatedfa_in_g is not null LIMIT 1) monounsaturatedfa_in_g ON TRUE
 FULL JOIN (select a.polyunsaturatedfa_in_g from a where a.polyunsaturatedfa_in_g is not null LIMIT 1) polyunsaturatedfa_in_g ON TRUE
 FULL JOIN (select a.cholesterol_in_mg from a where a.cholesterol_in_mg is not null LIMIT 1) cholesterol_in_mg ON TRUE
 FULL JOIN (select a.carbohydrates_in_g from a where a.carbohydrates_in_g is not null LIMIT 1) carbohydrates_in_g ON TRUE
 FULL JOIN (select a.fibre_in_g from a where a.fibre_in_g is not null LIMIT 1) fibre_in_g ON TRUE
 FULL JOIN (select a.ash_in_g from a where a.ash_in_g is not null LIMIT 1) ash_in_g ON TRUE
 FULL JOIN (select a.ca_in_mg from a where a.ca_in_mg is not null LIMIT 1) ca_in_mg ON TRUE
 FULL JOIN (select a.fe_in_mg from a where a.fe_in_mg is not null LIMIT 1) fe_in_mg ON TRUE
 FULL JOIN (select a.mg_in_mg from a where a.mg_in_mg is not null LIMIT 1) mg_in_mg ON TRUE
 FULL JOIN (select a.p_in_mg from a where a.p_in_mg is not null LIMIT 1) p_in_mg ON TRUE
 FULL JOIN (select a.k_in_mg from a where a.k_in_mg is not null LIMIT 1) k_in_mg ON TRUE
 FULL JOIN (select a.na_in_mg from a where a.na_in_mg is not null LIMIT 1) na_in_mg ON TRUE
 FULL JOIN (select a.zn_in_mg from a where a.zn_in_mg is not null LIMIT 1) zn_in_mg ON TRUE
 FULL JOIN (select a.cu_in_mg from a where a.cu_in_mg is not null LIMIT 1) cu_in_mg ON TRUE
 FULL JOIN (select a.mn_in_mcg from a where a.mn_in_mcg is not null LIMIT 1) mn_in_mcg ON TRUE
 FULL JOIN (select a.i_in_mcg from a where a.i_in_mcg is not null LIMIT 1) i_in_mcg ON TRUE
 FULL JOIN (select a.se_in_mcg from a where a.se_in_mcg is not null LIMIT 1) se_in_mcg ON TRUE
 FULL JOIN (select a.vitamina_in_rae_in_mcg from a where a.vitamina_in_rae_in_mcg is not null LIMIT 1) vitamina_in_rae_in_mcg ON TRUE
 FULL JOIN (select a.thiamin_in_mg from a where a.thiamin_in_mg is not null LIMIT 1) thiamin_in_mg ON TRUE
 FULL JOIN (select a.riboflavin_in_mg from a where a.riboflavin_in_mg is not null LIMIT 1) riboflavin_in_mg ON TRUE
 FULL JOIN (select a.niacin_in_mg from a where a.niacin_in_mg is not null LIMIT 1) niacin_in_mg ON TRUE
 FULL JOIN (select a.vitaminb6_in_mg from a where a.vitaminb6_in_mg is not null LIMIT 1) vitaminb6_in_mg ON TRUE
 FULL JOIN (select a.folicacid_in_mcg from a where a.folicacid_in_mcg is not null LIMIT 1) folicacid_in_mcg ON TRUE
 FULL JOIN (select a.folate_in_mcg from a where a.folate_in_mcg is not null LIMIT 1) folate_in_mcg ON TRUE
 FULL JOIN (select a.vitaminb12_in_mcg from a where a.vitaminb12_in_mcg is not null LIMIT 1) vitaminb12_in_mcg ON TRUE
 FULL JOIN (select a.pantothenate_in_mg from a where a.pantothenate_in_mg is not null LIMIT 1) pantothenate_in_mg ON TRUE
 FULL JOIN (select a.biotin_in_mcg from a where a.biotin_in_mcg is not null LIMIT 1) biotin_in_mcg ON TRUE
 FULL JOIN (select a.vitaminc_in_mg from a where a.vitaminc_in_mg is not null LIMIT 1) vitaminc_in_mg ON TRUE
 FULL JOIN (select a.vitamind_in_mcg from a where a.vitamind_in_mcg is not null LIMIT 1) vitamind_in_mcg ON TRUE
 FULL JOIN (select a.vitamine_in_mg from a where a.vitamine_in_mg is not null LIMIT 1) vitamine_in_mg ON TRUE
 FULL JOIN (select a.phyticacid_in_mg from a where a.phyticacid_in_mg is not null LIMIT 1) phyticacid_in_mg ON TRUE
    $$
    LANGUAGE SQL;

--select * from get_fct_data(ST_GeomFromText('POINT(35.060316 -15.432044)', 4326),'01520.01.01')