DROP MATERIALIZED VIEW IF EXISTS household_intake_afe;

create materialized view household_intake_afe as
select 
    fct_source_id as composition_data_id,
    survey_id as consumption_data_id,
    micronutrient_id,
	micronutrient_supply as dietary_supply,
	is_deficient,
	afe_ear as deficient_value
from household_intake_afe_deficiency_pivot hiadp 