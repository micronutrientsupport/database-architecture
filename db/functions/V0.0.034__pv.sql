
-- drop function pv;

CREATE or replace FUNCTION pv(rate numeric, nper numeric, fv numeric) 
RETURNS numeric 
AS 
$$
declare 
-- PV(rate, nper, pmt, [fv], [type])

pv numeric;

begin
	
    pv := fv * (1 / power((1+rate),nper));
   
    RETURN pv;
   
end;
$$ LANGUAGE plpgsql;


