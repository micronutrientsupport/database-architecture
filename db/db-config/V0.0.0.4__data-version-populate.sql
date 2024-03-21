with v as 
(select '1.5.1' as version) -- x-release-please-version

INSERT INTO data_version (date, type, version) values (current_timestamp, 'schema', (select version from v));
