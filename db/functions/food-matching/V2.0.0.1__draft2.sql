DROP FUNCTION IF exists match_consumption_test();
CREATE OR REPLACE FUNCTION match_consumption_test()
RETURNS void
    
)
LANGUAGE plpgsql
AS
$code$

declare

consumption_cur  cursor for 
 SELECT
               hc.id
             , hc.food_genus_id
             , h.id AS household_id
             , h.LOCATION
             , hc.original_food_name
            -- , ARRAY(SELECT * FROM get_fct_list(h.location) as fct_list
             , 'blah' as fct_list
            FROM 
            household_consumption hc
            join household h
            on hc.household_id = h.id
            LIMIT 200; --TODO: remove to do all of them
            
begin

    for consumption_rec in consumption_cur loop
    
        RAISE NOTICE 'fct_list for consumption item %: %', consumption_rec.id, consumption_rec.fct_list;
    
    end loop;

end;       
         
$code$
;

 SELECT * FROM 	match_consumption_test();
         
         
       