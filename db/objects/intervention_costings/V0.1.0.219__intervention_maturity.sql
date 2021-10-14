create table intervention_maturity (
    id     integer CREATED BY DEFAULT AS IDENTITY
    , intervention_id INTEGER REFERENCES intervention(id)
    , YEAR      integer
    , maturity    text CHECK IN ('SU', 'SC', 'BAU')
);

comment on table intervention_maturity iS 'what the maturity of the intervention is; whether it is in the startup phase, being scaled up, or already operating and contuning business as ususal ';
comment on column intervention_maturity.maturity iS 'SU = Start Up. SC = Scale Up. BAU = Business As Usual';
