DROP MATERIALIZED VIEW IF EXISTS household_deficiency_afe_aggregation;

CREATE materialized view household_deficiency_aggregation AS
SELECT
    survey_id,
    fct_source_id,
    country,
    subregion_id,
    subregion_name,
    ST_AsGeoJSON(geometry) AS geometry,
    micronutrient_id,
    unit,
    median(micronutrient_supply) AS median_supply,
    count(household_id) AS household_count,
    count(household_id) FILTER (
        WHERE
            deficient
    ) AS deficient_count,
    round(
        (
            (
                count(household_id) FILTER (
                    WHERE
                        deficient
                )
            ) :: numeric /(count(household_id))
        ) * 100,
        2
    ) AS deficient_percentage
FROM
    household_intake_afe_deficiency_pivot hidp
    JOIN micronutrient m ON hidp.micronutrient_id = m.id
    JOIN subregion s ON s.id = hidp.subregion_id
GROUP BY
    survey_id,
    fct_source_id,
    country,
    subregion_id,
    subregion_name,
    geometry,
    micronutrient_id,
    m.unit;

COMMENT ON materialized VIEW household_deficiency_afe_aggregation IS 'View to aggregate the household_intake_deficiency_pivot view to provide the median dietary supply and percentage of deficient households per subregion';
