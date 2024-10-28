-- à faire 1 fois sur l'instance
CREATE EXTENSION dblink;

-- à faire 1 fois sur l'instance
CREATE SERVER db2 FOREIGN DATA WRAPPER
dblink_fdw OPTIONS (host '172.17.0.3',
dbname 'postgres', port '5432');

-- à faire 1 fois sur l'instance
CREATE USER MAPPING FOR postgres SERVER db2
OPTIONS (user 'postgres', password 'testpwd');

-- à faire à chaque fois que l'on souhaité rétablir la connexion
-- variante : ne pas spécifier le host, dbname, user et password mais ne fonctionne pas en séance
SELECT dblink_connect('db2', 'host=172.17.0.3 dbname=postgres user=postgres password=testpwd');
-- variante
-- SELECT dblink_connect('db2', 'options=-csearch_path=');

-- pour déconnecter
select dblink_disconnect('db2');

-- attention à bien préciser le schéma attendu de la table interrogée
SELECT * FROM dblink('db2', 'select id, email from my_users')  AS my_users(id int, email text);

SELECT id FROM dblink('db2', 'select id from test_table_instance_2')  AS test_table_instance_2(id int);

-- créer une vue pour simuler l'utilisation de la table sur postgres
create view my_users as
	SELECT * FROM dblink('db2', 'select id, email from my_users')  AS my_users(id int, email text);

-- utiliser la vue comme si les données étaient locales au serveur 1
select * from my_users;

