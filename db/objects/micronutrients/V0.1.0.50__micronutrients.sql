CREATE TYPE mn_category AS ENUM ('Vitamin', 'Mineral', 'Other');
CREATE TABLE micronutrients (
	id         integer primary key
	, name     text
	, category mn_category
);
COMMENT ON TABLE micronutrients IS 'Collection of micronutrients for user selection of MN interest';
COMMENT on column micronutrients.category is 'broad groupings of Vitamins, Minerals and';
