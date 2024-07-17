-- BAU 1
-- SU  2
-- IC  3
-- RS  4

-- NFV 5
-- EXP 6

-- Existing     101
-- Hypothetical 102


create table intervention_status
(
	status                integer
    , status_name         text
    , status_desc         text
    , nature              integer
    , nature_name         text
    , nature_desc         text
);

insert into intervention_status
(status,status_name,status_desc,nature,nature_name,nature_desc)
values
(101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',1,'BAU','Business as usual - No modeled changes in the intervention program over the 10-year modeling time horizon.')
,(101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',2,'SU','Scale up - Scale up compliance over time when a standard has recently been established.')
,(101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',3,'IC','Improved Compliance - Investment made during years 1-2 (scale-up costs) to improve industry compliance with existing standards.')
,(101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',4,'RS','Revision of existing standard - Investment made during years 1-2 (scale-up costs) to plan for and revise the national standard to change mandated fortification level or the specified fortification compound of a micronutrient currently in the standard. Modeled fortification level in years 1-2 reflect the current standard, while years 3-10 reflect the revised standard.')

,(102,' Hypothetical intervention program','Either fortification standards for the food vehicle do not exist or the fortification standards do not include the focus micronutrient. Costs accrue in all 10 years of the modeling time',5,'NFV','New food vehicle - Investments made during years 1-2 (start-up costs) to plan for, implement, and launch the fortification of a new food vehicle.')
,(102,' Hypothetical intervention program','Either fortification standards for the food vehicle do not exist or the fortification standards do not include the focus micronutrient. Costs accrue in all 10 years of the modeling time',6,'EXP','Expansion of the standard - Investment made during years 1-2 (start-up costs) to plan for and revise the national standard to add a new micronutrient to the current standard. Modeled fortification level in years 1-2 reflect the current standard, while years 3-10 reflect the expanded standard.')
;