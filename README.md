# Database Architecture

`db` directory contains sql migration files intended to be run against a [PostGIS](https://postgis.net/) database using [Flyway](https://flywaydb.org/) (or simply run in sequence).

- install flyway
- rename `flyway.conf.template` to `flyway.conf` and fill in the configuration
- run `flyway migrate` to run all the sql scripts. Run `flyway clean migrate` to delete pre-existing data in the schema and re-create the db objects from scratch

# ci

pipelines are run at https://kwvmxgit.ad.nerc.ac.uk/bmgf-maps/web/database-architecture

# Data import
JSON schemas that define the structure of data to be imported can be found at /doc/data-import-schemas. All data that is to be inserted into the db should be checked against these schemas.
