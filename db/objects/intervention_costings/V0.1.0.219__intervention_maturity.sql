create table intervention_maturity (
    id                integer CREATED BY DEFAULT AS IDENTITY
    , intervention_id integer REFERENCES intervention(id)
    , year            integer
    , maturity        text CHECK IN ('SU', 'SC', 'BAU')
);

comment on table intervention_maturity is 'what the maturity of the intervention is in this year; whether it is in the startup phase, being scaled up, or already operating and contuning business as ususal ';
comment on column intervention_maturity.intervention_id is 'which intervention this maturity applies to';
comment on column intervention_maturity.maturity is 'SU = Start Up. SC = Scale Up. BAU = Business As Usual';
comment on column intervention_maturity.year is 'What year this maturity applies to';
