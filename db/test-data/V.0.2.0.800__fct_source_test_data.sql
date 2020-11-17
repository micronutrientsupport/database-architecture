update FCT_SOURCE
set geometry = (
    select geometry
    from country
    where name = 'Malawi'
    )
where name = 'Malawi';
update FCT_SOURCE set geometry = (select geometry from country where name = 'Gambia') where name LIKE '%Gambia%';


INSERT INTO fct_source (id, name, geometry) values (3, 'test-zambia', (SELECT geometry from country where name = 'Zambia'));
