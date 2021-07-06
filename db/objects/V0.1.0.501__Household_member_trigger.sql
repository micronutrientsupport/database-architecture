
CREATE OR REPLACE FUNCTION update_bmi() RETURNS trigger AS $household_member_tg1$
    BEGIN
        
        IF NEW.weight_in_kg is not null
			and NEW.height_in_cm is not null
			and NEW.bmi IS NULL THEN
				NEW.bmi := round((NEW.weight_in_kg/((NEW.height_in_cm/100)*(NEW.height_in_cm/100))),1);
        END IF;
	
		RETURN NEW;
	
    END;
$household_member_tg1$ LANGUAGE plpgsql;


CREATE TRIGGER household_member_tg1 BEFORE insert or update OF weight_in_kg, height_in_cm, bmi
    ON household_member
    FOR EACH ROW
    EXECUTE PROCEDURE update_bmi();
	
