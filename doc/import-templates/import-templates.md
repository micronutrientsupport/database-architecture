

# fooditem
Column Name                |  Description                                                                                                                                                                                                     |
| -----------              |    -------------                                                                                                                                                                                                 |
original_food_id           |    The food ID as it was found in the original Food Composition Table. Kept for informational purposes only                                                                                                      |
original_food_name         |    The food name as it was found in the original Food Composition Table. Kept for informational purposes only                                                                                                    |
food_genus_id              |    The food genus of this food. Will be used for matching, and, in the future, will come from a curated list.                                                                                                    |
food_genus_description     |    Description for this food_genus                                                                                                                                                                              |
food_group                 |    The food group for this food_genus.                                                                                                                                                                           |
food_subgroup              |    The food subgroup for this food genus.                                                                                                                                                                        |
food_genus_confidence      |    How confident we are in the matching. Mediums will show a warning to the user, low confidence fooditems won't be used in any calculations at all. Possible values: [ 'High' , 'Medium', 'Low']                |
fct_name                   |    The name (citation text?) for the food composition table from which this fooditem came. For example, 'Gambia Prynand Paul'.                                                                                   |
~~fct_pub_date~~           |    ~~The publication date of the FCT, if known~~                                                                                                                                                                    |
data_reference_name        |  The name of this citation                                                                                                                                                                                       |
data_reference_original_id |  the original id of this citation                                                                                                                                                                                |
data_reference_author      |  The author of the publication from where the nutrient values were derived                                                                                                                                     |
data_reference_publication |   The publication in which the micronutrient contents of this food were found.                                                                                                                                  |
data_reference_isbn        |                                                                                                                                                                                                                  |
data_reference_notes       |                                                                                                                                                                                                                  |
moisture_in_g              |    The moisture content of this food item, in grams per 100g                                                                                                                                                     |
energy_in_kcal             |                                                                                                                                                                                                                  |
energy_in_kj               |                                                                                                                                                                                                                  |
nitrogen_in_g              |    Nitrogen content of this fooditem, in grams per 100g                                                                                                                                                          |
totalprotein_in_g          |    Total Protein Content, in grams per 100g                                                                                                                                                                      |
totalfats_in_g             |    Total Fats, in grams per 100g                                                                                                                                                                                 |
saturatedfa_in_g           |    Saturated Fatty Acids, in grams per 100g                                                                                                                                                                      |
monounsaturatedfa_in_g     |    Monounsaturated Fatty Acids, in grams per 100g                                                                                                                                                                |
polyunsaturatedfa_in_g     |    Polyunsaturated Fatty Acids, in grams per 100g                                                                                                                                                                |
cholesterol_in_mg          |    The Cholesterol content of this food item, in milligrams per 100g                                                                                                                                             |
carbohydrates_in_g         |     Carbohydrates in g per 100g                                                                                                                                                                                  |
fibre_in_g                 |    The total dietary fibre content of this food item (determined by multiple methods), in grams per 100g                                                                                                         |
ash_in_g                   |   (I don't think we really need the ash content of the food? candidate for deletion from the system)                                                                                                             |
ca_in_mg                   |    The Calcium content of this food item, in milligrams per 100g                                                                                                                                                 |
fe_in_mg                   |    The Iron content of this food item, in milligrams per 100g                                                                                                                                                    |
mg_in_mg                   |    The Magnesium content of this food item, in milligrams per 100g                                                                                                                                               |
p_in_mg                    |    The Phosporous content of the food item, in milligrams per 100g                                                                                                                                               |
k_in_mg                    |    The Potassium content of this food item, in milligrams per 100g                                                                                                                                               |
na_in_mg                   |    The Sodium content of this food item, in milligrams per 100g                                                                                                                                                  |
zn_in_mg                   |    The Zinc content of this food item, in milligrams per 100g                                                                                                                                                    |
cu_in_mg                   |    The Copper content of this food item, in milligrams per 100g                                                                                                                                                  |
mn_in_mcg                  |    The Manganese content of this food item, in micrograms per 100g                                                                                                                                               |
i_in_mcg                   |    the Iondine content of this food item, in micrograms per 100g                                                                                                                                                 |
se_in_mcg                  |    The Selenium content of this food item, in micrograms per 100g                                                                                                                                                |
vitamina_in_rae_in_mcg     |    The Vitamin A content of the food, in Retinol Activity Equivalent (RAE), and in micrograms per 100g                                                                                                           |
thiamin_in_mg              |    The Thiamin content of this food item, in milligrams per 100g                                                                                                                                                 |
riboflavin_in_mg           |    The Riboflavin content of this food item, in milligrams per 100g                                                                                                                                              |
niacin_in_mg               |    The Niacin content of this food item, in milligrams per 100g                                                                                                                                                  |
vitaminb6_in_mg            |    The Vitamin B6 content of this food item, in milligrams per 100g                                                                                                                                              |
folicacid_in_mcg           |    The Folic Acid content of this food item, in micrograms per 100g                                                                                                                                              |
folate_in_mcg              |    The total folate content of this food item, including food folate and synthetic folate, in micrograms per 100g                                                                                                |
vitaminb12_in_mcg          |    The Vitamin B12 content of this food item, in micrograms per 100g                                                                                                                                             |
pantothenate_in_mg         |    The Pantothenate content of this food item, in milligrams per 100g                                                                                                                                            |
biotin_in_mcg              |    The Biotin content of this food item, in micrograms per 100g                                                                                                                                                  |
vitaminc_in_mg             |    The Vitamin C content of this food item, in milligrams per 100g                                                                                                                                               |
vitamind_in_mcg            |    The Vitamin D content of this food item, in micrograms per 100g                                                                                                                                               |
vitamine_in_mg             |    The Vitamin E content of this food item, in milligrams per 100g                                                                                                                                               |
phyticacid_in_mg           |    The Phytic Acid content of this food item, in milligrams per 100g                                                                                                                                             |



## Household & Intake data

### household:

| header | description |
| ---    | ----------- |
| original_id                ||
| lat                        ||
| lon                        ||
| urbanity                   ||
| household_expenditure      ||
| wealth_quintile            ||
| survey_id                  | which survey this data is from e.g. 'IHS3'. There'll be some data about the survey itself, but I'll ask for that sepraretly |
| interview_date             ||


### household consumption

| header | description |
| ---    | ----------- |
| food_genus_id         | The food_genus id of the fooditem that was consumed                                                                                                              |
| food_genus_confidence | How confident we are in matching this food to the corresponding food_genus entry [ 'High' , 'Medium', 'Low']                                                     |
| original_food_name    | the original food name, as given by the consumption survey                                                                                                       |
| household_original_id | The original id of the household that consumed the food item                                                                                                     |
| source_of_food        | From where the household obtained the food; if they grew it themselves, bought it at market, or had it gifted to them ['own production', 'bought', 'gifted']     |
| date_consumed         | The date when the fooditem was consumed                                                                                                                          |
| amount_consumed_in_g  | How much of the fooditem was consumed on average per day, in grams                                                                                               |


### household member
| header                       | description                                                                                                                                              |
| ---                          | -----------                                                                                                                                              |
| household_member_original_id |                                                                                                                                                          |
| household_original_id        |                                                                                                                                                          |
| sex                          | ['m','f'] 'Whether the household member is male or female';                                                                                              |
| education_level              | 'The highest level of education achieved by this person. Can be primary, secondary, or tertiary education';                                              |
| age_in_months                | 'The age of the person at the time of the survey, in months. Ages for individuals older than 5 years are likely to be calculated from the age in years'; |
| is_breastfed                 | 'Whether the child is being breastfed; "true" indicates that they are';                                                                                  |
| is_lactating                 | 'Whether this woman is lactating; "true" indicates that she is';                                                                                         |
| is_pregnant                  | 'Whether this woman is pregnant; "true" indicates that she is';                                                                                          |
| is_smoker                    | 'Whether this person smokes tobacco';                                                                                                                    |
| had_illness                  | 'Whether this person has been ill in the last two weeks';                                                                                                |
| had_malaria                  | 'Whether this person has had malaria in the last two weeks';                                                                                             |
| had_diarrhoea                | 'Whether this person has had diarrhoea in the last two weeks';                                                                                           |







###  household member consumption
| header | description |
| ---    | ----------- |
| household_member_id   | The id of the household member that consumed the food item                                                                                                             |
| food_genus_id         | The food_genus id of the fooditem that was consumed                                                                                                                    |
| food_genus_confidence | How confident we are in matching this food to the corresponding food_genus entry                                                                                       |
| source_of_food        | From where the household member obtained the food; if they grew it themselves, bought it at market, or had it gifted to them ['own production', 'bought', 'gifted']    |
| date_consumed         | The date when the fooditem was consumed                                                                                                                                |
| amount_consumed_in_g  | How much of the fooditem was consumed, in grams                                                                                                                        |


### food composition table citations

 citation of the journal article where that food composition for that particular food item was taken from.

| field                      |           description   |
|----------------------------|-------------------------|
| data_reference_name        |                         |
| data_reference_original_id |                         |
| data_reference_author      |                         |
| data_reference_publication |                         |
| data_reference_isbn        |                         |
| data_reference_notes       |                         |