CREATE TABLE biomarker_group (
group_id text primary key,
supra_group text CHECK (supra_group IN ('Adult','Children')),
group_name text,
is_default	    boolean);

COMMENT ON TABLE biomarker_group IS 'Table of groups used to define sections of a sampled population based on age and other criteria for use in selecting thresholds for assessingbiomarker deficiency.';
COMMENT on column biomarker_group.group_id is 'The group primary key identifier';
COMMENT on column biomarker_group.supra_group is 'Whether group is of adults or children';
COMMENT on column biomarker_group.group_name is 'Name of the group';
COMMENT on column biomarker_group.is_default is 'Is the group the default for selection';
