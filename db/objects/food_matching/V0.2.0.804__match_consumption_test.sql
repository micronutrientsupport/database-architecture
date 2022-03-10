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
	
	-- populate household_fct_list
	insert into household_fct_list
		(household_id, 
		fct_list)
	select 
		id, 
		ARRAY(SELECT * FROM get_fct_list(location))
	from household;
	
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
					(select distinct food_genus_id from 
					fooditem
					where 
					food_genus_id is not null) f
				cross join
				micronutrient m 

	 loop
	 
	 	--RAISE NOTICE 'fct_list_rec: %', fct_list_rec;
	 
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
                
                    --RAISE NOTICE 'fooditem_rec: %', fooditem_rec;
                
                    have_found_fct_entry := TRUE;

                    insert into consumption_compostion_matching
                    (
                        fct_list,
    					food_genus_id,
                        mn_id,
                        mn_composition,
                        fooditem_column,
                        fct_used
                    )
                    values
                    (
                        fct_list_rec.fct_list,
                        fct_list_rec.food_genus_id,
                        fct_list_rec.micronutrient_id,
                        fooditem_rec.thevalue,
                        fct_list_rec.fooditem_column,
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
                        fooditem_column,
                        fct_used
                )
                values
                (
                   		fct_list_rec.fct_list,
                        fct_list_rec.food_genus_id,
                        fct_list_rec.micronutrient_id,
                        null,
                        fct_list_rec.fooditem_column,
                        null
                );
            END IF;
			
        	--end loop;
    
    end loop;

end;       
         
$code$
;

         
         
       