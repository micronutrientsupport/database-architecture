CREATE TABLE micronutrients (
	id                  text primary key
	, name              text
	, unit              text
	, description       text
	, category          text CHECK (category IN ('vitamin', 'mineral', 'other'))
	, fooditem_column	text
);
COMMENT ON TABLE micronutrients IS 'Collection of micronutrients for user selection of MN interest';
COMMENT on column micronutrients.category is 'broad groupings of Vitamins, Minerals and Other';