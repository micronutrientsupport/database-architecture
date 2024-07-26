create or replace view population_summary as
select year, aa.country, sum(population) 
from population p 
	join aggregation_area aa on aa.id = p.aggregation_area_id 
group by country, year;
