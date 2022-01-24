

create table intervention_data_json 
(
intervention_id integer PRIMARY KEY NOT NULL,
intervention_data jsonb
);

COMMENT on table intervention_data_json is 'Table to store json version of intervention data so that it can be referred to directly by executed sql strings in functions';