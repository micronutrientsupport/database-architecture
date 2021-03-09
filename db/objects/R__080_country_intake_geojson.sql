CREATE OR REPLACE FUNCTION get_country_intake_geoJSON(_country text, _fct_id numeric, _data_source_id numeric, _micronutrient text)
RETURNS json AS

$BODY$
  declare
  	retval json;
begin
	
	execute '

SELECT row_to_json(fc)
 FROM ( SELECT ''FeatureCollection'' As type, array_to_json(array_agg(f)) As features
 FROM (SELECT ''Feature'' As type
    , public.ST_AsGeoJSON(public.ST_ForcePolygonCCW(c2.geometry))::json As geometry
    , row_to_json(ci) As properties
   FROM country_intake
INNER JOIN (SELECT country_id
         					,' || $4 || ' as mn_absolute
         					, micronutrient.unit as mn_absolute_unit
         					, c.name as subregion_name
         					, ''Country'' as subregion_type
         					FROM country_intake 
								join country c on c.id=country_intake.country_id
								JOIN micronutrient on micronutrient.fooditem_column = ''' || $4 || '''
         					where country_intake.fct_source_id=' || $2 || ' and country_intake.data_source_id=' || $3 || '
         					) As ci 
       ON country_intake.country_id = ci.country_id 
       join country c2 on c2.id = country_intake.country_id 
       where country_intake.country_id=''' || $1 || '''
       ) As f )  As fc
       ' INTO retval using _country, _fct_id, _data_source_id, _micronutrient;
    RETURN retval;

END
$BODY$
LANGUAGE plpgsql;