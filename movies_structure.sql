CREATE TABLE IF NOT EXISTS `movies` (
  `id`        INT  NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
  `title`     VARCHAR(255) NOT NULL,
  `year`      INT,
  `budget`  INT
  );
  
  CREATE TABLE IF NOT EXISTS `directors` (
  `id`        INT  NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
  `full_name`  VARCHAR(255)
  );
  
  CREATE TABLE IF NOT EXISTS `genres` (
  `id`        INT  NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
  `title`     VARCHAR(255)
  );
  
  CREATE TABLE IF NOT EXISTS `companies` (
  `id`        INT  NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
  `title`     VARCHAR(255)
  );
  
INSERT INTO movies(id, title, year, budget)
SELECT id, title, year, budget FROM tmp;

INSERT INTO directors(full_name)
SELECT distinct director FROM tmp;

INSERT INTO genres(title)
SELECT distinct genre FROM tmp;

INSERT INTO companies(title)
SELECT distinct company FROM tmp;

CREATE TABLE IF NOT EXISTS `movies_directors` (
  `id`        INT  NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
  `id_directors` INT 
  );
  
INSERT INTO movies_directors(id, id_directors)
SELECT tmp.id, directors.id FROM tmp
JOIN directors ON tmp.director = directors.full_name
;

CREATE TABLE IF NOT EXISTS `movies_genres` (
  `id`        INT  NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
  `id_genres` INT 
  );
  
INSERT INTO movies_genres(id, id_genres)
SELECT tmp.id, genres.id FROM tmp
JOIN genres ON tmp.genre = genres.title
;

CREATE TABLE IF NOT EXISTS `movies_companies` (
  `id`        INT  NOT NULL  PRIMARY KEY  AUTO_INCREMENT,
  `id_companies` INT 
  );
  
INSERT INTO movies_companies(id, id_companies)
SELECT tmp.id, companies.id FROM tmp
JOIN companies ON tmp.company = companies.title
;


SELECT movies.id, movies.title, movies.year, directors.full_name, genres.title, companies.title, movies.budget FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
;
