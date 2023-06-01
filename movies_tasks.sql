-- 1.
SELECT count(*) FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE companies.title = 'Universal Pictures'
;
-- 2.
SELECT count(*) FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE directors.full_name = 'Фрэнсис Форд Коппола'
;
-- 3.
SELECT count(*) FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE movies.year >= 2003
;
-- 4.
SELECT DISTINCT genres.title FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE directors.full_name = 'Стивен Спилберг'
;
-- 5. 
SELECT movies.title, genres.title, directors.full_name FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
ORDER BY budget DESC
LIMIT 5
;
-- 6.
SELECT directors.full_name, COUNT(directors.full_name) as count FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
GROUP BY directors.full_name
ORDER BY count DESC
LIMIT 1
;
-- 7. 
SELECT movies.title, genres.title FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE companies.title = (
SELECT companies.title FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
GROUP BY companies.title
ORDER BY SUM(movies.budget) DESC
LIMIT 1
)
;
-- 8.
SELECT avg(movies.budget) FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE companies.title = 'Warner Bros.'
GROUP BY companies.title
;
-- 9. 
SELECT genres.title, COUNT(movies.id), AVG(movies.budget) FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
GROUP BY genres.title
;
-- 10.
DELETE FROM movies_companies
WHERE id = (SELECT movies.id FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE movies.title = 'Дикие истории'
)
;
DELETE FROM movies_directors
WHERE id = (SELECT movies.id FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE movies.title = 'Дикие истории'
)
;
DELETE FROM movies_genres
WHERE id = (SELECT movies.id FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE movies.title = 'Дикие истории'
)
;
DELETE FROM movies
WHERE id = (SELECT * FROM (SELECT movies.id FROM movies
JOIN movies_companies ON movies.id = movies_companies.id
JOIN companies ON companies.id = movies_companies.id_companies
JOIN movies_directors ON movies.id = movies_directors.id
JOIN directors ON directors.id = movies_directors.id_directors
JOIN movies_genres ON movies.id = movies_genres.id
JOIN genres ON genres.id = movies_genres.id_genres
WHERE movies.title = 'Дикие истории'
) as tmp)
;