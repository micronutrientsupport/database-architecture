CREATE TABLE biomarker (
	id                  text primary key
	, name              text
	, unit              text
	, description       text
    , sampled_matter    text
	-- , category          text CHECK (category IN ('vitamin', 'mineral', 'other'))
	-- , fooditem_column	text
	-- , is_in_impact	    boolean
	-- , impact_column		text
	-- , is_biomarker      boolean
	-- , is_diet           boolean

);
COMMENT ON TABLE biomarker IS 'List of biomarkers that can be processed by the project. Compare the micronutrient table.';
COMMENT on column biomarker.name is 'The name of the biomarker';
COMMENT on column biomarker.unit is 'The the units that biomarker is measured in';
COMMENT on column biomarker.description is 'Further description of the biomarker';
COMMENT on column biomarker.sampled_matter is 'Whether the biomarker is sampls from blood, urine, or breastmilk';



