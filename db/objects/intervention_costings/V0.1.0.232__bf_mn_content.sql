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

INSERT INTO biofortification_mn_content(country_id,food_vehicle_id,micronutrient_id,units,non_bf_mn_content,non_bf_mn_content_source,bf_avg_mn_content,bf_avg_mn_content_source,bf_add_mn_content,bf_add_mn_content_source) VALUES
 ('ETH',6,'A','mcg RAE per g',0,'West African FCT, item 01_004',3.1,'Average content of released varieties according to HarvestPlus (https://bcr.harvestplus.org/varieties_released/country?id_country=71&country_name=Ethiopia) and assuming 12:1 conversion ratio of pro-vitamin A (PVA) to retinol activity equivalents (RAE).',3.1,'Calculation')
,('ETH',11,'A','mcg RAE per g',0.05,'West African FCT, item 02_022',12.0,'Average content of released varieties according to HarvestPlus (https://bcr.harvestplus.org/varieties_released/country?id_country=71&country_name=Ethiopia) and assuming 12:1 conversion ratio of pro-vitamin A (PVA) to retinol activity equivalents (RAE).',11.9,'Calculation')
,('MWI',6,'A','mcg RAE per g',0,'Malawi FCT, item MW01_0038',0.55,'Average content of released varieties according to HarvestPlus (https://bcr.harvestplus.org/varieties_released/country?id_country=134&country_name=Malawi) and assuming 12:1 conversion ratio of pro-vitamin A (PVA) to retinol activity equivalents (RAE).',0.6,'Calculation')
,('MWI',11,'A','mcg RAE per g',0.02,'Malawi FCT, item MW01_0065',5.83,'Average content of released varieties according to HarvestPlus (https://bcr.harvestplus.org/varieties_released/country?id_country=134&country_name=Malawi) and assuming 12:1 conversion ratio of pro-vitamin A (PVA) to retinol activity equivalents (RAE).',5.8,'Calculation')
,('MWI',15,'Fe','mg per g',0.07,'Malawi FCT, average of items MW02_0004, MW02_0007, and MW02_0017',0.09,'Average content of released varieties in Rwanda according to HarvestPlus (https://bcr.harvestplus.org/varieties_released/country?id_country=184&country_name=Rwandaa).',0.02,'Calculation');
