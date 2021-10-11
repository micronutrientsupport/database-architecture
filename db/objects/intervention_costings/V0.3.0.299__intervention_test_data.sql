INSERT INTO app_user (id, username) VALUES (1, 'testuser1');


INSERT INTO intervention_source (id, short_text, citation_text) VALUES (1, 'GFDx', 'Global Fortification Data Exchange. Dashboard: Country Fortification. https://fortificationdata.org/country-fortification-dashboard/?alpha3_code=MWI&lang=en');

insert into food_vehicle (id, vehicle_name) VALUES (1, 'wheat flour');

INSERT INTO intervention_type (id, name) VALUES (1, 'Industrial Fortification');
INSERT INTO intervention_type (id, name) VALUES (2, 'Biofortification');
INSERT INTO intervention_type (id, name) VALUES (3, 'Agro-Fortification');

INSERT INTO program_status (id, description) VALUES (1, 'voluntary, transitioning to mandatory');

-- INSERT INTO fortificant (id, name) VALUES (1, 'Folic Acid');
-- INSERT INTO fortificant (id, name) VALUES (1, 'Folic Acid');



INSERT INTO intervention (
    intervention_name
    , country_id
    , app_user_id
    , intervention_source_id
    , food_vehicle_id
    , status
    , intervention_type_id
    , program_status_id
)
VALUES (
    'malawi industrial wheat fortification'
    , 'MWI'
    , 1
    , 1
    , 1
    , '???? what does this status refer to?'
    , 1
    , 1

);


-- expected loss doesn't seem to be recorded in spreadsheet
-- INSERT INTO expected_loss (intervention_id, micronutrient_id, expected_loss_percentage) VALUES (1, )



INSERT INTO fortification_level (
    intervention_id
    , micronutrient_id
    , target_level
    , actual_level
    , year
    , fortifiable_percentage
    , fortified_percentage
)
VALUES
(1, 'A'   , 1     , 1     , 2021 , 98, 20),
(1, 'B12' , 0.02  , 0.02  , 2021 , 98, 20),
(1, 'A'   , 1     , 1     , 2022 , 98, 20),
(1, 'B12' , 0.02  , 0.02  , 2022 , 98, 20)
;

INSERT INTO expected_loss (
    micronutrient_id
    , intervention_id
    , expected_loss_percentage
)
VALUES
('A'  , 1, 0),
('B12', 1, 0)
;
