CREATE OR REPLACE view intervention_crop_production_information AS 
with h2_agg as (
    select
        intervention_id,
        header1,
        header2,
        jsonb_object_agg(
            header2,
            to_jsonb(t) - 'header2' - 'header1' - 'intervention_id'
        ) res
    from
        intervention_values_json t
    group by
        intervention_id,
        header1,
        header2
),
intervention_data_json_aggregate as (
    select
        intervention_id,
        header1 as section,
        jsonb_object_aggregate(res) as data
    from
        h2_agg
    group by
        header1,
        intervention_id
)
select
    intervention_id,
    data -> 'All' -> 'data' as crop_production_information
from
    intervention_data_json_aggregate
where
    section = 'Crop production information';

comment ON view intervention_monitoring_information IS 'Extract industry information rows for a given intervention';