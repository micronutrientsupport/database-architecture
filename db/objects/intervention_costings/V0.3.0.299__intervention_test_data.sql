INSERT INTO app_user (id, username) VALUES (1, 'testuser1');


INSERT INTO data_citation (id, short_text, citation_text) VALUES (1, 'GFDx', 'Global Fortification Data Exchange. Dashboard: Country Fortification. https://fortificationdata.org/country-fortification-dashboard/?alpha3_code=MWI&lang=en');

insert into food_vehicle (id, vehicle_name) VALUES (1, 'wheat flour');
insert into food_vehicle (id, vehicle_name) VALUES (2, 'oil');
insert into food_vehicle (id, vehicle_name) VALUES (3, 'Vitamin A Maize');
insert into food_vehicle (id, vehicle_name) VALUES (4, 'maize flour');

INSERT INTO fortification_type (id, name) VALUES ('LSF', 'Industrial Fortification');
INSERT INTO fortification_type (id, name) VALUES ('BF' , 'Biofortification');
INSERT INTO fortification_type (id, name) VALUES ('AF' , 'Agro-Fortification');

insert into intervention
	(id,
    intervention_name,
    country_id,
    data_citation_id,
    food_vehicle_id,
    fortification_type_id,
    program_status,
    is_premade,
	file_name)
	values
	(1,
    'Malawi Large Scale Food Fortification of Wheat flour',
    'MWI',
    1,
    1,
    'LSF',
    'mandatory, ongoing',
    True,
	'MAPS Malawi Cost Models 9Sept2021.xlsx'),
    (2,
    'Malawi Biofortification of Vitamin A Maize',
    'MWI',
    1,
    3,
    'BF',
    '10 varieties have been released',
    True,
	'MAPS Malawi Cost Models 9Sept2021.xlsx');
    
 

SELECT pg_catalog.setval(pg_get_serial_sequence('intervention', 'id'), (SELECT MAX(id) FROM intervention)+1);



INSERT INTO fortificant (
    id,
    name,
    micronutrient_id,
    mn_percent,
    price
)
VALUES (
    1,
    'Retinyl Palmitate- 250,000 IU/g (dry)'
    , 'A'
    , 51
    , 117

),
(
    2,
    'Vit. B-12 0.1% WS'
    , 'B12'
    , 0.1
    , 42

)
;








