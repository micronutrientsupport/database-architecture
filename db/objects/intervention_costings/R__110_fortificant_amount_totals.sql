
-- drop view fortificant_amount_totals
create or replace view fortificant_amount_totals
as
select 
    a.intervention_id,
    sum(fortificant_amount) as "Nutrients subtotal", -- F25
    0.25 as "Excipient as a percent of nutrients subtotal", -- F26
    sum(fortificant_amount) * 1.25 as "Starting nutrients + excipient calculation", -- F27
    -- F30  =IF(F26=0,F25,CEILING(F27,50))
    ceil(sum(fortificant_amount) * 1.25 / 50.0) * 50 as "Addition Rate", -- F30
    -- F28=F30-F25
    (ceil(sum(fortificant_amount) * 1.25 / 50.0) * 50) - sum(fortificant_amount) as "Excipient/filler amount", -- F28
    --G28=F28*(1/$F$30)
    ((ceil(sum(fortificant_amount) * 1.25 / 50.0) * 50) - sum(fortificant_amount)) *(1/(ceil(sum(fortificant_amount) * 1.25 / 50.0) * 50))  as "Excipient/filler proportion", -- G28
    b.fortificant_price as "Excipient/filler price", -- H28
    -- I28=G28*H28
    ((ceil(sum(fortificant_amount) * 1.25 / 50.0) * 50) - sum(fortificant_amount)) *(1/(ceil(sum(fortificant_amount) * 1.25 / 50.0) * 50)) * b.fortificant_price as "Excipient/filler cost", -- I28
    --
    sum(a.fortificant_proportion * a.fortificant_price) as "Premix cost" -- I31
    -- I33=I31 +I32 (which is just 1)
    -- I34=(I33*F30)/1000
from 
    fortification_level a,
    (select fortificant_price, intervention_id 
    from fortification_level 
    where fortificant_id = 22) b 
where 
    a.intervention_id = b.intervention_id
group by 
    a.intervention_id, b.fortificant_price;

comment on view fortificant_amount_totals is 'This view recreates the formulas that exist in the interventions costings worksheet ''Premix - wheatflour'' so that the values can be referred to and included in formulas in the function called ''update_intervention_data_totals''.';

