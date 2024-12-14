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

CREATE TABLE agrofortification_mn_content (
	country_id text REFERENCES country(id),
	application_type text check (application_type in ('foliar','granular','both') ),
	food_vehicle_id integer  REFERENCES food_vehicle(id),
    micronutrient_id text REFERENCES micronutrient(id),
	application_rate number NULL,
	number_applications number NULL,
	impact number NULL,
	impact_units text NULL,
	source text,
	non_af_mn_content numeric NULL,
	non_af_mn_content_units text NULL,
	non_af_mn_content_source text NULL,
	af_add_mn_content numeric NULL,
	af_add_mn_content_units text NULL,
	af_add_mn_content_source text NULL
);