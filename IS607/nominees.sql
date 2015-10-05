DROP TABLE IF EXISTS tblCelebrity;
DROP TABLE IF EXISTS tblCategory;
DROP TABLE IF EXISTS tblFilms;

CREATE TABLE tblCelebrity
(
  celebrity_id int,
  name varchar (255) NOT NULL,
  nominee_id int NULL
);

INSERT INTO tblCelebrity (celebrity_id, name, nominee_id) VALUES (1, 'Bradley Cooper',1),(2, 'Michael Keaton',2), (3, 'Marion Cotillard',3),(4, 'Richard Linklater',4),(5, 'Edward Norton',4);

SELECT * FROM tblNominees;

CREATE TABLE tblFilms
(
  film_id int PRIMARY KEY,
  film VARCHAR (255) NOT NULL
);

INSERT INTO tblFilms (film_id, film) VALUES (1, 'American Sniper'),(2, 'Boyhood'),(3, 'Birdman'),(4, 'Two Days, One Night'),(5, 'The Grand Budapest Hotel');

SELECT * FROM tblFilms;

CREATE TABLE tblCategory
(
  category VARCHAR  (255) NOT NULL,
  film_id int,
  nominee_id int NULL
 );

 INSERT INTO tblCategory(category, film_id, nominee_id) VALUES ('Best Actor',1,1),('Best Actor', 3,2),('Best Actress',4,3),('Best Director',2,4),('Best Picture',1,NULL),
 ('Best Picture',5,NULL),('Best Picture',2,4),('Best Supporting Actor', 3,4);

     
 SELECT * FROM tblCategory;

SELECT a.name, b.category
 FROM tblCelebrity a
 INNER JOIN tblCategory b ON a.nominee_id = b.nominee_id;

SELECT d.film, c.category
 FROM tblCategory c
 INNER JOIN tblFilms d ON c.film_id = d.film_id
 ORDER BY film;

 SELECT a.name, b.category, c.film
 FROM tblCelebrity a
 INNER JOIN tblCategory b ON a.nominee_id = b.nominee_id
 INNER JOIN tblFilms c ON c.film_id = b.film_id;

 