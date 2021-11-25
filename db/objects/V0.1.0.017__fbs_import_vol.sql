
CREATE TABLE fbs_import_vol (
	filename text NULL,
	food_genus_id text NULL,
	food_genus_confidence text NULL,
	country_id text NULL,
	original_id text NULL,
	original_name text NULL,
	date_consumed text NULL,
	data_source_id text NULL,
	amount_consumed_in_g text NULL,
	country_consumption_source text NULL
);

COMMENT ON TABLE fbs_import_vol IS 'Holding table for imported FBS data to enable distribution into the proper relational model.';