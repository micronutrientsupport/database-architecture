CREATE materialized view country_deficiency_afe AS
SELECT
with country_intake_pivot as
(
	select 
		mn_name as micronutrient_id
		, mn_value as dietary_supply
		, c.id as country_id
		, c.name as country_name
		, c.geometry as geometry
		, ci.fct_source_id as composition_data_id
		, ci.data_source_id as consumption_data_id
	from country_intake ci
	join country_consumption_source ccs on ci.data_source_id = ccs.id 
	join country c on ST_EQUALS(ccs.geometry, c.geometry)
	CROSS JOIN LATERAL (
	    VALUES
	        ('A'           , VitaminA_in_RAE_in_mcg     ),
	        ('B6'          , VitaminB6_in_mg            ),
	        ('B12'         , VitaminB12_in_mcg          ),
	        ('C'           , VitaminC_in_mg             ),
	        ('D'           , VitaminD_in_mcg            ),
	        ('E'           , VitaminE_in_mg             ),
	        ('B1'          , Thiamin_in_mg              ),
	        ('B2'          , Riboflavin_in_mg           ),
	        ('B3'          , Niacin_in_mg               ),
	        ('Folic Acid'  , Folicacid_in_mcg           ),
	        ('B9'          , Folate_in_mcg              ),
	        ('B5'          , Pantothenate_in_mg         ),
	        ('B7'          , Biotin_in_mcg              ),
	        ('IP6'         , PhyticAcid_in_mg           ),
	        ('Ca'          , Ca_in_mg                   ),
	        ('Cu'          , Cu_in_mg                   ),
	        ('Fe'          , Fe_in_mg                   ),
	        ('Mg'          , Mg_in_mg                   ),
	        ('Mn'          , Mn_in_mcg                  ),
	        ('P'           , P_in_mg                    ),
	        ('K'           , K_in_mg                    ),
	        ('Na'          , Na_in_mg                   ),
	        ('Zn'          , Zn_in_mg                   ),
	        ('I'           , I_in_mcg                   ),
	        ('N'           , Nitrogen_in_g              ),
	        ('Se'          , Se_in_mcg                  ),
	        ('Ash'         , Ash_in_g                   ),
	        ('Fibre'       , Fibre_in_g                 ),
	        ('Carbohydrates', carbohydrates_in_g         ),
	        ('Cholesterol' , Cholesterol_in_mg          ),
	        ('Protein'     , TotalProtein_in_g          ),
	        ('Fat'         , TotalFats_in_g             ),
	        ('Energy'      , Energy_in_kCal             ),
	        ('Moisture'    , Moisture_in_g              )
	) AS mn("mn_name", "mn_value")
)
select 
	cip.country_id as aggregation_area_id
	, cip.country_name as aggregation_area_name
	, 'country' as aggregation_area_type
	, cip.composition_data_id
	, cip.consumption_data_id
	, cip.country_id
	, cip.geometry
	, cip.dietary_supply
	, m.unit
	, aet.afe_ear as deficient_value
	, CASE WHEN cip.ditary_supply >= aet.afe_ear THEN '0'
            ELSE '100' as deficient_percentage
from country_intake_pivot cip
join micronutrient m on cip.micronutrient_id = m.id
join afe_ear_threshold aet on aet.micronutrient_id = m.id;

COMMENT ON materialized VIEW country_deficiency_afe IS 'View of the national dietary availability and deficiency threshold from country level consumption data';
