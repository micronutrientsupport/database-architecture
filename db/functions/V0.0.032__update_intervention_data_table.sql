CREATE or replace function update_intervention_data_table(int_id integer) returns void

AS $$

declare 

update_sql text;

c cursor for
select row_index
from intervention_data
where
intervention_id = int_id
order by row_index;

begin
	
	execute update_intervention_data_totals(int_id);

    -- loop through json object updating table columns
    for r in c loop
    
        update_sql := 'UPDATE intervention_data a
                        SET 
                         year_0 = (b.intervention_data ->> ''' || r.row_index || '_0'')::numeric
                        ,year_1 = (b.intervention_data ->> ''' || r.row_index || '_1'')::numeric
                        ,year_2 = (b.intervention_data ->> ''' || r.row_index || '_2'')::numeric
                        ,year_3 = (b.intervention_data ->> ''' || r.row_index || '_3'')::numeric
                        ,year_4 = (b.intervention_data ->> ''' || r.row_index || '_4'')::numeric
                        ,year_5 = (b.intervention_data ->> ''' || r.row_index || '_5'')::numeric
                        ,year_6 = (b.intervention_data ->> ''' || r.row_index || '_6'')::numeric
                        ,year_7 = (b.intervention_data ->> ''' || r.row_index || '_7'')::numeric
                        ,year_8 = (b.intervention_data ->> ''' || r.row_index || '_8'')::numeric
                        ,year_9 = (b.intervention_data ->> ''' || r.row_index || '_9'')::numeric
                        from intervention_data_json b
                        WHERE 
                        a.intervention_id = b.intervention_id
                        and a.intervention_id = ' || int_id || '
                        and a.row_index = ' || r.row_index
                        ;
                        
        --Raise Notice'sql string:  %',update_sql;
                        
        EXECUTE update_sql;

    end loop;

end;

$$ LANGUAGE plpgsql;