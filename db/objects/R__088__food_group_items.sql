create or replace view food_group_items AS 
select id as group_id, name as group_name, (select json_agg(jsonb_build_object('foodName', food_name, 'id', id)) from food_genus fd_gen where fd_gen.food_group_id=fd_grp.id) as food_items
FROM food_group fd_grp where fd_grp.parent_id is not null and fd_grp.id>2000;