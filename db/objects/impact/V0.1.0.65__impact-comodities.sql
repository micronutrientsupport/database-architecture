CREATE TABLE IMPACT_COMMODITY (
	id                 text primary key
	, name              text
	, food_group        integer REFERENCES FOOD_GROUP (ID)
);
COMMENT ON TABLE impact_commodity IS 'List of commodities reported on by the IMPACT model';
COMMENT on column impact_commodity.name is 'Commodity name';
COMMENT on column impact_commodity.food_group is 'Food group incorporating the comodity';