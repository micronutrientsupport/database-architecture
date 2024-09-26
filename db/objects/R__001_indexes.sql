CREATE INDEX IF NOT EXISTS idx_household_consumption_food_genus_id ON household_consumption (food_genus_id);

CREATE INDEX IF NOT EXISTS idx_household_id ON household (id);

CREATE INDEX IF NOT EXISTS idx_household_fct_list_household_id ON household_fct_list (household_id);

CREATE INDEX IF NOT EXISTS idx_fct_list_food_composition_fct_list_id ON fct_list_food_composition (fct_list_id);
CREATE INDEX IF NOT EXISTS idx_fct_list_food_composition_food_genus_id ON fct_list_food_composition (food_genus_id);


CREATE INDEX IF NOT EXISTS idx_food_genus_id ON food_genus (id);
CREATE INDEX IF NOT EXISTS idx_food_group_id ON food_group (id);

CREATE INDEX IF NOT EXISTS idx_food_genus_food_group_id ON food_genus (food_group_id);

-- Index for household_consumption.household_id (join with household)
CREATE INDEX IF NOT EXISTS idx_household_consumption_household_id ON household_consumption(household_id);

-- Index for household_fct_list.household_id (join with household)
CREATE INDEX IF NOT EXISTS idx_household_fct_list_household_id ON household_fct_list(household_id);

-- Index for fct_list_food_composition.fct_list_id (join with household_fct_list)
CREATE INDEX IF NOT EXISTS idx_fct_list_food_composition_fct_list_id ON fct_list_food_composition(fct_list_id);

-- Index for fct_list_food_composition.food_genus_id (join with household_consumption)
CREATE INDEX IF NOT EXISTS idx_fct_list_food_composition_food_genus_id ON fct_list_food_composition(food_genus_id);

-- Index for household.interview_date (for filtering by month)
CREATE INDEX IF NOT EXISTS idx_household_interview_date ON household(EXTRACT(MONTH FROM interview_date));

-- Index for fct_list_food_composition.micronutrient_composition (filtering out NULL values)
CREATE INDEX IF NOT EXISTS idx_fct_list_food_composition_mn_composition ON fct_list_food_composition(micronutrient_composition);

-- Index for household_consumption.amount_consumed_in_g (filtering out NULL values)
CREATE INDEX IF NOT EXISTS idx_household_consumption_amount_consumed_in_g ON household_consumption(amount_consumed_in_g);
