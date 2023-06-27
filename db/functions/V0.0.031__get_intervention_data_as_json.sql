CREATE or replace function get_intervention_data_as_json(int_id integer) returns jsonb
AS
$$
DECLARE
	cells_all jsonb;
	data_rec record;
BEGIN
	cells_all := '{"foo": null}';

	FOR data_rec IN
		SELECT *
		FROM intervention_data
		WHERE intervention_id = int_id
	LOOP
		cells_all := cells_all || jsonb_build_object(
			data_rec.row_index || '_0', data_rec.year_0,
			data_rec.row_index || '_1', data_rec.year_1,
			data_rec.row_index || '_2', data_rec.year_2,
			data_rec.row_index || '_3', data_rec.year_3,
			data_rec.row_index || '_4', data_rec.year_4,
			data_rec.row_index || '_5', data_rec.year_5,
			data_rec.row_index || '_6', data_rec.year_6,
			data_rec.row_index || '_7', data_rec.year_7,
			data_rec.row_index || '_8', data_rec.year_8,
			data_rec.row_index || '_9', data_rec.year_9
		);
	END LOOP;

	RETURN cells_all;
END;
$$ LANGUAGE plpgsql;

comment on function get_intervention_data_as_json is 'This funtion takes the intervention costing data from the table columns and converts them into a single json object of key-value pairs for easier reference by the next function which recalculates the values.';
