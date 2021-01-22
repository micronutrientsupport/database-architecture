CREATE TABLE IMPACT_COMMODITY (
	id                 text primary key
	, name              text
);
COMMENT ON TABLE impact_commodity IS 'List of commodities reported on by the IMPACT model';
COMMENT on column impact_commodity.name is 'Commodity name';