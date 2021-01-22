CREATE TABLE IMPACT_FOOD_AVAILABILITY (
	ssp                 		text REFERENCES IMPACT_SCENARIO (ID)
	, comdty            		text REFERENCES IMPACT_COMMODITY (ID)
	, cty       				text REFERENCES COUNTRY (ID)
	, yr          				smallint
	, percapfoodavailability	numeric(20,10)
	, calcium					numeric(20,10)
	, folate					numeric(20,10)
	, iron						numeric(20,10)
	, magnesium					numeric(20,10)
	, niacin					numeric(20,10)
	, phosphorus				numeric(20,10)
	, potassium					numeric(20,10)
	, protein					numeric(20,10)
	, riboflavin				numeric(20,10)
	, thiamin					numeric(20,10)
	, vit_a						numeric(20,10)
	, vit_b6					numeric(20,10)
	, vit_c						numeric(20,10)
	, zinc						numeric(20,10)
);
COMMENT ON TABLE IMPACT_FOOD_AVAILABILITY IS 'Food availability and nutrient values reported by the IMPACT model';
COMMENT on column impact_food_availability.comdty IS 'Commodity';
COMMENT on column impact_food_availability.cty IS 'Country';
COMMENT on column impact_food_availability.yr IS 'Year';
COMMENT on column impact_food_availability.ssp IS 'Socioeconomic scenario';
COMMENT on column impact_food_availability.percapfoodavailability IS 'Per capita food availability (kg, per person per year)';
COMMENT on column impact_food_availability.calcium IS 'Calcium (mg, per person per year)';
COMMENT on column impact_food_availability.folate IS 'Folate (mcg, per person per year)';
COMMENT on column impact_food_availability.iron IS 'Iron (mg, per person per year)';
COMMENT on column impact_food_availability.magnesium IS 'Magnesium (mg, per person per year)';
COMMENT on column impact_food_availability.niacin IS 'Niacin (mg, per person per year)';
COMMENT on column impact_food_availability.phosphorus IS 'Phosphorus (mg, per person per year)';
COMMENT on column impact_food_availability.potassium IS 'Potassium (g, per person per year)';
COMMENT on column impact_food_availability.protein IS 'Protein (g, per person per year)';
COMMENT on column impact_food_availability.riboflavin IS 'Riboflavin (mg, per person per year)';
COMMENT on column impact_food_availability.thiamin IS 'Thiamine (mg, per person per year)';
COMMENT on column impact_food_availability.vit_a IS 'Vitamin A (mcg RAE, per person per year)';
COMMENT on column impact_food_availability.vit_b6 IS 'Vitamin B6 (mg, per person per year)';
COMMENT on column impact_food_availability.vit_c IS 'Vitamin C (mg, per person per year)';
COMMENT on column impact_food_availability.zinc IS 'Zinc (mg, per person per year)';