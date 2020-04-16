WITH ranking AS (
 SELECT get_fct_list AS "fct_id" FROM get_fct_list(ST_SetSRID( ST_Point( 34, -14), 4326))
)
--SELECT *, total_protetin, FIRST_VALUE(total_protetin) OVER (PARTITION BY 1) FROM "FOOD_COMPOSITION" LEFT JOIN ranking ON "FOOD_COMPOSITION".composition_table=ranking.fct_id 

SELECT 
   first_value(fct_id) 
   over (
   ) as target_fct,

   -- total_protetin
   first_value(total_protetin) 
   over (
     order by case when total_protetin is not null then 0 else 1 end ASC 
   ) as total_protetin,

   case WHEN (first_value(total_protetin) 
   over (
     order by case when total_protetin is not null then 0 else 1 end ASC 
   )) IS NOT NULL THEN
   first_value(fct_id) 
   over (
     order by case when total_protetin is not null then 0 else 1 end ASC 
   ) ELSE null END as total_protetin_fct,   

   case WHEN (first_value(total_protetin) 
   over (
     order by case when total_protetin is not null then 0 else 1 end ASC 
   )) IS NOT NULL THEN
   first_value(data_source) 
   over (
     order by case when total_protetin is not null then 0 else 1 end ASC 
   ) ELSE null END as total_protetin_source, 
   
   -- total_fat
   first_value(total_fat) 
   over (
     order by case when total_fat is not null then 0 else 1 end ASC 
   ) as total_fat,

   case WHEN (first_value(total_fat) 
   over (
     order by case when total_fat is not null then 0 else 1 end ASC 
   )) IS NOT NULL THEN
   first_value(fct_id) 
   over (
     order by case when total_fat is not null then 0 else 1 end ASC 
   ) ELSE null END as total_fat_fct,   

   case WHEN (first_value(total_fat) 
   over (
     order by case when total_fat is not null then 0 else 1 end ASC 
   )) IS NOT NULL THEN
   first_value(data_source) 
   over (
     order by case when total_fat is not null then 0 else 1 end ASC 
   ) ELSE null END as total_fat_source, 

   -- saturated_fat
   first_value(saturated_fat) 
   over (
     order by case when saturated_fat is not null then 0 else 1 end ASC 
   ) as saturated_fat,

   case WHEN (first_value(saturated_fat) 
   over (
     order by case when saturated_fat is not null then 0 else 1 end ASC 
   )) IS NOT NULL THEN
   first_value(fct_id) 
   over (
     order by case when saturated_fat is not null then 0 else 1 end ASC 
   ) ELSE null END as saturated_fat_fct


FROM "FOOD_COMPOSITION" 
    LEFT JOIN ranking ON "FOOD_COMPOSITION".composition_table=ranking.fct_id 
    WHERE ranking.fct_id IS NOT NULL 
        AND "FOOD_COMPOSITION".food_type=1 LIMIT 1
