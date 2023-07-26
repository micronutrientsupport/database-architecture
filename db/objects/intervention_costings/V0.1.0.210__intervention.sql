CREATE TABLE intervention(
    id                           uuid  PRIMARY KEY NOT NULL DEFAULT gen_random_uuid(),
    intervention_name            text,
    description                  text,
    country_id                   text       REFERENCES country(id),
    app_user_id                  text       REFERENCES app_user(id),
    data_citation_id             integer    REFERENCES data_citation(id),
    focus_micronutrient          text       REFERENCES micronutrient(id),
    focus_geography              text       REFERENCES aggregation_area(gid),
    food_vehicle_id              integer    REFERENCES food_vehicle(id),
    fortification_type_id        text       REFERENCES fortification_type(id),
    program_status               text,
	file_name                    text,
    base_year                    integer,
    is_premade                   boolean,
    is_locked                    boolean,
    parent_intervention          uuid    REFERENCES intervention(id),
    last_edited                  timestamp
)
;
COMMENT ON TABLE intervention IS 'Food fortification interventions programs. An intervention is a program to fortify a food vehicle (e.g. wheat flour) with a premix of fortificants (e.g. Vitamin C powder and iron powder) in order to increase the micronutrient content of the food.';
COMMENT ON COLUMN intervention.intervention_name     IS 'The name of the intervention, as displayed in any headings or dropdown menus in the UI';
COMMENT ON COLUMN intervention.description           IS 'A brief description of the intervention; useful for telling users about premade interventions and for letting users make notes on their own user-created interventions';
COMMENT ON COLUMN intervention.country_id            IS '3-letter country code for the country to which the intervention applies';
COMMENT ON COLUMN intervention.app_user_id           IS 'The user who created this intervention';
COMMENT ON COLUMN intervention.focus_micronutrient   IS 'The focus micronutrient the intervention is concerend about';
COMMENT ON COLUMN intervention.focus_geography       IS 'The focus geography the intervention is evaluated at for effectiveness modelling';
COMMENT ON COLUMN intervention.data_citation_id      IS 'The citation data for the publication or organisation which provided the data underlying the costings analysys';
COMMENT ON COLUMN intervention.food_vehicle_id       IS 'Which food vehicle this interventions is concerned about';
COMMENT ON COLUMN intervention.fortification_type_id IS 'whether the intervention is Large-Scale Food Fortificaion (LSFF), biofortification (BF), or agro-fortification (AF)';
COMMENT ON COLUMN intervention.program_status        IS 'A description of the stage the program is in e.g. whether the intevention is already ongoing, or how many varieties of a bioortified crop have been released';
COMMENT ON COLUMN intervention.file_name             IS 'If the data is imported, what the name of the imported file is';
COMMENT ON COLUMN intervention.base_year             IS 'the actual year (Common Era) from when the intervention program is to start its calculations, e.g. 2026. As opposed to "year 3".';
COMMENT ON COLUMN intervention.is_premade            IS 'Whether this intervention is pre-created by professionals, or whether this is an intervention where an end-user has customised some values';
COMMENT ON COLUMN intervention.is_locked             IS 'Whether this intervention is locked against editing (read-only)';
COMMENT ON COLUMN intervention.parent_intervention   IS 'If this intervention has been created by a user, this shows the id of the intervetnion used as a template.';
COMMENT ON COLUMN intervention.last_edited           IS 'Timestamp of the last edit made to this intervention or its corresponding data';




