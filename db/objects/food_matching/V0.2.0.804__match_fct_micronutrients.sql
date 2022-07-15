CREATE OR REPLACE FUNCTION match_fct_micronutrients()
RETURNS void
LANGUAGE plpgsql
AS
$code$

declare

fct_id int;
fooditem_rec record;
mn_rec record;
consumption_rec record;
the_household_id int;
fct_list integer[];
fct_list_rec record;
have_found_fct_entry boolean;
            
BEGIN
	


		RAISE NOTICE 'Creating distinct_fct_list table...';
	-- drop table if exists distinct_fct_list cascade;
	-- CREATE TABLE distinct_fct_list (
	-- 	id              SERIAL PRIMARY KEY,
	-- 	fct_list           text
	-- );
	
	-- drop and recreate create intermediate table
	RAISE NOTICE 'Creating fct_list_food_compostion table...';
	-- DROP TABLE IF EXISTS fct_list_food_composition cascade; 
	
	-- CREATE TABLE fct_list_food_composition (
	--     id 								integer primary key GENERATED BY DEFAULT AS identity,
	--     fct_list_id 					integer,
	--     food_genus_id 					text,
	--     micronutrient_id               	text,
	--     micronutrient_composition      	numeric,
	--     fooditem_column					text,
	--     fct_used            			integer,
	-- 	CONSTRAINT fct_list_food_composition_uk1 UNIQUE (fct_list_id, food_genus_id, micronutrient_id),
	-- 	   CONSTRAINT fct_list_food_composition_fk1
    --   FOREIGN KEY(fct_list_id) 
	--   REFERENCES distinct_fct_list(id)
	-- );
	

	-- drop and recreate household_fct_list table 
	-- RAISE NOTICE 'Creating country_fct_list table...';
	-- DROP TABLE IF EXISTS country_fct_list;
	
	-- create table country_fct_list
	-- (
	-- id 	integer primary key references country_consumption_source (id),
	-- fct_list 		text
	-- )
	-- ;

	-- drop and recreate household_fct_list table 
	RAISE NOTICE 'Creating household_fct_list table...';
	
	DROP TABLE IF EXISTS household_fct_list;
	
	create table household_fct_list
	(
	household_id 	integer primary key references household (id),
	fct_list 		text
	)
	;
	
	-- populate household_fct_list table 
	RAISE NOTICE 'Populating household_fct_list table...';
	
	insert into household_fct_list
		(household_id, 
		fct_list)
	select 
		id, 
		ARRAY(SELECT * FROM get_fct_list(location))
	from household; 

		-- populate household_fct_list table 
	RAISE NOTICE 'Populating country_fct_list table...';
	
	insert into country_fct_list
		(id, 
		fct_list)
	select 
		id, 
		ARRAY(SELECT * FROM get_fct_list(geometry))
	from country_consumption_source; 

	-- create distinct_fct_list table
	RAISE NOTICE 'Populating distinct_fct_list table...';

	insert into distinct_fct_list (fct_list)
	(select 
		distinct h.fct_list 
	from
		household_fct_list h)
		union
	(select 
		distinct c.fct_list 
	from
		country_fct_list c);	


	-- populate intermediate table
	RAISE NOTICE 'Update references in household_fct_list table...';
	ALTER TABLE household_fct_list
	ADD COLUMN fct_list_id integer;
	alter table household_fct_list 
	ADD FOREIGN KEY (fct_list_id) REFERENCES distinct_fct_list(id);

	update household_fct_list hc
	set fct_list_id = new.fct_list_id 
	from (
		select household_id, hcl.fct_list, dfl.id as fct_list_id
		from household_fct_list hcl 
		join distinct_fct_list dfl 
		on hcl.fct_list = dfl.fct_list
	) new
	where hc.household_id = new.household_id;

	-- populate intermediate table
	RAISE NOTICE 'Update references in country_fct_list table...';
	-- ALTER TABLE country_fct_list
	-- ADD COLUMN fct_list_id integer;
	-- alter table country_fct_list 
	-- ADD FOREIGN KEY (fct_list_id) REFERENCES distinct_fct_list(id);

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
	RAISE NOTICE 'Populating fct_list_food_compostion table...';
    for fct_list_rec in 
    	    	select 
				l.fct_list,
				l.id as fct_list_id,
				f.food_genus_id,
				m.id as micronutrient_id,
				m.name as micronutrient,
				m.fooditem_column 
				from
				distinct_fct_list l
				cross join
					(select distinct food_genus_id from 
					fooditem
					where 
					food_genus_id is not null) f
				cross join
				micronutrient m 

	 loop
	 
       	have_found_fct_entry := FALSE; 
      
	 	FOREACH fct_id IN ARRAY fct_list_rec.fct_list::int[] loop
        	
	        	execute 'select original_food_name, 
				''' || fct_list_rec.micronutrient || ''' as micronutrient,
				' || fct_list_rec.fooditem_column || ' as thevalue
	        	from fooditem
	        	where 
	        	fct_source_id = ' || fct_id || '
	        	and food_genus_id = ''' || fct_list_rec.food_genus_id || '''
				and ' || fct_list_rec.fooditem_column || ' is not null'
				into fooditem_rec;
	        	
				if fooditem_rec.micronutrient is not null THEN
                
                    have_found_fct_entry := TRUE;

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
                        fct_list_rec.micronutrient_id,
                        fooditem_rec.thevalue,
                        fct_id
                    );
                    
                    -- if we find one, we can exit
                    exit;

                end if;

            end loop;
            
            IF NOT have_found_fct_entry THEN
            
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
                        fct_list_rec.micronutrient_id,
                        null,
                        null
                );
            END IF;
    
    end loop;
   
