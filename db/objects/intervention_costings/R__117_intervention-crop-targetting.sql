create or replace view intervention_crop_targetting as

with targetting_json as (
select 
	intervention_id,
	json_build_object(
		'region', region
		, 'is_region_targeted', is_region_targeted
		, 'zones_targeted', zones_targeted
		, 'cultivation_area_ha', cultivation_area_ha
		, 'targeted_area_ha', targeted_area_ha
		, 'regional_share_pc', regional_share_pc
	) as targetting
	from intervention_targetting it 
    order by region
)

select intervention_id, json_agg(targetting) as crop_targetting
from targetting_json
group by intervention_id;

