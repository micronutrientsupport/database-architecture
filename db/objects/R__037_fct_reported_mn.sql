create or replace view fct_reported_micronutrients as
select fct_source_id, 

       string_to_array(
       		CONCAT_WS(',', 
				CASE WHEN sum(VitaminA_in_RAE_in_mcg) IS NULL THEN NULL ELSE 'A' END,
				CASE WHEN sum(VitaminB6_in_mg) IS NULL THEN NULL ELSE 'B6' END,
				CASE WHEN sum(VitaminB12_in_mcg) IS NULL THEN NULL ELSE 'B12' END,
				CASE WHEN sum(VitaminC_in_mg) IS NULL THEN NULL ELSE 'C' END,
				CASE WHEN sum(VitaminD_in_mcg) IS NULL THEN NULL ELSE 'D' END,
				CASE WHEN sum(VitaminE_in_mg) IS NULL THEN NULL ELSE 'E' END,
				CASE WHEN sum(Thiamin_in_mg) IS NULL THEN NULL ELSE 'B1' END,
				CASE WHEN sum(Riboflavin_in_mg) IS NULL THEN NULL ELSE 'B2' END,
				CASE WHEN sum(Niacin_in_mg) IS NULL THEN NULL ELSE 'B3' END,
				CASE WHEN sum(Folicacid_in_mcg) IS NULL THEN NULL ELSE 'Folic Acid' END,
				CASE WHEN sum(Folate_in_mcg) IS NULL THEN NULL ELSE 'B9' END,
				CASE WHEN sum(Pantothenate_in_mg) IS NULL THEN NULL ELSE 'B5' END,
				CASE WHEN sum(Biotin_in_mcg) IS NULL THEN NULL ELSE 'B7' END,
				CASE WHEN sum(PhyticAcid_in_mg) IS NULL THEN NULL ELSE 'IP6' END,
				CASE WHEN sum(Ca_in_mg) IS NULL THEN NULL ELSE 'Ca' END,
				CASE WHEN sum(Cu_in_mg) IS NULL THEN NULL ELSE 'Cu' END,
				CASE WHEN sum(Fe_in_mg) IS NULL THEN NULL ELSE 'Fe' END,
				CASE WHEN sum(Mg_in_mg) IS NULL THEN NULL ELSE 'Mg' END,
				CASE WHEN sum(Mn_in_mcg) IS NULL THEN NULL ELSE 'Mn' END,
				CASE WHEN sum(P_in_mg) IS NULL THEN NULL ELSE 'P' END,
				CASE WHEN sum(K_in_mg) IS NULL THEN NULL ELSE 'K' END,
				CASE WHEN sum(Na_in_mg) IS NULL THEN NULL ELSE 'Na' END,
				CASE WHEN sum(Zn_in_mg) IS NULL THEN NULL ELSE 'Zn' END,
				CASE WHEN sum(I_in_mcg) IS NULL THEN NULL ELSE 'I' END,
				CASE WHEN sum(Nitrogen_in_g) IS NULL THEN NULL ELSE 'N' END,
				CASE WHEN sum(Se_in_mcg) IS NULL THEN NULL ELSE 'Se' END,
				CASE WHEN sum(Ash_in_g) IS NULL THEN NULL ELSE 'Ash' END,
				CASE WHEN sum(Fibre_in_g) IS NULL THEN NULL ELSE 'Fibre' END,
				CASE WHEN sum(carbohydrates_in_g) IS NULL THEN NULL ELSE 'Carbohydrate' END,
				CASE WHEN sum(Cholesterol_in_mg) IS NULL THEN NULL ELSE 'Cholesterol' END,
				CASE WHEN sum(TotalProtein_in_g) IS NULL THEN NULL ELSE 'Protein' END,
				CASE WHEN sum(TotalFats_in_g) IS NULL THEN NULL ELSE 'Fat' END,
				CASE WHEN sum(Energy_in_kCal) IS NULL THEN NULL ELSE 'Energy' END,
				CASE WHEN sum(Moisture_in_g) IS NULL THEN NULL ELSE 'Moisture' end
			)
       , ',')
       AS "reported_micronutrients"

from fooditem group by fct_source_id;

COMMENT ON VIEW fct_reported_micronutrients IS 'View of array of reported micronutrients for a given FCT';
