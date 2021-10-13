CREATE TABLE household_normalisation_factor (
	age_in_months                 integer
    , sex                         text CHECK (sex in ('m','f'))
	, energy_requirement          integer
	, afe                         numeric(3,2)
	, ame                         numeric(3,2)
);

COMMENT ON TABLE household_normalisation_factor                       IS 'Factors to be applied to nutrient requirements given age and sex to normalise values across households';
COMMENT on column household_normalisation_factor.age_in_months        IS 'Age of household member to apply adjustment for';
COMMENT on column household_normalisation_factor.energy_requirement   IS 'Energy requirement for a person of this sex and age';
COMMENT on column household_normalisation_factor.afe                  IS 'Adult Female Equivalent (AFE) adjustment factor for a person of this sex and age';
COMMENT on column household_normalisation_factor.ame                  IS 'Adult Male Equivalent (AME) adjustment factor for a person of this sex and age';
