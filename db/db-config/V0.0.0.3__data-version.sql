CREATE TABLE data_version (
	date                date
    , version           text
    , type              text CHECK (type IN ('schema', 'seed'))
);
COMMENT ON TABLE data_version IS 'Record of the semvar version of the DB schema and seed data';
COMMENT on column data_version.date is 'Date for version release';
COMMENT on column data_version.version is 'The semver version number';
COMMENT on column data_version.type is 'What the version number refers to - schame or seed data';
