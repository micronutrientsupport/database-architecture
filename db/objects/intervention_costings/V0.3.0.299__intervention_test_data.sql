INSERT INTO app_user (id, username) VALUES (1, 'testuser1');


INSERT INTO intervention_source (id, short_text, citation_text) VALUES (1, 'GFDx', 'Global Fortification Data Exchange. Dashboard: Country Fortification. https://fortificationdata.org/country-fortification-dashboard/?alpha3_code=MWI&lang=en');

insert into food_vehicle (id, vehicle_name) VALUES (1, 'wheat flour');
insert into food_vehicle (id, vehicle_name) VALUES (2, 'oil');

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


INSERT INTO fortification_level (
    intervention_id
    -- , micronutrient_id
    , target_level
    , actual_level
    , year
    , fortifiable_percentage
    , fortified_percentage

    , fortificant_id
    , fortificant_proportion
)
VALUES
(1, 1     , 1     , 2021 , 98, 20, 1, 0.02),
(1, 0.02  , 0.02  , 2021 , 98, 20, 2, 0.04),
(1, 1     , 1     , 2022 , 98, 20, 1, 0.02),
(1, 0.02  , 0.02  , 2022 , 98, 20, 2, 0.04)
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

insert into display_heading (id, display_heading_text) VALUES (1, 'Industry Information');
insert into display_heading (id, display_heading_text) VALUES (2, 'Industry Startup Scale up cost summary');


insert into display_sub_heading (id, display_sub_heading_text) VALUES (1, 'Equipment');

INSERT INTO intervention_factor (
    id
    , food_vehicle_id
    , label
    , display_heading_id
    , display_sub_heading_id
    , formula_index
)
VALUES (
    1
    , 1 --wheat flour
    , 'Number of domestic industrial Mills (capacity > 20 metric ton /day)'
    , 1
    , NULL
    , 1
),
(
    2
    , 1 --wheat flour
    , 'Imputed number of domestic mills fortifying food vehicle'
    , 1
    , NULL
    , 2
),
(
    3
    , 2 --oil
    , 'Number of domestic industrial edible oil refineries (capacity of > 5 MT/day)'
    , 1
    , NULL
    , 1
),
(
    4
    , 2 --oil
    , 'Imputed number of domestic industrial refineries fortifying food vehicle'
    , 1
    , NULL
    , 2
),
(
    5
    , 1 --wheat flour
    , 'Feeder/dosifier (unit cost) and installation'
    , 1
    , NULL
    ,37
),
(
    6
    , 2 -- oil
    , 'Stainless steel mixing tank (unit cost)'
    , 1
    , 1
    , 37
)
;

INSERT INTO factor_value (
    intervention_id
    , intervention_factor_id
    , value
    , year
)
VALUES
(
    1
    , 1
    , 3
    , 2021
)
