
-- drop function pv;

CREATE or replace FUNCTION pv(rate numeric, nper numeric, fv numeric) 
RETURNS numeric 
AS 
$$
declare 

/*
This function seeks to replicate the equivalent one in MSExcel
but is actually a simplified version for our purposes. 
If any interim payments are made 'pmt' then this function will need extending
but as of now, that value is always 0 in the intervention costing worksheets.
*/

-- PV(rate, nper, pmt, [fv], [type])

pv numeric;

begin
	
    pv := fv * (1 / power((1+rate),nper));
   
    RETURN pv;
   
end;
$$ LANGUAGE plpgsql;


