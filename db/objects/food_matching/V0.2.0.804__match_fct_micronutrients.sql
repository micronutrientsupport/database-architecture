CREATE OR REPLACE FUNCTION match_fct_micronutrients()
RETURNS void
LANGUAGE plpgsql
AS
$code$

declare

	fct_id int;
	fooditem_rec fooditem%ROWTYPE;
	mn_rec record;
	consumption_rec record;
	the_household_id int;
	fct_list integer[];
	fct_list_rec record;
	have_found_fct_entry boolean;
	mn_map jsonb;
	mn_names text[];
	mn_names_orig text[];
	mn_val numeric;
	mn text;
	mn_field text;

BEGIN

	-- populate household_fct_list table
	RAISE NOTICE 'Populating household_fct_list table...%', timeofday();

	insert into household_fct_list (
		household_id,
		fct_list,
		aggregation_area_id,
		aggregation_area_name,
		aggregation_area_type
	)

	insert into household_fct_list (
		household_id,
		fct_list,
		aggregation_area_id,
		aggregation_area_name,
		aggregation_area_type
	)
	select
		household.id,
		ARRAY(SELECT * FROM get_fct_list(location)) -- TODO: this is inserting an array into a text column. Should we change the table column datatype?
		, aggregation_area.id
		, aggregation_area.name
		, aggregation_area.type
	from household 
		JOIN aggregation_area ON st_contains(aggregation_area.geometry, household.location)
  		WHERE aggregation_area.type = 'admin'::text AND aggregation_area.admin_level = 1;

	-- populate household_fct_list table
	RAISE NOTICE 'Populating country_fct_list table...%', timeofday();

	insert into country_fct_list (
		id,
		fct_list
	)
	select
		id,
		ARRAY(SELECT * FROM get_fct_list(geometry))
	from country_consumption_source;

	-- create distinct_fct_list table
	RAISE NOTICE 'Populating distinct_fct_list table...%', timeofday();

	INSERT INTO	distinct_fct_list (fct_list)
	(
		SELECT DISTINCT h.fct_list
		FROM household_fct_list h
	)
	UNION
	(
		SELECT DISTINCT c.fct_list
		FROM country_fct_list c
	);


	-- populate intermediate table
	RAISE NOTICE 'Update references in household_fct_list table...%', timeofday();

	update household_fct_list hc
	set fct_list_id = new.fct_list_id
	from (
			select household_id,
				hcl.fct_list,
				dfl.id as fct_list_id
			from household_fct_list hcl
				join distinct_fct_list dfl on hcl.fct_list = dfl.fct_list
		) new
	where hc.household_id = new.household_id;

	-- populate intermediate table
	RAISE NOTICE 'Update references in country_fct_list table...%', timeofday();

	update country_fct_list cc
	set fct_list_id = new.fct_list_id
	from (
		select cfl.id, cfl.fct_list, dfl.id as fct_list_id
		from country_fct_list cfl
		join distinct_fct_list dfl
		on cfl.fct_list = dfl.fct_list
	) new
	where cc.id = new.id;


	-- populate intermediate table
	RAISE NOTICE 'Populating fct_list_food_compostion table...%', timeofday();

	SELECT
		json_object_agg(id, fooditem_column) INTO mn_map
	FROM
		micronutrient
	WHERE
		is_user_visible = TRUE;


	SELECT
		array_agg(id) INTO mn_names_orig
	FROM
		micronutrient
	WHERE
		is_user_visible = TRUE;


	FOR fct_list_rec IN
		SELECT
			l.fct_list,
			l.id AS fct_list_id,
			f.food_genus_id
		FROM
			distinct_fct_list l
			CROSS JOIN (
				SELECT
					DISTINCT food_genus_id
				FROM
					fooditem
				WHERE
					food_genus_id IS NOT NULL
			) f
	LOOP
	   	mn_names:= mn_names_orig;

	 	FOREACH fct_id IN ARRAY fct_list_rec.fct_list::int[]
		LOOP
			execute '
				SELECT *
				FROM fooditem
				WHERE
					fct_source_id = ' || fct_id || '
					AND food_genus_id = ''' || fct_list_rec.food_genus_id || '''
				;'
			INTO fooditem_rec;

			IF fooditem_rec.original_food_name IS NOT NULL THEN
			  	FOREACH mn IN array mn_names
			  	LOOP
				  	mn_field := mn_map->mn;

				  	--ensure we use lower case for mn_field
				  	SELECT lower(mn_field) into mn_field;

				  	-- try to get the mn value for the given mn
					EXECUTE 'SELECT ($1).' || mn_field USING fooditem_rec INTO  mn_val;

				  	IF mn_val IS NOT NULL THEN
