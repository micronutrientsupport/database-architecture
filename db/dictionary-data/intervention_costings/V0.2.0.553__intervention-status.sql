-- SQ 1
-- IC  2
-- RS  3

-- NFV 5

-- Existing     101
-- Hypothetical 102


create table intervention_status
(
	status                integer
    , status_name         text
    , status_desc         text
    , nature              integer
    , nature_code         text
    , nature_name         text
    , nature_desc         text
    , when_to_use         text
);

insert into intervention_status
(status,status_name,status_desc,nature,nature_code,nature_name,nature_desc,when_to_use)
values
(101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',1,'SQ','Status quo','Modeled fortification standards and compliance with standards held constant over the 10-year time horizon.', 'Relevant when you want to model the cost and/or effectiveness of an existing program operating at current levels of compliance.')
,(101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',2,'IC','Improved compliance','Investment made during years 1-2 enhanced monitoring and evaluation. Modeled industry compliance levels scaled up over 10-year time horizon.', 'Relevant when you want to model the cost and/or effectiveness of an existing program if compliance with the standard improves to a specified level or a relatively newly established program is scaling up.')
,(101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',3,'RS','Revision of existing standard','Investment made during years 1-2 to plan for and revise the national standard. Modeling in years 1-2 reflects the current standard, while years 3-10 reflect the revised standard.', 'Relevant when you want to model the cost and or effectiveness of modifying an existing national standard, such as a change to the fortification level, a change to the required micronutrient compound, or the addition of a new micronutrient to the standard.')
,(102,'Hypothetical intervention program',' Either fortification standards for the food vehicle do not exist or the fortification standards do not include the focus micronutrient. Costs accrue in all 10 years of the modeling time horizon (start-up costs incurred in years 1-2), while effects accrue in years 3-10.',4,'NFV','New food vehicle','Investments made during years 1-2 to plan for, implement, and launch the fortification of a new food vehicle.','Relevant when you want to model the cost and/or effectiveness of introducing national standards for the fortification of a new food vehicle at assumed/potential levels of compliance.')
;