CREATE OR REPLACE VIEW afe_ear_threshold AS

SELECT
    m.id AS micronutrient_id
    , nutrient_name AS micronutrient_name
    , avg(ear) AS afe_ear
FROM
    intake_threshold it
JOIN
    micronutrient m
    ON m."name" = it.nutrient_name
GROUP BY
    it.nutrient_name,
    m.id;

COMMENT ON VIEW afe_ear_threshold IS 'View to extract the Estimated Average Requirement (EAR) for an Adult Female Equivalent (AFE) from the thresholds table';
