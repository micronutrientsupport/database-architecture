CREATE OR REPLACE VIEW micronutrient_dropdown AS
SELECT *
FROM micronutrient
WHERE is_user_visible
;


COMMENT ON VIEW micronutrient_dropdown IS 'Micronutrients excluding fatty acid and "Energy in kJ", which are columns that appear in the food composition data but which we do not want to display to end users in our analyses';
