update country set geometry = GeomFromText('POLYGON ((32 -10, 34 -10, 36 -16, 35 -17, 32 -10))', 4326) where id = 'MWI';
update country set geometry = GeomFromText('POLYGON ((-16.8 13.6, -13.7 13.7, -13.8 13.2, -16.8 13, -16.8 13.6))', 4326) where id = 'GMB'
