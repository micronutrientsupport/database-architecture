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
have_found_fct_entry boolean;

begin
    -- TODO: change to a delete and replace instead, so that we can make other objects depend on this table
    DROP TABLE IF EXISTS consumption_compostion_matching;
    CREATE TABLE consumption_compostion_matching (
        consumption_item_id             integer,
        mn_id                           text,
        mn_composition                  NUMERIC,
        fct_used                        integer,
        household_id                    integer,
        household_consumption_id        integer,
        household_member_consumption_id integer

    );

    for consumption_rec IN
    
        WITH consumption AS (
            select
                row_number() over () as consumtpion_item_id
                , consumption_items.*
            from
            (
            SELECT
                 hc.food_genus_id
                 , hc.id AS household_consumption_id
                 , NULL AS household_member_consumption_id
                 , h.id AS household_id
                 , h.LOCATION
                 , hc.original_food_name
                 -- , ARRAY(SELECT * FROM get_fct_list(h.location)) as fct_list
                FROM
                    household_consumption hc
                    join household h
                    on hc.household_id = h.id
                WHERE 1=1
    --                AND household_id < 10 -- TODO: remove!!
            union all
            select
                   hmc.food_genus_id
                 , NULL AS household_consumption_id
                 , hmc.id AS household_member_consumption_id
                 , hh.id AS household_id
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
             limit 20000 -- TODO remove this to get all DATA
        ),
        micronutrient AS (
            SELECT id AS micronutrient_id, * 
            FROM micronutrient
        )
        SELECT * FROM
        consumption CROSS JOIN micronutrient
 
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

--        RAISE NOTICE 'fct_list for consumption item %: %', consumption_rec.id, fct_list;

--        for mn_rec in select * from micronutrient loop
        
--            RAISE NOTICE 'micronutrient: %', mn_rec.name;

            FOREACH fct_id IN ARRAY fct_list LOOP
            
            have_found_fct_entry := FALSE;

--                RAISE NOTICE 'fct_list item: %', fct_id;

                -- grabs the food composition data
                execute '
                    select
                        original_food_name,
                        ''' || consumption_rec.name || ''' as micronutrient_name,
                        ' || consumption_rec.fooditem_column || ' as thevalue
                    from fooditem
                    where
                        fct_source_id = ' || fct_id || '
                        and food_genus_id = ''' || consumption_rec.food_genus_id || '''
                        and ' || consumption_rec.fooditem_column || ' is not null'
                into fooditem_rec;

                if fooditem_rec.micronutrient_name is not null THEN
                
--                    RAISE NOTICE 'fooditem_rec: %', fooditem_rec;
                
                    have_found_fct_entry := TRUE;

                    insert into consumption_compostion_matching
                    (
                        consumption_item_id,
                        mn_id,
                        mn_composition,
                        fct_used,
                        household_id,
                        household_consumption_id,
                        household_member_consumption_id
                    )
                    values
                    (
                        consumption_rec.consumtpion_item_id,
                        consumption_rec.micronutrient_id,
                        fooditem_rec.thevalue,
                        fct_id,
                        consumption_rec.household_id,
                        consumption_rec.household_consumption_id,
                        consumption_rec.household_member_consumption_id
                    );
                    
                    -- if we find one, we can exit
                    exit;


                
                end if;

--            end loop;
            
            IF NOT have_found_fct_entry THEN
               
                insert into consumption_compostion_matching
                (
                    consumption_item_id,
                    mn_id,
                    mn_composition,
                    fct_used,
                    household_id,
                    household_consumption_id,
                    household_member_consumption_id
                )
                values
                (
                    consumption_rec.consumtpion_item_id,
                    consumption_rec.micronutrient_id,
                    NULL,
                    NULL,
                    consumption_rec.household_id,
                    consumption_rec.household_consumption_id,
                    consumption_rec.household_member_consumption_id
                );
            END IF;
            
        end loop;
        

    end loop;

end;

$code$
;

SELECT * FROM   match_consumption_micronutrients();

select * from consumption_compostion_matching; -- 3612


