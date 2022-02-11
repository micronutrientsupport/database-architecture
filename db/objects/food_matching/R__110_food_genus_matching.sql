DROP FUNCTION IF exists match_consumption_to_composition();
CREATE OR REPLACE FUNCTION match_consumption_to_composition()
RETURNS TABLE (
    consumption_food_genus_id NUMERIC
    , fct_source_id NUMERIC
    , mn_id TEXT
    , mn_name TEXT
    , mn_value NUMERIC
    , fct_list int ARRAY
    --
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
    BEGIN
        -- initialize the household location - since many food consumption entries share a location, we don't want to re-calculate the best food compositon table for each one
        -- for each consumption item  (household+individual vs country?):
        FOR consumption_item IN
            SELECT
             food_genus_id
             , household.id AS household_id
             , LOCATION
             , food_genus_id 
             , original_food_name
            FROM household_consumption
            JOIN household ON household_consumption.household_id = household.id
            --TODO:  also do individual and country consumption
            LIMIT 200000 --TODO: remove to do all of them
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
  
          -- for each fct entry for this fooditem/household, starting with the best:
          FOR fct_entry IN
              SELECT *
              FROM fooditem
              WHERE fooditem.fct_source_id = ANY (fct_list)
              AND fooditem.food_genus_id = consumption_item.food_genus_id
          LOOP
            RAISE NOTICE '% %', fct_entry.food_genus_id, consumption_item.original_food_name;
          END LOOP;
            -- loop thorugh the micronutrients to:
--                check if the micronturient is null;
--                    if no:
--                    use it,         -- if multiple matches, take the average
--                    and attach the citation id
--                    and continue

--                    IF yes, get that micronutrient from the next best FCT and repeat this check

          RAISE NOTICE 'fct_list %,household_id %,', fct_list[0+1], the_household_id;

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
            SELECT 1., 2.,'foo','bar', 3., ARRAY[1,2];

    END;
$code$
;

 SELECT * FROM 	match_consumption_to_composition();

