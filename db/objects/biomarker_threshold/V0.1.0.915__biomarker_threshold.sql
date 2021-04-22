CREATE TABLE biomarker_threshold
(threshold_id integer primary key GENERATED BY DEFAULT AS identity,
biomarker_id text REFERENCES biomarker (id),
group_id text REFERENCES biomarker_group (group_id),
gender text CHECK (gender IN ('M','F','both')),
age_category text CHECK (age_category IN ('5 to 10','11 to 14','all')),
conditional_info text,
threshold_type text,
source text,
matrix text CHECK (matrix IN ('Plasma or Serum','Whole blood','Red blood cell')),
threshold numeric
);

COMMENT ON TABLE biomarker_threshold IS 'Table of thresholds below which deficiency is indicated for the assigned biomarker and demographic';
COMMENT on column biomarker_threshold.threshold_id is 'The threshold primary key identifier';
COMMENT on column biomarker_threshold.biomarker_id is 'Foreign key reference to the biomarker table';
COMMENT on column biomarker_threshold.group_id is 'Foreign key reference to the group table';
COMMENT on column biomarker_threshold.gender is 'Gender for which the threshold applies';
COMMENT on column biomarker_threshold.age_category is 'For children, the age category for which the threshold applies';
COMMENT on column biomarker_threshold.conditional_info is 'The condition(s) on which the threshold is applied';
COMMENT on column biomarker_threshold.threshold_type is 'Whether a lower or upper biologically desirable MN threshold';
COMMENT on column biomarker_threshold.source is 'Literature source from which data is derived';
COMMENT on column biomarker_threshold.matrix is 'Biomarker sample matrix';
COMMENT on column biomarker_threshold.threshold is 'Value of the threshold';


