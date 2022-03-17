CREATE TABLE micronutrient (
	id                  text primary key
	, name              text
	, unit              text
	, description       text
	, category          text CHECK (category IN ('vitamin', 'mineral', 'other'))
	, fooditem_column	text
	, is_in_impact	    boolean
	, impact_column		text
	, is_biomarker      boolean
	, is_diet           boolean
	, is_user_visible   boolean

);
COMMENT ON TABLE micronutrient IS 'Collection of micronutrients for user selection of MN interest';
COMMENT on column micronutrient.category is 'broad groupings of Vitamins, Minerals and Other';
COMMENT on column micronutrient.is_in_impact is 'Boolean value representing whether micronutrient is included in IMPACT model output';
COMMENT on column micronutrient.impact_column is 'Column name for IMPACT model output relating to this MN';
COMMENT on column micronutrient.is_biomarker is 'Boolean value for whether this micronutrient is measurable via biomarkers';
COMMENT on column micronutrient.is_diet is 'Boolean value for whether this micronutrient is measurable via diet data';
COMMENT on column micronutrient.is_user_visible is 'Boolean value for whether this micronutrient is visible to end-users in e.g. dropdown menus';
