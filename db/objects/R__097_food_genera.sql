create or replace view food_genera as 

select 
	genus.id, 
	genus.food_name, 
	genus.food_group_id, 
	parent_group.name as food_group_name,
	super_group.id as food_super_group_id,
	super_group.name as food_super_group_name

from food_genus genus 
	join food_group parent_group on parent_group.id = genus.food_group_id 
	join food_group super_group on super_group.id = parent_group.parent_id 
	
order by super_group.id, parent_group.id, genus.id;