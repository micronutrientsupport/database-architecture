
-- Refresh materialized views in case new data has been added.
-- We create dummy views to prevent errors when running the script from a
-- blank database, as otherwise flyway will ty to refresh a non-existent
-- materialized view. The dummy tables should get overwritten by the actual
-- scripts for the materialized views

CREATE MATERIALIZED VIEW IF NOT EXISTS vw_country          AS SELECT 'x'; REFRESH MATERIALIZED VIEW vw_country;
CREATE MATERIALIZED VIEW IF NOT EXISTS top20_mn_per_country          AS SELECT 'x'; REFRESH MATERIALIZED VIEW top20_mn_per_country;
CREATE MATERIALIZED VIEW IF NOT EXISTS top20_mn_per_hhsurvey         AS SELECT 'x'; REFRESH MATERIALIZED VIEW top20_mn_per_hhsurvey;
CREATE MATERIALIZED VIEW IF NOT EXISTS monthly_food                  AS SELECT 'x'; REFRESH MATERIALIZED VIEW monthly_food;
CREATE MATERIALIZED VIEW IF NOT EXISTS impact_summary                AS SELECT 'x'; REFRESH MATERIALIZED VIEW impact_summary;
CREATE MATERIALIZED VIEW IF NOT EXISTS impact_commodity_aggregation  AS SELECT 'x'; REFRESH MATERIALIZED VIEW impact_commodity_aggregation;
CREATE MATERIALIZED VIEW IF NOT EXISTS impact_food_group_aggregation AS SELECT 'x'; REFRESH MATERIALIZED VIEW impact_food_group_aggregation;
CREATE MATERIALIZED VIEW IF NOT EXISTS household_deficiency_afe_aggregation AS SELECT 'x'; REFRESH MATERIALIZED VIEW household_deficiency_afe_aggregation;
CREATE MATERIALIZED VIEW IF NOT EXISTS household_intake_afe AS SELECT 'x'; REFRESH MATERIALIZED VIEW household_intake_afe;
CREATE MATERIALIZED VIEW IF NOT EXISTS country_deficiency_afe AS SELECT 'x'; REFRESH MATERIALIZED VIEW country_deficiency_afe;
CREATE MATERIALIZED VIEW IF NOT EXISTS intervention_cell_formula_deps AS SELECT 'x'; REFRESH MATERIALIZED VIEW intervention_cell_formula_deps;
CREATE MATERIALIZED VIEW IF NOT EXISTS biomarker_summary AS SELECT 'x'; REFRESH MATERIALIZED VIEW biomarker_summary;