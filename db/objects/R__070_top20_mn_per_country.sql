DROP MATERIALIZED VIEW IF EXISTS top20_mn_per_country;
CREATE MATERIALIZED VIEW top20_mn_per_country AS

SELECT b.* 
    , food_genus.food_name
	, food_group.id as food_group_id
	, food_group.name as food_group_name
FROM (
	SELECT
		*
		, row_number() over (
			PARTITION BY
				country_id
				, fct_source_id
				, data_source_id
				, mn_name
			ORDER BY mn_consumed_per_day desc NULLS LAST
		) as ranking
	FROM (
		SELECT
			cc.country_id
			, fi.fct_source_id
			, cc.data_source_id
			, mn.mn_name
			, fi.food_genus_id
			, sum( (mn.mn_value / 100 * amount_consumed_in_g) )  AS mn_consumed_per_day
		FROM food_genus_nutrients fi
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
		JOIN 
		(select cc1.food_genus_id,
				cc1.data_source_id, 
				c1.id as country_id,
				cc1.amount_consumed_in_g
			from
			country_consumption cc1,
			country_consumption_source ccs1,
			country c1 
			where 
			cc1.data_source_id = ccs1.id 
			and st_equals(ccs1.geometry, c1.geometry)) cc
		ON cc.food_genus_id = fi.food_genus_id
		-- WHERE date_part('year', cc.date_consumed) = 2018
		GROUP BY
			cc.data_source_id
			, fi.food_genus_id
			, fi.fct_source_id
			, country_id
			, mn_name
	) a
) b
JOIN food_genus ON b.food_genus_id = food_genus.id
JOIN food_group ON food_genus.food_group_id = food_group.id
WHERE ranking <= 20
ORDER BY country_id, mn_name, ranking asc
;


COMMENT ON MATERIALIZED VIEW top20_mn_per_country IS 'View showing the rankings of how much each food genus contributes to a particular micronutrient intake in a particular country and data set.'
