
--drop function to_json_null(key_name text, value text);

CREATE OR REPLACE FUNCTION to_json_null(key_name text, value numeric)
RETURNS jsonb 
AS 
$$
declare 

test_jsonb text;

begin
	if value is null then 
		test_jsonb := '{"' || key_name || '":null}';
	else
		test_jsonb := '{"' || key_name || '":' || value || '}';
	end if;

return test_jsonb::jsonb;

end;
$$ LANGUAGE plpgsql;