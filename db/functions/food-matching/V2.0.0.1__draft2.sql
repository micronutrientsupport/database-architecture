-- DROP FUNCTION IF exists match_consumption_test();

CREATE OR REPLACE FUNCTION match_consumption_test()
RETURNS void
LANGUAGE plpgsql
AS
$code$

declare

fct_id int;
fooditem_rec record;
mn_rec record;

consumption_cur  cursor for 
 SELECT
               hc.id
             , hc.food_genus_id
             , h.id AS household_id
             , h.LOCATION
             , hc.original_food_name
             , ARRAY(SELECT * FROM get_fct_list(h.location)) as fct_list
            FROM 
            household_consumption hc
            join household h
            on hc.household_id = h.id
            LIMIT 20; --TODO: remove to do all of them
            
begin
	
	DROP TABLE IF EXISTS consumption_compostion_matching;
    CREATE TABLE consumption_compostion_matching (
    consumption_item_id integer,
    mn_id               text,
    mn_value            NUMERIC,
    fct_used            integer
    );

    for consumption_rec in consumption_cur loop
    
        RAISE NOTICE 'fct_list for consumption item %: %', consumption_rec.id, consumption_rec.fct_list;
       
         for mn_rec in
        	select * from micronutrient loop
        
        	RAISE NOTICE 'micronutrient: %', mn_rec.name;
        	
        	FOREACH fct_id IN ARRAY consumption_rec.fct_list loop
        	
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

SELECT * FROM 	match_consumption_test();

select count(*) from consumption_compostion_matching; -- 380
         
         
       