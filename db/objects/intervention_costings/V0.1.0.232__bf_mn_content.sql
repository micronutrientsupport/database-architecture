CREATE TABLE biofortification_mn_content (
	country_id text REFERENCES country(id),
	food_vehicle_id integer  REFERENCES food_vehicle(id),
    micronutrient_id text REFERENCES micronutrient(id),
	units text NULL,
	non_bf_mn_content numeric NULL,
	non_bf_mn_content_source text NULL,
	bf_avg_mn_content numeric NULL,
	bf_avg_mn_content_source text NULL,
	bf_add_mn_content numeric NULL,
	bf_add_mn_content_source text NULL
);