-- 	drop table if exists consumption_composition_match cascade;
-- 	create table consumption_composition_match
-- (
--     id                          integer primary key GENERATED BY DEFAULT AS identity,
--     food_genus_id               text,
--     household_id                integer,
--     household_member_id         integer,
--     fct_list_id                    integer,
--     micronutrient_id            text,
--     micronutrient_composition   numeric,
--     fct_used                    integer,
-- 	 CONSTRAINT consumption_composition_match_fk1
--       FOREIGN KEY(fct_list_id) 
-- 	  REFERENCES distinct_fct_list(id)
-- );
    
	
	-- populate final results table
 	RAISE NOTICE 'Populating final results table...';
	
	INSERT INTO consumption_composition_match
        (food_genus_id,
        household_id,
        household_member_id,
        fct_list_id,
        micronutrient_id,
        micronutrient_composition,
        fct_used)
	select 
        ci.food_genus_id,
        ci.household_id,
        ci.household_member_id,
        ccm.fct_list_id,
        ccm.micronutrient_id,
        ccm.micronutrient_composition,
        ccm.fct_used
	from 
		(
		select 
	    		row_number() over () as rownum
	    		, consumption_items.*
	    	from 
	    	(
	    	SELECT
	             hc.food_genus_id
	             , h.id AS household_id
	             , null as household_member_id
	             , f.fct_list_id
	            FROM 
	            household_consumption hc
	            join household h
	            on hc.household_id = h.id
	            JOIN household_fct_list f
	            ON h.id = f.household_id
	            
	        union all
            
        	SELECT 
               hmc.food_genus_id
             , hmc.id AS household_id
  			 , hhm.id AS household_member_id
             , ff.fct_list_id
            FROM 
            household_member_consumption hmc
            join household_member hhm 
            on hhm.id = hmc.household_member_id 
            join household hh
            on hhm.household_id = hh.id
            JOIN household_fct_list ff
	        ON hh.id = ff.household_id
	         ) as consumption_items
	    ) ci
		join fct_list_food_composition ccm 
		on ci.fct_list_id = ccm.fct_list_id
		and ci.food_genus_id = ccm.food_genus_id; 

RAISE NOTICE 'End.';
	
end;   
         
$code$
;

         
         
       