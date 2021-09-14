# Database Architecture

`db` directory contains sql migration files intended to be run against a [PostGIS](https://postgis.net/) database using [Flyway](https://flywaydb.org/) (or simply run in sequence).

- install flyway
- rename `flyway.conf.template` to `flyway.conf` and fill in the configuration
- run `flyway migrate` to run all the sql scripts. Run `flyway clean migrate` to delete pre-existing data in the schema and re-create the db objects from scratch

