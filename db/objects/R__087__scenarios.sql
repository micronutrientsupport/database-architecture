create or replace function create_scenario_fct(_fct_source_id numeric, _food_genus text, _field text, _new_value numeric)

returns setof fooditem as
$$
DECLARE
  schema text := current_schema();
  mn_field text := (SELECT LOWER(fooditem_column) FROM "andan-scenario".micronutrient WHERE id=_field);
BEGIN

	return QUERY EXECUTE
	 'SELECT ' || replace(
	 -- QUERY information schema table to get list of column names as a string seperated by comma
	 array_to_string(ARRAY(SELECT c.column_name
        FROM information_schema.columns As c
            WHERE table_name = 'fooditem' and table_schema = schema
           -- AND  c.column_name NOT IN('ca_in_mg')
    	), ',')
   		-- replace <field> with '<newvalue> as <field>' in query text
    , '' || mn_field || '', '' || _new_value || '::numeric(20,10) as ' || mn_field || '') 
   || ' FROM "' || schema || '".fooditem WHERE fct_source_id=' || _fct_source_id || ' AND food_genus_id=''' || _food_genus || '''
    UNION SELECT * from "' || schema || '".fooditem WHERE fct_source_id=' || _fct_source_id || ' AND food_genus_id!=''' || _food_genus || ''''
	;

END
$$
language plpgsql;

--select * from create_scenario_fct(10, 'andy94'::text, 'Ca'::text, 5000);


create or replace function create_country_scenario(_fct_source_id numeric, _food_genus text, _field text, _new_value numeric)
returns setof country_intake as
$$
BEGIN
  return QUERY
  SELECT
        cc.country_id
        , fooditem.fct_source_id
        , data_source_id
        , sum(Moisture_in_g                  / 100 * amount_consumed_in_g) as Moisture_in_g
        , sum(Energy_in_kCal                 / 100 * amount_consumed_in_g) as Energy_in_kCal
        , sum(Energy_in_kJ                   / 100 * amount_consumed_in_g) as Energy_in_kJ
        , sum(Nitrogen_in_g                  / 100 * amount_consumed_in_g) as Nitrogen_in_g
        , sum(TotalProtein_in_g              / 100 * amount_consumed_in_g) as TotalProtein_in_g
        , sum(TotalFats_in_g                 / 100 * amount_consumed_in_g) as TotalFats_in_g
        , sum(SaturatedFA_in_g               / 100 * amount_consumed_in_g) as SaturatedFA_in_g
        , sum(MonounsaturatedFA_in_g         / 100 * amount_consumed_in_g) as MonounsaturatedFA_in_g
        , sum(PolyunsaturatedFA_in_g         / 100 * amount_consumed_in_g) as PolyunsaturatedFA_in_g
        , sum(Cholesterol_in_mg              / 100 * amount_consumed_in_g) as Cholesterol_in_mg
        , sum(Carbohydrateavailable_in_g     / 100 * amount_consumed_in_g) as Carbohydrateavailable_in_g
        , sum(Fibre_in_g                     / 100 * amount_consumed_in_g) as Fibre_in_g
        , sum(Ash_in_g                       / 100 * amount_consumed_in_g) as Ash_in_g
        , sum(Ca_in_mg                       / 100 * amount_consumed_in_g) as Ca_in_mg
        , sum(Fe_in_mg                       / 100 * amount_consumed_in_g) as Fe_in_mg
        , sum(Mg_in_mg                       / 100 * amount_consumed_in_g) as Mg_in_mg
        , sum(P_in_mg                        / 100 * amount_consumed_in_g) as P_in_mg
        , sum(K_in_mg                        / 100 * amount_consumed_in_g) as K_in_mg
        , sum(Na_in_mg                       / 100 * amount_consumed_in_g) as Na_in_mg
        , sum(Zn_in_mg                       / 100 * amount_consumed_in_g) as Zn_in_mg
        , sum(Cu_in_mg                       / 100 * amount_consumed_in_g) as Cu_in_mg
        , sum(Mn_in_mcg                      / 100 * amount_consumed_in_g) as Mn_in_mcg
        , sum(I_in_mcg                       / 100 * amount_consumed_in_g) as I_in_mcg
        , sum(Se_in_mcg                      / 100 * amount_consumed_in_g) as Se_in_mcg
        , sum(VitaminA_in_RAE_in_mcg         / 100 * amount_consumed_in_g) as VitaminA_in_RAE_in_mcg
        , sum(Thiamin_in_mg                  / 100 * amount_consumed_in_g) as Thiamin_in_mg
        , sum(Riboflavin_in_mg               / 100 * amount_consumed_in_g) as Riboflavin_in_mg
        , sum(Niacin_in_mg                   / 100 * amount_consumed_in_g) as Niacin_in_mg
        , sum(VitaminB6_in_mg                / 100 * amount_consumed_in_g) as VitaminB6_in_mg
        , sum(Folicacid_in_mcg               / 100 * amount_consumed_in_g) as Folicacid_in_mcg
        , sum(Folate_in_mcg                  / 100 * amount_consumed_in_g) as Folate_in_mcg
        , sum(VitaminB12_in_mcg              / 100 * amount_consumed_in_g) as VitaminB12_in_mcg
        , sum(Pantothenate_in_mg             / 100 * amount_consumed_in_g) as Pantothenate_in_mg
        , sum(Biotin_in_mcg                  / 100 * amount_consumed_in_g) as Biotin_in_mcg
        , sum(VitaminC_in_mg                 / 100 * amount_consumed_in_g) as VitaminC_in_mg
        , sum(VitaminD_in_mcg                / 100 * amount_consumed_in_g) as VitaminD_in_mcg
        , sum(VitaminE_in_mg                 / 100 * amount_consumed_in_g) as VitaminE_in_mg
        , sum(PhyticAcid_in_mg               / 100 * amount_consumed_in_g) as PhyticAcid_in_mg
    FROM
        "andan-scenario".create_scenario_fct(_fct_source_id, _food_genus, _field, _new_value) as fooditem
        JOIN "andan-scenario".food_genus ON food_genus.id = fooditem.food_genus_id
        JOIN "andan-scenario".COUNTRY_CONSUMPTION as cc ON cc.food_genus_id = food_genus.id
        --JOIN survey on household.survey_id = survey.id
    GROUP BY data_source_id, fooditem.fct_source_id, cc.country_id;
END
$$
language plpgsql;

create or replace view food_group_items AS 
select id as group_id, name as group_name, (select json_agg(jsonb_build_object('foodName', food_name, 'id', id)) from food_genus fd_gen where fd_gen.food_group_id=fd_grp.id) as food_items
FROM food_group fd_grp where fd_grp.parent_id is not null and fd_grp.id>2000;
