-- DROP FUNCTION IF exists match_consumption_test();

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
            
begin
	
	DROP TABLE IF EXISTS consumption_compostion_matching;
    CREATE TABLE consumption_compostion_matching (
    fct_list text,
    food_genus_id text,
    mn_id               text,
    mn_composition      NUMERIC,
    fct_used            integer
    );
---------------------------------------------------------------
    for fct_list_rec in 
    	    	select 
				l.fct_list,
				f.food_genus_id,
				m.id as micronutrient_id,
				m.name as micronutrient,
				m.fooditem_column 
				from
				distinct_fct_list l
				cross join
				fooditem f
				cross join
				micronutrient m 
				where f.food_genus_id is not null
				limit 20000
	 loop
	 
	 	RAISE NOTICE 'fct_list_rec: %', fct_list_rec;
	 
       	have_found_fct_entry := FALSE; 
      
	 	FOREACH fct_id IN ARRAY fct_list_rec.fct_list loop
	 	
	 			--RAISE NOTICE 'fct_id: %', fct_id;
        	
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
                
                    --RAISE NOTICE 'inserting value';
                
                    have_found_fct_entry := TRUE;

                    insert into consumption_compostion_matching
                    (
                        fct_list,
    					food_genus_id,
                        mn_id,
                        mn_composition,
                        fct_used
                    )
                    values
                    (
                        fct_list_rec.fct_list,
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
               
            	--RAISE NOTICE 'inserting null';
            
                insert into consumption_compostion_matching
                (
                        fct_list,
    					food_genus_id,
                        mn_id,
                        mn_composition,
                        fct_used
                )
                values
                (
                   		fct_list_rec.fct_list,
                        fct_list_rec.food_genus_id,
                        fct_list_rec.micronutrient_id,
                        null,
                        null
                );
            END IF;
			
        	--end loop;
    
    end loop;

end;       
         
$code$
;

SELECT * FROM 	match_fct_micronutrients();

-- delete from consumption_compostion_matching;

--select * from consumption_compostion_matching; -- 3612

select count(*) from consumption_compostion_matching; 
         
         
       