CREATE OR REPLACE FUNCTION check_intervention_lock_state()
  RETURNS TRIGGER AS 
  
  $$
  DECLARE
   _lock_state   boolean;  -- lock_state of new intervention
   _intervention_id numeric;
begin
	
  SELECT new.intervention_id into _intervention_id;
	
  execute format('SELECT is_locked from "%s".intervention WHERE id = %s',TG_TABLE_SCHEMA, _intervention_id)
   INTO _lock_state;

  IF _lock_state
  THEN
    RAISE EXCEPTION 'Intervention [id:%] is locked!',
    NEW.intervention_id;
  END IF;
  RETURN NEW;
END;
$$ LANGUAGE plpgsql;

CREATE TRIGGER check_lock_state 
BEFORE UPDATE ON intervention_data 
FOR EACH ROW EXECUTE PROCEDURE check_intervention_lock_state();