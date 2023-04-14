DROP MATERIALIZED VIEW IF EXISTS household_deficiency_afe_aggregation;

CREATE materialized view household_deficiency_afe_aggregation AS
SELECT
    ST_AsGeoJSON(geometry) AS geometry,
    tbl2.*
FROM aggregation_area
JOIN (
    SELECT
        survey_id,
        fct_source_id,
        country,
        aggregation_area_id,
        aggregation_area_name,
        aggregation_area_type,
        micronutrient_id,
        unit,
        median(micronutrient_supply) AS dietary_supply,
        count(household_id) AS household_count,
        count(household_id) FILTER (
            WHERE
                is_deficient
        ) AS deficient_count,
        round(
            (
                (
                    count(household_id) FILTER (
                        WHERE
                            is_deficient
                    )
                ) :: numeric /(count(household_id))
            ) * 100,
            2
        ) AS deficient_percentage,
        hidp.afe_ear as deficient_value
    FROM
        household_intake_afe_deficiency_pivot hidp
        JOIN micronutrient m ON hidp.micronutrient_id = m.id
        JOIN aggregation_area s ON s.id = hidp.aggregation_area_id
    WHERE (s.type='admin' AND s.admin_level=1) or s.type='country'
    GROUP BY
        survey_id,
        fct_source_id,
        country,
        aggregation_area_id,
        aggregation_area_name,
        aggregation_area_type,
        micronutrient_id,
        hidp.afe_ear,
        m.unit
) AS tbl2 ON tbl2.aggregation_area_id = aggregation_area.id
;

COMMENT ON materialized VIEW household_deficiency_afe_aggregation IS 'View to aggregate the household_intake_deficiency_pivot view to provide the median dietary supply and percentage of deficient households per subregion aggregation area';
