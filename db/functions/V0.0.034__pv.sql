

CREATE FUNCTION PV (rate numeric, nper numeric, pmt numeric, fv numeric, thetype integer) 
RETURNS numeric 
AS 
$$
declare 
-- PV(rate, nper, pmt, [fv], [type])

pv numeric;

begin
	
    pv :=
    Case 
    WHEN thetype = 0 THEN 
	    pmt *(Power(rate,nper) -1) / 
	    (rate * Power(rate,nper))
	    + fv * Power(rate,nper)
 
    WHEN thetype = 1 THEN 
	    pmt * (Power(1 + rate,nper) -1) /
	    (rate * Power(rate,nper))
	    * (1 + rate)
	    + fv * Power(1 + rate,nper)
    end;
   
    RETURN pv *-1;
   
end;
$$ LANGUAGE plpgsql;