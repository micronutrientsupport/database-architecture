CREATE FUNCTION get_fct_data(geometry(Point, 4326),text)
RETURNS TABLE(
	moisture_in_g numeric(20, 10),
	energy_in_kcal numeric(20, 10),
	energy_in_kj numeric(20, 10),
	nitrogen_in_g numeric(20, 10),
	totalprotein_in_g numeric(20, 10),
	totalfats_in_g numeric(20, 10),
	saturatedfa_in_g numeric(20, 10),
	monounsaturatedfa_in_g numeric(20, 10),
	polyunsaturatedfa_in_g numeric(20, 10),
	cholesterol_in_mg numeric(20, 10),
	carbohydrates_in_g numeric(20, 10),
	fibre_in_g numeric(20, 10),
	ash_in_g numeric(20, 10),
	ca_in_mg numeric(20, 10),
	fe_in_mg numeric(20, 10),
	mg_in_mg numeric(20, 10),
	p_in_mg numeric(20, 10),
	k_in_mg numeric(20, 10),
	na_in_mg numeric(20, 10),
	zn_in_mg numeric(20, 10),
	cu_in_mg numeric(20, 10),
	mn_in_mcg numeric(20, 10),
	i_in_mcg numeric(20, 10),
	se_in_mcg numeric(20, 10),
	vitamina_in_rae_in_mcg numeric(20, 10),
	thiamin_in_mg numeric(20, 10),
	riboflavin_in_mg numeric(20, 10),
	niacin_in_mg numeric(20, 10),
	vitaminb6_in_mg numeric(20, 10),
	folicacid_in_mcg numeric(20, 10),
	folate_in_mcg numeric(20, 10),
	vitaminb12_in_mcg numeric(20, 10),
	pantothenate_in_mg numeric(20, 10),
	biotin_in_mcg numeric(20, 10),
	vitaminc_in_mg numeric(20, 10),
	vitamind_in_mcg numeric(20, 10),
	vitamine_in_mg numeric(20, 10),
	phyticacid_in_mg numeric(20, 10)
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