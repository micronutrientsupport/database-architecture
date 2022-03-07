DROP FUNCTION IF exists match_consumption_to_composition();
CREATE OR REPLACE FUNCTION match_consumption_to_composition()
RETURNS TABLE (
    consumption_item_id int
    --consumption_food_genus_id NUMERIC
    --, fct_source_id NUMERIC
    , mn_id TEXT
    --, mn_name TEXT
    , mn_value NUMERIC
    , fct_used int
    
)
LANGUAGE plpgsql
AS
$code$
    DECLARE
        i  int;
        consumption_item record;
        fct_list integer[];
        the_household_id int;
        household_location geometry;
        fct_entry record;
        fct_entry_id int;
        the_mn TEXT;
        the_mn_value NUMERIC;
        used_fct_id int;
    
        
        cur_mn  cursor for 
            select * 
            from micronutrient;
        
    
    
    BEGIN
        RAISE NOTICE 'running funtion';

        DROP TABLE IF EXISTS consumption_compostion_matching;
        CREATE TABLE consumption_compostion_matching (
        consumption_item_id integer,
        mn_id               integer,
        mn_value            NUMERIC,
        fct_used            integer
        );

    

    
        -- initialize the household location - since many food consumption entries share a location, we don't want to re-calculate the best food compositon table for each one
        -- for each consumption item  (household+individual vs country?):
        FOR consumption_item IN
            SELECT
            household_consumption.id
             , food_genus_id
             , household.id AS household_id
             , LOCATION
             , food_genus_id
             , original_food_name
            FROM household_consumption
            JOIN household ON household_consumption.household_id = household.id
            --TODO:  also do individual and country consumption
            LIMIT 200 --TODO: remove to do all of them
        LOOP
            -- grab the household - since the location won't change between consumption items, we don't need to look up the best FCt for every item
            IF the_household_id != consumption_item.household_id OR the_household_id IS NULL THEN
                the_household_id := consumption_item.household_id;
                --# grab the best FCT to use for country/region for this food consumption item's household
                fct_list := ARRAY(
                    SELECT *
                    FROM get_fct_list(consumption_item.location)
                );
            END IF;

        -- grab fooditem values via food_genus

            RAISE NOTICE 'fct_list for this consumption item(% -- %) %', consumption_item.food_genus_id, consumption_item.original_food_name, fct_list;
        
--            FOR Micronutrient, loop through the fcts and find the first one with actual data 
            FOR mn_record IN cur_mn  LOOP
--            VitaminA_in_RAE_in_mcg
                
                -- for each fct entry for this fooditem/household, starting with the best:
                FOREACH fct_entry_id IN ARRAY fct_list LOOP
                    -- match this consumption items' food genus to the matching food genus in this food composition table. If there's no match in tis FCT, try the next one.
                    SELECT * INTO fct_entry
                    FROM fooditem
                    WHERE fooditem.fct_source_id = fct_entry_id
                    AND consumption_item.food_genus_id = fooditem.food_genus_id
                    ;
                    RAISE NOTICE 'mn: % --- fct_id: %', mn_column, fct_entry_id ;
                    RAISE NOTICE 'fct_entry: %', fct_entry;
                    -- grab the vitamin a values and the fct_id
                    -- TODO: actually grab
                    
                    INSERT INTO consumption_compostion_matching (
                        consumption_item_id,
                        mn_id     ,
                        mn_value  ,
                        fct_used             
                    )
                    VALUES(
                        consumption_item.id,
                        mn_record.id,
                        fooditem_value -- TODO
                        
                
--                    SELECT fooditem.mn_column INTO the_mn_value
--                    FROM fooditem 
--                    WHERE mn_column IS NOT NULL;
--                   
--                    RAISE NOTICE 'the_mn_value: %', the_mn_value;
                
--                    EXECUTE 
--                        
--                        
                        
--                    execute '
--                        select ' || mn_column || ' 
--                        from fooditem
------        where ' || mn_column || ' is not null
------        and other criteria' into mn_value;
----
----                        
                        
--        consumption_item_id integer,
--        mn_id               integer,
--        mn_value            NUMERIC,
--        fct_used            integer                 
                        
                        
--                    SELECT mn_column INTO the_mn
--                    FROM 
                --                    the_mn := fct_entry.mn_column; 
                
                    EXIT WHEN fct_entry.id IS NOT NULL; 
                    
                END LOOP;
                    
            END LOOP;       
  
            
                
--                    FOREACH mn_column IN ARRAY micronutrient_columns LOOP
--                        IF fct_entry.Zn_in_mg IS NOT NULL THEN
--                            RAISE NOTICE 'not null mn %', mn_column;
--                        END IF;
    --                 FOR EACH OF the muicronutrients:
    --                    check if ti has a value; 
    --                        if it does, grab; 
    --                        if it doesnt, got to the next FCT
                    
--                    table of food composition (all the micronutrients) for each food genus. But with gaps filled. AND(!) a list of FCT ids of where the gap filling comes from
                    
--                    END LOOP;
--                END IF;
        

        
--                EXIT WHEN fct_entry.id IS NOT NULL;
--            END LOOP;
        
        
        
        
--            FOR fct_entry IN
--                SELECT *
--                FROM fooditem
--                WHERE fooditem.fct_source_id = ANY (fct_list)
--                AND fooditem.food_genus_id = consumption_item.food_genus_id
--            LOOP
--            RAISE NOTICE '% %', fct_entry.food_genus_id, consumption_item.original_food_name;
--            END LOOP;
          -- loop through the micronutrients to:
--                check if the micronturient is null;
--                    if no:
--                    use it,         -- if multiple matches, take the average
--                    and attach the citation id
--                    and continue

--                    IF yes, get that micronutrient from the next best FCT and repeat this check

        RAISE NOTICE 'orignal food name: % fct_list %,household_id %,', consumption_item.original_food_name, fct_list[0+1], the_household_id;

        END LOOP;


        -- Done in get_fct_list()
        --## sort fcts:
        --	- distance
        --	- size
        --	- most recent

        --## take fct data
        --## if no fct data for that food genus, take it from next best fct
        --## if no fct data for that micronutrient, take it from next best fct
        --
        --# find best consumptiond data for country (?)


        RETURN QUERY
            SELECT 1, 'a vitamin',  3.02 , 21;

    END;
$code$
;

 SELECT * FROM 	match_consumption_to_composition();

 