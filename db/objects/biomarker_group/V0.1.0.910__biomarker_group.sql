CREATE TABLE biomarker_group (
group_id text primary key,
supra_group text CHECK (supra_group IN ('Adult','Children')),
group_name text);

COMMENT ON TABLE biomarker_group IS 'Table of age gender and other characteristics groups';
COMMENT on column biomarker_group.group_id is 'The group primary key identifier';
COMMENT on column biomarker_group.supra_group is 'Whether group is of adults or children';
COMMENT on column biomarker_group.group_name is 'Name of the group';
