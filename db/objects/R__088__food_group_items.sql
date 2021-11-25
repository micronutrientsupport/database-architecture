create or replace view food_group_items AS 

with food_group_items as (
select id as food_group_id, name as food_group_name, 
	(select json_agg(jsonb_build_object('foodGenusName', food_name, 'foodGenusId', id)) 
		from food_genus fd_gen 
		where fd_gen.food_group_id=fd_grp.id) 
	as food_items
FROM food_group fd_grp where fd_grp.parent_id is not null
)
select * from food_group_items fgi where food_items is not null;