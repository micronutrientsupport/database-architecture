CREATE TABLE household_member (
	id                     integer primary key GENERATED BY DEFAULT AS IDENTITY
    , household_id         integer   references household (id)
    , sex                  text
    , age                  integer
    , smoker_YN            text
    , breastfeeding_status text
);
COMMENT ON TABLE household_member IS '';
COMMENT ON COLUMN household_member.sex IS '';
Comment on COLUMN household_member.smoker_YN IS 'Whether the person smokes';
