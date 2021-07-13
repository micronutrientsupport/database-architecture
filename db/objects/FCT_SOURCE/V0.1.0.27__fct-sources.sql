ALTER SEQUENCE fct_source_id_seq RESTART WITH 20;

INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'WAFCT', st_union(geometry), TO_DATE('2019-01-01','YYYY-MM-DD'), 'FAO/INFOODS Food Composition Table for Western Africa (2019) / Table de composition alimentaire FAO/INFOODS pour l’Afrique de l’Ouest (2019)'
FROM country
WHERE id in ('BEN','BFA','CMR','GHA','MLI','NGA');
INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'MAFOODS', geometry, TO_DATE('2019-01-01','YYYY-MM-DD'), 'MAFOODS. 2019. Malawian Food Composition Table'
FROM country
WHERE id in ('MLI');
INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'KENFCT', geometry, TO_DATE('2018-01-01','YYYY-MM-DD'), 'Kenya Food Composition Tables 2018'
FROM country
WHERE id in ('KEN');
INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'LSOFCT', geometry, TO_DATE('2006-01-01','YYYY-MM-DD'), 'Lesotho Food Composition Table (2006)'
FROM country
WHERE id in ('LSO');
INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'Eastern-Africa', st_union(geometry), TO_DATE('2014-01-01','YYYY-MM-DD'), 'Supplementary Table 2. Food mineral composition data from literature sources, used in conjunction with Food Balance Sheets (FBSs) to estimate dietary mineral availability'
FROM country
WHERE region = 14;
INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'Middle-Africa', st_union(geometry), TO_DATE('2014-01-01','YYYY-MM-DD'), 'Supplementary Table 2. Food mineral composition data from literature sources, used in conjunction with Food Balance Sheets (FBSs) to estimate dietary mineral availability'
FROM country
WHERE region = 17;
INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'Southern-Africa', st_union(geometry), TO_DATE('2014-01-01','YYYY-MM-DD'), 'Supplementary Table 2. Food mineral composition data from literature sources, used in conjunction with Food Balance Sheets (FBSs) to estimate dietary mineral availability'
FROM country
WHERE region = 18;
INSERT INTO fct_source
(name,geometry,publication_date,notes)
SELECT 'Western-Africa', st_union(geometry), TO_DATE('2014-01-01','YYYY-MM-DD'), 'Supplementary Table 2. Food mineral composition data from literature sources, used in conjunction with Food Balance Sheets (FBSs) to estimate dietary mineral availability'
FROM country
WHERE region = 11;
