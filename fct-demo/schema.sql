--
-- PostgreSQL database dump
--
CREATE EXTENSION IF NOT EXISTS postgis WITH SCHEMA public;


CREATE TABLE public."COUNTRY" (
    id text NOT NULL,
    name text
);


ALTER TABLE public."COUNTRY" OWNER TO postgres;


CREATE TABLE public."DATA_SOURCE" (
    id integer NOT NULL,
    name text,
    author text,
    publication text,
    isbn text,
    notes text
);


ALTER TABLE public."DATA_SOURCE" OWNER TO postgres;


CREATE TABLE public."FCT_OVERRIDE" (
    location_id integer,
    fct_id integer,
    "order" integer
);


ALTER TABLE public."FCT_OVERRIDE" OWNER TO postgres;


CREATE TABLE public."FOOD_COMPOSITION" (
    id integer NOT NULL,
    food_group integer,
    composition_table integer,
    total_protetin numeric(20,10),
    total_fat numeric(20,10),
    saturated_fat numeric(20,10),
    monounsaturated_fat numeric(20,10),
    polyunsaturated_fat numeric(20,10),
    cholestorol numeric(20,10),
    food_type integer,
    data_source integer
);


ALTER TABLE public."FOOD_COMPOSITION" OWNER TO postgres;


CREATE TABLE public."FOOD_COMPOSITION_TABLE" (
    id integer NOT NULL,
    date date,
    name text,
    data_source integer,
    location_id integer
);


ALTER TABLE public."FOOD_COMPOSITION_TABLE" OWNER TO postgres;


CREATE TABLE public."FOOD_DATA_SOURCE_LINK" (
    fooditem_id integer NOT NULL,
    date_source_id integer NOT NULL
);


ALTER TABLE public."FOOD_DATA_SOURCE_LINK" OWNER TO postgres;


CREATE TABLE public."FOOD_GROUP" (
    id integer NOT NULL,
    name text
);


ALTER TABLE public."FOOD_GROUP" OWNER TO postgres;


CREATE TABLE public."LOCATION" (
    id integer NOT NULL,
    "Country" text NOT NULL,
    "Name" text,
    geom public.geometry(MultiPolygon,4326)
);


ALTER TABLE public."LOCATION" OWNER TO postgres;

CREATE TABLE public.countries (
    id integer NOT NULL,
    name character varying(256),
    geom public.geometry(MultiPolygon,4326)
);


ALTER TABLE public.countries OWNER TO postgres;


ALTER TABLE ONLY public."COUNTRY"
    ADD CONSTRAINT "COUNTRY_pkey" PRIMARY KEY (id);


ALTER TABLE ONLY public."DATA_SOURCE"
    ADD CONSTRAINT "DATA_SOURCE_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY public."FOOD_COMPOSITION_TABLE"
    ADD CONSTRAINT "FOOD_COMPOSITION_TABLE_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY public."FOOD_COMPOSITION"
    ADD CONSTRAINT "FOOD_COMPOSITION_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY public."FOOD_DATA_SOURCE_LINK"
    ADD CONSTRAINT "FOOD_DATA_SOURCE_LINK_pkey" PRIMARY KEY (fooditem_id, date_source_id);

ALTER TABLE ONLY public."FOOD_GROUP"
    ADD CONSTRAINT "FOOD_GROUP_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY public."LOCATION"
    ADD CONSTRAINT "LOCATION_pkey" PRIMARY KEY (id);

ALTER TABLE ONLY public.countries
    ADD CONSTRAINT countries_pkey PRIMARY KEY (id);

ALTER TABLE ONLY public."FCT_OVERRIDE"
    ADD CONSTRAINT "FCT_OVERRIDE_fct_id_fkey" FOREIGN KEY (fct_id) REFERENCES public."FOOD_COMPOSITION_TABLE"(id);

ALTER TABLE ONLY public."FCT_OVERRIDE"
    ADD CONSTRAINT "FCT_OVERRIDE_location_id_fkey" FOREIGN KEY (location_id) REFERENCES public."LOCATION"(id);

ALTER TABLE ONLY public."FOOD_COMPOSITION_TABLE"
    ADD CONSTRAINT "FOOD_COMPOSITION_TABLE_data_source_fkey" FOREIGN KEY (data_source) REFERENCES public."DATA_SOURCE"(id);

ALTER TABLE ONLY public."FOOD_COMPOSITION_TABLE"
    ADD CONSTRAINT "FOOD_COMPOSITION_TABLE_location_id_fkey" FOREIGN KEY (location_id) REFERENCES public."LOCATION"(id);

ALTER TABLE ONLY public."FOOD_COMPOSITION"
    ADD CONSTRAINT "FOOD_COMPOSITION_composition_table_fkey" FOREIGN KEY (composition_table) REFERENCES public."FOOD_COMPOSITION_TABLE"(id);

ALTER TABLE ONLY public."FOOD_COMPOSITION"
    ADD CONSTRAINT "FOOD_COMPOSITION_food_group_fkey" FOREIGN KEY (food_group) REFERENCES public."FOOD_GROUP"(id);

ALTER TABLE ONLY public."FOOD_DATA_SOURCE_LINK"
    ADD CONSTRAINT "FOOD_DATA_SOURCE_LINK_date_source_id_fkey" FOREIGN KEY (date_source_id) REFERENCES public."DATA_SOURCE"(id);

ALTER TABLE ONLY public."FOOD_DATA_SOURCE_LINK"
    ADD CONSTRAINT "FOOD_DATA_SOURCE_LINK_fooditem_id_fkey" FOREIGN KEY (fooditem_id) REFERENCES public."FOOD_COMPOSITION"(id);

ALTER TABLE ONLY public."LOCATION"
    ADD CONSTRAINT "LOCATION_Country_fkey" FOREIGN KEY ("Country") REFERENCES public."COUNTRY"(id);
