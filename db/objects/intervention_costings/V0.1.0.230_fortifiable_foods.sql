CREATE TABLE fortifiable_portions_food_group (
    id                     integer primary key generated by default as IDENTITY
    , food_vehicle_id      integer references food_vehicle (id)
    , food_group_id        integer references food_group (id)
    , fortifiable_portion  integer 
    CHECK (fortifiable_portion BETWEEN 1 AND 100)
);

COMMENT ON TABLE fortifiable_portions_food_group IS 'List of food groups which are impacted when a given food vehicle is fortified';
COMMENT on column fortifiable_portions_food_group.food_vehicle_id     IS 'The food vehicle which is fortified.  References the food_vehicle table';
COMMENT on column fortifiable_portions_food_group.food_group_id      IS 'The FAO food group of this food genus. References the food_group table';
COMMENT on column fortifiable_portions_food_group.fortifiable_portion IS 'The proportion of the food item (by weight) which is impacted by the fortification program (0-100)';

INSERT into fortifiable_portions_food_group 
(food_vehicle_id, food_group_id, fortifiable_portion) 

VALUES 
 (1, 2035, 100),    -- FV #1 = Wheat Flour, FG #103 = Wheat and wheat-based products
 (4, 2028, 100),   -- Sugar / Sugar (raw equivalent) and products 
 (4, 2020, 50);      -- Cocoa beans and products



CREATE TABLE fortifiable_portions_food_genus (
    id                     integer primary key generated by default as IDENTITY
    , food_vehicle_id      integer references food_vehicle (id)
    , food_genus_id        text references food_genus (id)
    , fortifiable_portion  integer 
    CHECK (fortifiable_portion BETWEEN 0 AND 100)
);

COMMENT ON TABLE fortifiable_portions_food_genus IS 'List of food groups which are impacted when a given food vehicle is fortified';
COMMENT on column fortifiable_portions_food_genus.food_vehicle_id     IS 'The food vehicle which is fortified.  References the food_vehicle table';
COMMENT on column fortifiable_portions_food_genus.food_genus_id      IS 'The MAPS food genus for the food item. References the food_genus table';
COMMENT on column fortifiable_portions_food_genus.fortifiable_portion IS 'The proportion of the food item (by weight) which is impacted by the fortification program (0-100)';

INSERT into fortifiable_portions_food_genus 
(food_vehicle_id, food_genus_id, fortifiable_portion) 

VALUES 
 (1, '23991.01.05', 90),    -- Include infant whole wheat food
 (1, '23991.01.06', 90),   -- Include infant whole wheat food 
 (1, 'F1232.25', 100),      -- Include couscous from misc products
 (1, 'F0020.06', 80),       -- Reduce fortifiable component for chapati with ghee from the default for the wheat products group
 (1, '23140.03.02', 0);    -- Mark museli flakes as unfortifiable


 CREATE or replace view fortifiable_food_items as 

 with fgrp as 
(select fpgrp.food_vehicle_id, fpgrp.fortifiable_portion, fg.id as food_genus_id, fg.food_name, fg.food_group_id from fortifiable_portions_food_group fpgrp join food_genus fg on fg.food_group_id = fpgrp.food_group_id)
, fgen as 
(select fpgen.food_vehicle_id, fpgen.fortifiable_portion, fg.id as food_genus_id, fg.food_name, fg.food_group_id from fortifiable_portions_food_genus fpgen join food_genus fg on fg.id = fpgen.food_genus_id)

select * from fgrp where food_genus_id in (select food_genus_id from fgrp except select food_genus_id from fgen) -- only rows unique to the food group table (not overriden by food_genus table)
union
select * from fgen where fortifiable_portion > 0

order by food_vehicle_id, food_group_id, food_genus_id;

create or replace view fortifiable_genus_overrides as

select 
food_vehicle_id
, fv.vehicle_name as food_vehicle_name
, food_genus_id
, food_name as food_genus_name
, grp.id as food_group_id
, grp.name as food_group_name
, fortifiable_portion

from fortifiable_portions_food_genus fpfg 
join food_genus fg on fpfg.food_genus_id = fg.id
join food_group grp on fg.food_group_id = grp.id
join food_vehicle fv on fpfg.food_vehicle_id = fv.id; 

create or replace view fortifiable_food_groups as
select 
food_vehicle_id
, fv.vehicle_name as food_vehicle_name
, food_group_id
, fg.name as food_group_name
, fortifiable_portion

from fortifiable_portions_food_group fpfg 
join food_group fg on fpfg.food_group_id = fg.id
join food_vehicle fv on fpfg.food_vehicle_id = fv.id;