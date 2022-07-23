CREATE OR REPLACE FUNCTION update_intervention_last_edit_timestamp() RETURNS TRIGGER AS $update_ts$
DECLARE
    BEGIN
        --select current_schema() into the_schema;
        --
        -- Update the last_edited field of the intervention table for the intervention
        -- every time a row is updated in the intervention_data table
        --RAISE NOTICE 'UPDATE "%".intervention SET last_edited = ''%'' WHERE id = %;', the_schema, NOW(), NEW.intervention_id;
       EXECUTE 'UPDATE "' || TG_TABLE_SCHEMA || '".intervention SET last_edited = ''' || NOW() || ''' WHERE id = ' || NEW.intervention_id || ';';
        RETURN NULL;
    END;
$update_ts$ LANGUAGE plpgsql;

CREATE TRIGGER intervention_data_update
AFTER UPDATE ON intervention_data
    FOR EACH ROW EXECUTE FUNCTION update_intervention_last_edit_timestamp();