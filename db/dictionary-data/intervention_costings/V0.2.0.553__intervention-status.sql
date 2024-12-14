-- SQ 1
-- IC  2
-- RS  3
-- NFV 4
-- SU 5
-- NBC 6

-- Existing     101
-- Hypothetical 102


create table intervention_status
(
    fortification_type    text REFERENCES fortification_type(id)
	, status                integer
    , status_name         text
    , status_desc         text
    , nature              integer
    , nature_code         text
    , nature_name         text
    , nature_desc         text
    , when_to_use         text
);

insert into intervention_status
(fortification_type, status,status_name,status_desc,nature,nature_code,nature_name,nature_desc,when_to_use)
values
('LSFF',101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',1,'SQ','Status quo','Modeled fortification standards and compliance with standards held constant over the 10-year time horizon.', 'Relevant when you want to model the cost and/or effectiveness of an existing program operating at current levels of compliance.')
,('LSFF',101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',2,'IC','Improved compliance','Investment made during years 1-2 enhanced monitoring and evaluation. Modeled industry compliance levels scaled up over 10-year time horizon.', 'Relevant when you want to model the cost and/or effectiveness of an existing program if compliance with the standard improves to a specified level or a relatively newly established program is scaling up.')
,('LSFF',101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',3,'RS','Revision of existing standard','Investment made during years 1-2 to plan for and revise the national standard. Modeling in years 1-2 reflects the current standard, while years 3-10 reflect the revised standard.', 'Relevant when you want to model the cost and or effectiveness of modifying an existing national standard, such as a change to the fortification level, a change to the required micronutrient compound, or the addition of a new micronutrient to the standard.')
,('LSFF',102,'Hypothetical intervention program','Either fortification standards for the food vehicle do not exist or the fortification standards do not include the focus micronutrient. Costs accrue in all 10 years of the modeling time horizon (start-up costs incurred in years 1-2), while effects accrue in years 3-10.',4,'NFV','New food vehicle','Investments made during years 1-2 to plan for, implement, and launch the fortification of a new food vehicle.','Relevant when you want to model the cost and/or effectiveness of introducing national standards for the fortification of a new food vehicle at assumed/potential levels of compliance.')
,('BF',101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',1,'SQ','Status quo','Modeled farmer adoption rates held constant over 10-year time horizon.','Relevant when you want to model the cost and/or effectiveness of an existing program operating at current farmer adoption rates.')
,('BF',101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',5,'SU','Scale up','Investments made during years 1-3 to promote farmer adopt of the biofortified crop. Modeled farmer adoption rates scaled up over 10-year time horizon.','Relevant when you want to model the cost and/or effectiveness of an existing program if farmer adoption rates increase.')
,('BF',102,'Hypothetical intervention program','Either fortification standards for the food vehicle do not exist or the fortification standards do not include the focus micronutrient. Costs accrue in all 10 years of the modeling time horizon (start-up costs incurred in years 1-3), while effects accrue in years 4-10.',6,'NBC','New biofortified crop','Investments made during years 1-3 to plan for and launch the release and promotion of the biofortified crop variety.','Relevant when a biofortified crop variety is nearly ready for release and you want to model the cost and/or effectiveness of the new biofortified crop variety at assumed/potential farmer adoption rates.')
,('AF',101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',1,'SQ','Status quo','Modeled farmer adoption rates held constant over 10-year time horizon.','Relevant when you want to model the cost and/or effectiveness of an existing program operating at current farmer adoption rates.')
,('AF',101,'Existing intervention program','Mandatory fortification standards exist for the food vehicle, including the focus micronutrient. Both costs and effects accrue in all 10 years of the modeling time horizon.',5,'SU','Scale up','Investments made during years 1-2 to promote farmer adoption of agronomic biofortification. Modeled farmer adoption rates scaled up over 10-year time horizon.','Relevant when you want to model the cost and/or effectiveness of an existing program if farmer adoption rates increase.')
,('AF',102,'Hypothetical intervention program','Either fortification standards for the food vehicle do not exist or the fortification standards do not include the focus micronutrient. Costs accrue in all 10 years of the modeling time horizon (start-up costs incurred in years 1-2), while effects accrue in years 4-10.',6,'NBC','New biofortified crop','Investments made during years 1-2 to plan for and promote agronomic biofortification.','Relevant when you want to model the cost and/or effectiveness of a new agronomic biofortification program at assumed/potential farmer adoption rates.')
;