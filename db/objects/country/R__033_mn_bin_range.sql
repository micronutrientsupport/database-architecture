create or replace view mn_bin_range as

select 
micronutrient_id
, power(10,floor(log(max(dietary_supply)))) as scale
, 0 as bin0
, ((ceiling(max(dietary_supply)/power(10,floor(log(max(dietary_supply)))))*power(10,floor(log(max(dietary_supply)))))/5)*1 as bin1
, ((ceiling(max(dietary_supply)/power(10,floor(log(max(dietary_supply)))))*power(10,floor(log(max(dietary_supply)))))/5)*2 as bin2
, ((ceiling(max(dietary_supply)/power(10,floor(log(max(dietary_supply)))))*power(10,floor(log(max(dietary_supply)))))/5)*3 as bin3
, ((ceiling(max(dietary_supply)/power(10,floor(log(max(dietary_supply)))))*power(10,floor(log(max(dietary_supply)))))/5)*4 as bin4
, ((ceiling(max(dietary_supply)/power(10,floor(log(max(dietary_supply)))))*power(10,floor(log(max(dietary_supply)))))/5)*5 as bin5
, ceiling(max(dietary_supply)/power(10,floor(log(max(dietary_supply)))))*power(10,floor(log(max(dietary_supply)))) as binmax
, max(dietary_supply)
, min(dietary_supply) from country_deficiency_afe cda group by micronutrient_id;