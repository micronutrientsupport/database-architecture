
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

comment on function to_json_null is 'This function takes a json key name and proposed value and if the value is null, converts it into a proper json null otherwise it returns the value both as json in a key-value pair, ready to append to another json object without rendering the whole thing null.';