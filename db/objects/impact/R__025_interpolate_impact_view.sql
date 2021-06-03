--inspired by https://stackoverflow.com/questions/46479322/how-do-i-linearly-interpolate-a-value-in-one-table-based-on-a-different-lookup-t
create or replace function interpolate_impact_year(_country text, _scenario text, _mn text, _threshold numeric, _ref_year numeric default 2010)

-- refernce_val = the value at the refrence year of that nutrient intake (same units as the impact food availability table)
returns table(
	--upper_year numeric,
	--lower_year numeric,
	--upper_val numeric,
	--lower_val numeric,
	reference_val numeric,
	reference_year numeric,
	intersect_year text) as
$$
declare
	lower_year numeric;
	upper_year numeric;
	lower_val  numeric;
	upper_val  numeric;
	reference_val numeric;
BEGIN

	execute '
		WITH lkup as (
			select *
			from impact_total_food_availability
			where
				country=$1
				and scenario=$2
			order by year asc
		)
		SELECT
			((SELECT lkup.year FROM lkup WHERE lkup.' || _mn || ' <= $4 ORDER BY lkup.' || _mn || ' DESC LIMIT 1)) as lower_year,
			((SELECT lkup.year FROM lkup WHERE lkup.' || _mn || ' >= $4 ORDER BY lkup.' || _mn || ' ASC  LIMIT 1)) as upper_year,
			((SELECT lkup.' || _mn || ' FROM lkup WHERE lkup.' || _mn || ' <= $4 ORDER BY lkup.' || _mn || ' DESC LIMIT 1)) as lower_val,
			((SELECT lkup.' || _mn || ' FROM lkup WHERE lkup.' || _mn || ' >= $4 ORDER BY lkup.' || _mn || ' ASC  LIMIT 1)) as upper_val,
			((SELECT lkup.' || _mn || ' FROM lkup WHERE lkup.year = 2010)) as reference_val
		FROM lkup'
	into lower_year, upper_year, lower_val, upper_val, reference_val using _country, _scenario, _mn, _threshold, _ref_year;

	return query (
		select
		--lower_year,
		--upper_year,
		--lower_val,
		--upper_val,
		reference_val,
		_ref_year,
		CASE
			WHEN lower_year = upper_year THEN lower_year::text -- if equal, then return the exact year
			when lower_year is null then upper_year::text -- if the lower year is null, then return the first year (target already reached)
			when upper_year is null then concat('Beyond ', lower_year) -- if the upper year is null, then return null (target won't be reached)
			ELSE
			CEILING(
				(((_threshold-lower_val)*(upper_year-lower_year))/(upper_val-lower_val))+lower_year -- otherwise interpolate linearly
			)::text
		END	AS intersect_year
	);
END
$$
language plpgsql;
