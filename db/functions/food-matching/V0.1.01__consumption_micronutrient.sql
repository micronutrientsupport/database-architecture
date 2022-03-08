-- DROP FUNCTION IF exists match_consumption_test();

CREATE OR REPLACE FUNCTION match_consumption_micronutrients()
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
            
begin
	
	DROP TABLE IF EXISTS consumption_compostion_matching;
    CREATE TABLE consumption_compostion_matching (
    consumption_item_id integer,
    mn_id               text,
    mn_value            NUMERIC,
    fct_used            integer
    );

    for consumption_rec in 
    	    	select 
    		row_number() over () as id
    		, consumption_items.*
    	from 
    	(
    	SELECT
             hc.food_genus_id
             , h.id AS household_id
             , h.LOCATION
             , hc.original_food_name
             -- , ARRAY(SELECT * FROM get_fct_list(h.location)) as fct_list
            FROM 
            household_consumption hc
            join household h
            on hc.household_id = h.id
           
            union all
            
        select 
               hmc.food_genus_id
             , hmc.id AS household_id
             , hh.LOCATION
             , hmc.original_food_name
             -- , ARRAY(SELECT * FROM get_fct_list(h.location)) as fct_list
            FROM 
            household_member_consumption hmc
            join household_member hhm 
            on hhm.id = hmc.household_member_id 
            join household hh
            on hhm.household_id = hh.id
         ) as consumption_items
         limit 20 -- TODO remove this to get all data
	 loop
    
	 	-- grab the household - since the location won't change between consumption items, we don't need to look up the best FCt for every item
            IF the_household_id != consumption_rec.household_id OR the_household_id IS NULL THEN
                the_household_id := consumption_rec.household_id;
                --# grab the best FCT to use for country/region for this food consumption item's household
                fct_list := ARRAY(
                    SELECT *
                    FROM get_fct_list(consumption_rec.location)
                );
            END IF;
	
        RAISE NOTICE 'fct_list for consumption item %: %', consumption_rec.id, fct_list;
       
         for mn_rec in
        	select * from micronutrient loop
        
        	RAISE NOTICE 'micronutrient: %', mn_rec.name;
        	
        	FOREACH fct_id IN ARRAY fct_list loop
        	
        		RAISE NOTICE 'fct_list item: %', fct_id;
        	
	        	execute 'select original_food_name, 
				''' || mn_rec.name || ''' as micronutrient,
				' || mn_rec.fooditem_column || ' as thevalue
	        	from fooditem
	        	where 
	        	fct_source_id = ' || fct_id || '
	        	and food_genus_id = ''' || consumption_rec.food_genus_id || '''
				and ' || mn_rec.fooditem_column || ' is not null'
				into fooditem_rec;
	        	
				if fooditem_rec.micronutrient is not null then
	        		RAISE NOTICE 'fooditem_rec: %', fooditem_rec;	
	        	
	        		insert into consumption_compostion_matching 
	        		(
	        		consumption_item_id,
				    mn_id, 
				    mn_value,
				    fct_used 
				    )
				    values 
				    (
				    consumption_rec.id, 
				    mn_rec.id, 
				    fooditem_rec.thevalue, 
				    fct_id 
				    );
				   
				   exit;
	        	
				end if; 
			
        	end loop;
        
        end loop;
    
    end loop;

end;       
         
$code$
;

SELECT * FROM 	match_consumption_micronutrients();

select * from consumption_compostion_matching; -- 3612
         
         
       