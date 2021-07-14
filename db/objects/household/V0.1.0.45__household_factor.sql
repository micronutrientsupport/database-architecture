CREATE TABLE household_normalisation_factor (
	age_in_months                 integer
	, energy_requirement_m        integer
	, energy_requirement_f        integer
    , sex                         text CHECK (sex in ('m','f'))
	, afe                         numeric(3,2)
	, ame                         numeric(3,2)
);

COMMENT ON TABLE household_normalisation_factor                       IS 'Factors to be applied to nutrient requirements given age and sex to normalise values across households';
COMMENT on column household_normalisation_factor.age_in_months        IS 'Age of household member to apply adjustment for';
COMMENT on column household_normalisation_factor.energy_requirement_m IS 'Energy requirement for a male of this age';
COMMENT on column household_normalisation_factor.energy_requirement_f IS 'Energy requiement for a female of this age';
COMMENT on column household_normalisation_factor.afe                  IS 'Adult Female Equivalent (AFE) adjustment factor for a person of this sex of this age';
COMMENT on column household_normalisation_factor.ame                  IS 'Adult Male Equivalent (AME) adjustment factor for a person of this sex of this age';