--			      		raise notice 'Found: MN=%, Val=%', mn, mn_val;
						insert into fct_list_food_composition
						(
							fct_list_id,
							food_genus_id,
							micronutrient_id,
							micronutrient_composition,
							fct_used
						)
						values
						(
							fct_list_rec.fct_list_id,
							fct_list_rec.food_genus_id,
							mn,
							mn_val,
							fct_id
						);

				  		-- remove mn from the array of mns
						-- TODO: can this be done with array_remove()?
				  		execute '
							WITH mns AS (
								SELECT unnest($1) as mn_unnest
								EXCEPT
								SELECT ''' || mn || '''
							)
				  			SELECT array_agg(mn_unnest)
							FROM mns' using mn_names into mn_names;
				  	END IF;

			  		IF mn_names IS NULL THEN
						--raise notice 'ALL DONE!';
						EXIT;
					END IF;
			  	END LOOP;

	  			IF mn_names IS NULL THEN
					--raise notice 'ALL DONE2!';
					exit;
				END IF;
				-- if we find one, we can exit
				--exit;
			ELSE
--        		raise notice 'Record not found for % in FCT % (% outstanding MNs)', fct_list_rec.food_genus_id, fct_id, array_length(mn_names,1);
			END IF;
		END LOOP;

--		raise notice 'Outstanding MNs = %', array_length(mn_names,1);

		if array_length(mn_names,1) > 0 then
			foreach mn in array mn_names
			loop
				insert into fct_list_food_composition
				(
					fct_list_id,
					food_genus_id,
					micronutrient_id,
					micronutrient_composition,
					fct_used
				)
				values
				(
					fct_list_rec.fct_list_id,
					fct_list_rec.food_genus_id,
					mn,
					null,
					null
				);

			end loop;
		end if;

	end loop;

	-- populate final results table
 	-- RAISE NOTICE 'Populating final results table...%', timeofday();

	-- INSERT INTO consumption_composition_match
	-- 	(food_genus_id,
	-- 	household_id,
	-- 	household_member_id,
	-- 	fct_list_id,
	-- 	micronutrient_id,
	-- 	micronutrient_composition,
	-- 	fct_used)
	-- select
	-- 	ci.food_genus_id,
	-- 	ci.household_id,
	-- 	ci.household_member_id,
	-- 	ccm.fct_list_id,
	-- 	ccm.micronutrient_id,
	-- 	ccm.micronutrient_composition,
	-- 	ccm.fct_used
	-- from
	-- 	(
	-- 	select
	-- 			row_number() over () as rownum
	-- 			, consumption_items.*
	-- 		from
	-- 		(
	-- 		SELECT
	-- 			 hc.food_genus_id
	-- 			 , h.id AS household_id
	-- 			 , null as household_member_id
	-- 			 , f.fct_list_id
	-- 			FROM
	-- 			household_consumption hc
	-- 			join household h
	-- 			on hc.household_id = h.id
	-- 			JOIN household_fct_list f
	-- 			ON h.id = f.household_id
	-- 		union all
	-- 		SELECT
	-- 		   hmc.food_genus_id
	-- 		 , hmc.id AS household_id
  	-- 		 , hhm.id AS household_member_id
	-- 		 , ff.fct_list_id
	-- 		FROM
	-- 		household_member_consumption hmc
	-- 		join household_member hhm
	-- 		on hhm.id = hmc.household_member_id
	-- 		join household hh
	-- 		on hhm.household_id = hh.id
	-- 		JOIN household_fct_list ff
	-- 		ON hh.id = ff.household_id
	-- 		 ) as consumption_items
	-- 	) ci
	-- 	join fct_list_food_composition ccm
	-- 	on ci.fct_list_id = ccm.fct_list_id
	-- 	and ci.food_genus_id = ccm.food_genus_id;

RAISE NOTICE 'End....%', timeofday();

end;

$code$
;



