CREATE TABLE micronutrients (
	id                  text primary key
	, name              text
	, unit              text
	, description       text
	, category          text CHECK (category IN ('vitamin', 'mineral', 'other'))
	, fooditem_column	text
	, in_impact			boolean
	, impact_column		text

);
COMMENT ON TABLE micronutrients IS 'Collection of micronutrients for user selection of MN interest';
COMMENT on column micronutrients.category is 'broad groupings of Vitamins, Minerals and Other';
COMMENT on column micronutrients.in_impact is 'Boolean value representing whether micronutrient is included in IMPACT model output';
COMMENT on column micronutrients.impact_column is 'Column name for IMPACT model output relating to this MN';