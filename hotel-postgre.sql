-- Script à compléter
-- Plusieurs tables sont à ajouter, vous pouvez vous servir du modèle logique de données pour les retrouver

-- Attention : 
-- Pour les noms de table ou de colonne vous ne pourrez pas utiliser les mots-clefs utilisé par le langage SQL
-- Voici un liste des mots clefs interdits : https://www.postgresql.org/docs/current/sql-keywords-appendix.html
-- si toutefois vous souhaitez utiliser un mot clef considéré interdit vous pouvez utiliser des guillemets.

-- Ne pas oublier les contraintes d'intégrités suivantes :
-- * contraintes de clefs étrangères 
-- * contraintes de clefs primaires
-- * contraintes de domaine  (ou type)


CREATE TABLE station (
	id SERIAL PRIMARY KEY,
	"name" VARCHAR(50) NOT NULL,
	altitude INT
);

CREATE TABLE hotel (
	id 			SERIAL primary KEY,
	station_id 	INT NOT NULL,
	"name" 		VARCHAR(50) NOT NULL,
	category 	INT NOT NULL,
	"address"	VARCHAR(50) NOT NULL,
	"city" 		VARCHAR(50) NOT NULL, 
	FOREIGN KEY (station_id) REFERENCES station(id)
);

CREATE TABLE room (
	id 			SERIAL primary KEY,
	hotel_id 	INT NOT NULL,
	"number" 	VARCHAR(50) NOT NULL,
	capacity 	INT NOT NULL,
	type 		INT NOT NULL, 
	FOREIGN KEY (hotel_id) REFERENCES hotel(id)
);

CREATE TABLE client (
	id 				SERIAL primary KEY,
	"first_name"	VARCHAR(50) NOT NULL,
	"last_name" 	VARCHAR(50) NOT NULL,
	address			VARCHAR(50) NOT NULL,
	city 			VARCHAR(50) NOT NULL);

CREATE TABLE booking (
	id 				SERIAL primary KEY,
	room_id 		INT NOT NULL,
	client_id 		INT NOT NULL,
	booking_date 	date NOT NULL,
	stay_start_date date NOT NULL,
	stay_end_date 	date NOT NULL,
	price			INT NOT NULL,
	deposit 		INT NOT NULL, 
	FOREIGN KEY (room_id) REFERENCES room(id),
	FOREIGN KEY (client_id) REFERENCES client(id)
);

-- Exercice 1

select name, city
from hotel;

-- Exercice 2

select first_name, last_name, address
from client
where last_name like 'White';

-- Exercice 3

select name, altitude
from station
where altitude < 1000;

-- Exercice 4

select number, capacity
from room
where capacity > 1;

-- Exercice 5

select first_name, last_name, address
from client
where not last_name like 'Londres';

-- Exercice 6

select name, city, category
from hotel
where city = 'Bretou' and category > 3;

-- Exercice 7

select s.name, h.name, city, h.category
from hotel h
join station s
on h.id = s.id

-- Exercice 8

select h.name, r.number, city, h.category
from room r
join hotel h
on r.id = h.id

-- Exercice 9

select h.name, r.number, city, h.category, r.capacity
from hotel h
join room r
on h.id = r.id
where h.city = 'Bretou' and r.capacity > 1;

-- Exercice 10

select c.first_name, h.name, b.stay_start_date, b.stay_end_date
from booking b
join client c
on b.id = c.id
join hotel h
on b.id = h.id;

-- Exercice 11

select r.number, r.capacity, h.name, s.name
from room r
join client c
on r.id = c.id
join hotel h
on r.id = h.id
join station s
on r.id = s.id;

-- Exercice 12

select h.name, c.last_name, c.first_name, b.booking_date, b.stay_start_date, b.stay_end_date
from booking b
join client c
on b.id = c.id
join hotel h
on b.id = h.id;

--  Exercice 14

select station_id, count(*)
from room r
join hotel h on r.hotel_id  = h.id
group by station_id;

--  Exercice 15

select station_id, count(*)
from room r
join hotel h on r.hotel_id  = h.id
where r.capacity > 1
group by station_id;

--  Exercice 16

select distinct h.name
from client c
join booking b on client_id = b.id
join hotel h on room_id = h.id
where c.last_name = 'Squire'

--  Exercice 17

select hotel_id, count(*)
from room r
join hotel h on r.hotel_id = h.id
join client c on r.hotel_id = h.id
where c.last_name like 'Squire'
group by hotel_id;