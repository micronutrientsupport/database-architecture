CREATE TABLE household_normalisation_factor (
	age_in_months               integer
	, energy_requirement_m        integer
	, energy_requirement_f        integer
	, ame_m                       numeric(3,2)
	, ame_f                       numeric(3,2)
	, afe_m                       numeric(3,2)
	, afe_f                       numeric(3,2)
);

COMMENT ON TABLE household_normalisation_factor                       IS 'Factors to be applied to nutrient requirements given age and sex to normalise values across households';
COMMENT on column household_normalisation_factor.age_in_months        IS 'Age of household member to apply adjustment for';
COMMENT on column household_normalisation_factor.energy_requirement_m IS 'Energy requirement for a male of this age';
COMMENT on column household_normalisation_factor.energy_requirement_f IS 'Energy requiement for a female of this age';
COMMENT on column household_normalisation_factor.ame_m                IS 'Adult Male Equivalent (AME) adjustment factor for a male of this age';
COMMENT on column household_normalisation_factor.ame_f                IS 'Adult Male Equivalent (AME) adjustment factor for a female of this age';
COMMENT on column household_normalisation_factor.afe_m                IS 'Adult Female Equivalent (AFE) adjustment factor for a male of this age';
COMMENT on column household_normalisation_factor.afe_f                IS 'Adult Female Equivalent (AFE) adjustment factor for a female of this age';
