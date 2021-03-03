CREATE OR REPLACE VIEW top20_mn_per_country AS

SELECT b.* , food_genus.food_name
FROM (
	SELECT
		*
		, row_number() over (
			PARTITION BY country_id, mn_name
			ORDER BY mn_consumed_per_day desc
		) as ranking
	FROM (
		SELECT
			cc.country_id
			, cc.data_source_id
			, mn.mn_name
			, fi.food_genus_id
			, sum( (mn.mn_value / 100 * amount_consumed_in_g) ) / 365  AS mn_consumed_per_day
		FROM food_genus_nutrients fi
		CROSS JOIN LATERAL (
			VALUES
			( 'moisture_in_g'                 , moisture_in_g              ),
			( 'energy_in_kcal'                , energy_in_kcal             ),
			( 'energy_in_kj'                  , energy_in_kj               ),
			( 'nitrogen_in_g'                 , nitrogen_in_g              ),
			( 'totalprotein_in_g'             , totalprotein_in_g          ),
			( 'totalfats_in_g'                , totalfats_in_g             ),
			( 'saturatedfa_in_g'              , saturatedfa_in_g           ),
			( 'monounsaturatedfa_in_g'        , monounsaturatedfa_in_g     ),
			( 'polyunsaturatedfa_in_g'        , polyunsaturatedfa_in_g     ),
			( 'cholesterol_in_mg'             , cholesterol_in_mg          ),
			( 'carbohydrateavailable_in_g'    , carbohydrateavailable_in_g ),
			( 'fibre_in_g'                    , fibre_in_g                 ),
			( 'ash_in_g'                      , ash_in_g                   ),
			( 'ca_in_mg'                      , ca_in_mg                   ),
			( 'fe_in_mg'                      , fe_in_mg                   ),
			( 'mg_in_mg'                      , mg_in_mg                   ),
			( 'p_in_mg'                       , p_in_mg                    ),
			( 'k_in_mg'                       , k_in_mg                    ),
			( 'na_in_mg'                      , na_in_mg                   ),
			( 'zn_in_mg'                      , zn_in_mg                   ),
			( 'cu_in_mg'                      , cu_in_mg                   ),
			( 'mn_in_mcg'                     , mn_in_mcg                  ),
			( 'i_in_mcg'                      , i_in_mcg                   ),
			( 'se_in_mcg'                     , se_in_mcg                  ),
			( 'vitamina_in_rae_in_mcg'        , vitamina_in_rae_in_mcg     ),
			( 'thiamin_in_mg'                 , thiamin_in_mg              ),
			( 'riboflavin_in_mg'              , riboflavin_in_mg           ),
			( 'niacin_in_mg'                  , niacin_in_mg               ),
			( 'vitaminb6_in_mg'               , vitaminb6_in_mg            ),
			( 'folicacid_in_mcg'              , folicacid_in_mcg           ),
			( 'folate_in_mcg'                 , folate_in_mcg              ),
			( 'vitaminb12_in_mcg'             , vitaminb12_in_mcg          ),
			( 'pantothenate_in_mg'            , pantothenate_in_mg         ),
			( 'biotin_in_mcg'                 , biotin_in_mcg              ),
			( 'vitaminc_in_mg'                , vitaminc_in_mg             ),
			( 'vitamind_in_mcg'               , vitamind_in_mcg            ),
			( 'vitamine_in_mg'                , vitamine_in_mg             ),
			( 'phyticacid_in_mg'              , phyticacid_in_mg           )
		) AS mn("mn_name", "mn_value")
		JOIN country_consumption cc ON cc.food_genus_id = fi.food_genus_id
		-- WHERE date_part('year', cc.date_consumed) = 2018
		GROUP BY
			cc.data_source_id
			, fi.food_genus_id
			, country_id
			, mn_name
	) a
) b
JOIN food_genus ON b.food_genus_id = food_genus.id
WHERE ranking <= 20
ORDER BY country_id, mn_name, ranking asc
;


COMMENT ON VIEW top20_mn_per_country IS 'View showing the rankings of how much each food genus contributes to a particular micronutrient intake in a particular country and data set.'
