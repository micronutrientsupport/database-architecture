## fooditem

| Column Name            | Description                                                                                                                                                                                    |
| ---------------------- | ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| original_food_id       | The food ID as it was found in the original Food Composition Table. Kept for informational purposes only                                                                                       |
| original_food_name     | The food name as it was found in the original Food Composition Table. Kept for informational purposes only                                                                                     |
| food_genus_id          | The food genus of this food. Will be used for matching, and, in the future, will come from a curated list.                                                                                     |
| food_genus_description | Description for this food_genus                                                                                                                                                                |
| food_group             | The food group for this food_genus.                                                                                                                                                            |
| food_subgroup          | The food subgroup for this food genus.                                                                                                                                                         |
| food_genus_confidence  | How confident we are in the matching. Mediums will show a warning to the user, low confidence fooditems won't be used in any calculations at all. Possible values: [ 'High' , 'Medium', 'Low'] |
| fct_name               | The name (citation text?) for the food composition table from which this fooditem came. For example, 'Gambia Prynand Paul'.                                                                    |
| ~~fct_pub_date~~       | ~~The publication date of the FCT, if known~~                                                                                                                                                  |
| citation_name          | The name of this citation                                                                                                                                                                      |
| citation_original_id   | the original id of this citation                                                                                                                                                               |
| citation_author        | The author of the publication from where the nutrient values were derived                                                                                                                      |
| citation_publication   | The publication in which the micronutrient contents of this food were found.                                                                                                                   |
| citation_isbn          |                                                                                                                                                                                                |
| citation_notes         |                                                                                                                                                                                                |
| moisture_in_g          | The moisture content of this food item, in grams per 100g                                                                                                                                      |
| energy_in_kcal         |                                                                                                                                                                                                |
| energy_in_kj           |                                                                                                                                                                                                |
| nitrogen_in_g          | Nitrogen content of this fooditem, in grams per 100g                                                                                                                                           |
| totalprotein_in_g      | Total Protein Content, in grams per 100g                                                                                                                                                       |
| totalfats_in_g         | Total Fats, in grams per 100g                                                                                                                                                                  |
| saturatedfa_in_g       | Saturated Fatty Acids, in grams per 100g                                                                                                                                                       |
| monounsaturatedfa_in_g | Monounsaturated Fatty Acids, in grams per 100g                                                                                                                                                 |
| polyunsaturatedfa_in_g | Polyunsaturated Fatty Acids, in grams per 100g                                                                                                                                                 |
| cholesterol_in_mg      | The Cholesterol content of this food item, in milligrams per 100g                                                                                                                              |
| carbohydrates_in_g     | carbohydrates in g per 100g                                                                                                                                                                    |
| fibre_in_g             | The total dietary fibre content of this food item (determined by multiple methods), in grams per 100g                                                                                          |
| ash_in_g               | (I don't think we really need the ash content of the food? candidate for deletion from the system)                                                                                             |
| ca_in_mg               | The Calcium content of this food item, in milligrams per 100g                                                                                                                                  |
| fe_in_mg               | The Iron content of this food item, in milligrams per 100g                                                                                                                                     |
| mg_in_mg               | The Magnesium content of this food item, in milligrams per 100g                                                                                                                                |
| p_in_mg                | The Phosporous content of the food item, in milligrams per 100g                                                                                                                                |
| k_in_mg                | The Potassium content of this food item, in milligrams per 100g                                                                                                                                |
| na_in_mg               | The Sodium content of this food item, in milligrams per 100g                                                                                                                                   |
| zn_in_mg               | The Zinc content of this food item, in milligrams per 100g                                                                                                                                     |
| cu_in_mg               | The Copper content of this food item, in milligrams per 100g                                                                                                                                   |
| mn_in_mcg              | The Manganese content of this food item, in micrograms per 100g                                                                                                                                |
| i_in_mcg               | the Iondine content of this food item, in micrograms per 100g                                                                                                                                  |
| se_in_mcg              | The Selenium content of this food item, in micrograms per 100g                                                                                                                                 |
| vitamina_in_rae_in_mcg | The Vitamin A content of the food, in Retinol Activity Equivalent (RAE), and in micrograms per 100g                                                                                            |
| thiamin_in_mg          | The Thiamin content of this food item, in milligrams per 100g                                                                                                                                  |
| riboflavin_in_mg       | The Riboflavin content of this food item, in milligrams per 100g                                                                                                                               |
| niacin_in_mg           | The Niacin content of this food item, in milligrams per 100g                                                                                                                                   |
| vitaminb6_in_mg        | The Vitamin B6 content of this food item, in milligrams per 100g                                                                                                                               |
| folicacid_in_mcg       | The Folic Acid content of this food item, in micrograms per 100g                                                                                                                               |
| folate_in_mcg          | The total folate content of this food item, including food folate and synthetic folate, in micrograms per 100g                                                                                 |
| vitaminb12_in_mcg      | The Vitamin B12 content of this food item, in micrograms per 100g                                                                                                                              |
| pantothenate_in_mg     | The Pantothenate content of this food item, in milligrams per 100g                                                                                                                             |
| biotin_in_mcg          | The Biotin content of this food item, in micrograms per 100g                                                                                                                                   |
| vitaminc_in_mg         | The Vitamin C content of this food item, in milligrams per 100g                                                                                                                                |
| vitamind_in_mcg        | The Vitamin D content of this food item, in micrograms per 100g                                                                                                                                |
| vitamine_in_mg         | The Vitamin E content of this food item, in milligrams per 100g                                                                                                                                |
| phyticacid_in_mg       | The Phytic Acid content of this food item, in milligrams per 100g                                                                                                                              |

## Household & Intake data

### household:

| Column Name           | Data Type | Values/Format      | Description                                                                                                         |
| --------------------- | --------- | ------------------ | ------------------------------------------------------------------------------------------------------------------- |
| original_household_id | text      |                    | Value to uniquely identify the household                                                                            |
| survey_id             | text      |                    | which survey this data is from e.g. 'IHS3'.                                                                         |
| latitude              | numeric   |                    | "Latitude indicating where this household is located."                                                              |
| longitude             | numeric   |                    | "Longitude indicating where this household is located."                                                             |
| urbanity              | text      | "urban,rural,null" | Whether this household is located in an urban or rural area                                                         |
| household_expenditure | numeric   |                    | How much money this household spends per month in local currency                                                    |
| wealth_quintile       | integer   | "1,2,3,4,5"        | "In what quintile of househol wealth this household is (5=richest, 1=poorest)"                                      |
| altitude_in_metres    | numeric   |                    | The altitude of the household above sealevel in metres. Used to adjust hemoglobin levels when assessing deficiency. |
| interview_date        | date      | YYYY-MM-DD         | The date when the household was interviewed/data was collected                                                      |

### household consumption

| header                | Values/Format                          | description                                                                                                           |
| --------------------- | -------------------------------------- | --------------------------------------------------------------------------------------------------------------------- |
| household_original_id |                                        | The original id of the household that consumed the food item                                                          |
| food_genus_id         |                                        | The food_genus id of the fooditem that was consumed                                                                   |
| food_genus_confidence | [ 'High' , 'Medium', 'Low']            | How confident we are in matching this food to the corresponding food_genus entry                                      |
| original_food_name    |                                        | the original food name, as given by the consumption survey                                                            |
| source_of_food        | ['own production', 'bought', 'gifted'] | From where the household obtained the food; if they grew it themselves, bought it at market, or had it gifted to them |
| date_consumed         | YYYY-MM-DD                             | The date when the fooditem was consumed                                                                               |
| amount_consumed_in_g  |                                        | How much of the fooditem was consumed on average per day, in grams                                                    |

### household member

| Column Header         | Data Type | Values/Format                              | Description                                                              |
| --------------------- | --------- | ------------------------------------------ | ------------------------------------------------------------------------ |
| household_original_id | text      |                                            | An identifier to indicate the household that this person belongs to.     |
| person_id             | text      |                                            | Unique identifier for the person                                         |
| sex                   | text      | 'm', 'f'                                   | Whether the household member is male or female                           |
| education_level       | text      | 'none', 'primary', 'secondary', 'tertiary' | The highest level of education achieved by this person.                  |
| literacy              | text      | tba                                        | Literacy level of this person                                            |
| weight_in_kg          | number    |                                            | weight of the person in kilograms                                        |
| height_in_cm          | number    |                                            | height of the person in centimetres                                      |
| age_in_months         | integer   |                                            | The age of the person at the time of the survey                          |
| is_breastfed          | boolean   | "0,1,null"                                 | "Whether the child is being breastfed; ""true"" indicates that they are" |
| is_lactating          | boolean   | "0,1,null"                                 | "Whether this woman is lactating; ""true"" indicates that she is"        |
| is_pregnant           | boolean   | "0,1,null"                                 | "Whether this woman is pregnant; ""true"" indicates that she is"         |
| is_smoker             | boolean   | "0,1,null"                                 | Whether this person smokes tobacco                                       |
| had_illness           | boolean   | "0,1,null"                                 | Whether this person has been ill in the last two weeks                   |
| had_malaria           | boolean   | "0,1,null"                                 | Whether this person has had malaria in the last two weeks                |
| had_diarrhoea         | boolean   | "0,1,null"                                 | Whether this person has had diarrhoea in the last two weeks              |
| survey_cluster        | integer   |                                            | The surveying cluster used for selecting this individual                 |
| survey_strata         | integer   |                                            | The surveying strata used for selecting this individual                  |
| survey_weight         | integer   |                                            | The surveying weight used for selecting this individual                  |

### household member consumption

| header                | description                                                                                                                                                         |
| --------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| household_member_id   | The id of the household member that consumed the food item                                                                                                          |
| food_genus_id         | The food_genus id of the fooditem that was consumed                                                                                                                 |
| food_genus_confidence | How confident we are in matching this food to the corresponding food_genus entry                                                                                    |
| source_of_food        | From where the household member obtained the food; if they grew it themselves, bought it at market, or had it gifted to them ['own production', 'bought', 'gifted'] |
| date_consumed         | The date when the fooditem was consumed                                                                                                                             |
| amount_consumed_in_g  | How much of the fooditem was consumed, in grams                                                                                                                     |

### food composition table citations

citation of the journal article where that food composition for that particular food item was taken from.

| field                | description |
| -------------------- | ----------- |
| citation_name        |             |
| citation_original_id |             |
| citation_author      |             |
| citation_publication |             |
| citation_isbn        |             |
| citation_notes       |             |
