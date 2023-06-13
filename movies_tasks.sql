-- 1.
SELECT count(*) FROM movies
JOIN companies ON movies.id_companies = companies.id
WHERE companies.title = 'Universal Pictures'
;
-- 2.
SELECT count(*) FROM movies
JOIN directors ON movies.id_directors = directors.id
WHERE directors.full_name = 'Фрэнсис Форд Коппола'
;
-- 3.
SELECT count(title) FROM movies
WHERE year > year(curdate()) - 20;
-- 4.
SELECT DISTINCT genres.title FROM movies
JOIN genres ON movies.id_genres = genres.id
JOIN directors ON movies.id_directors = directors.id
WHERE directors.full_name = 'Стивен Спилберг'
;
-- 5. 
SELECT movies.title, genres.title, directors.full_name FROM movies
JOIN genres ON movies.id_genres = genres.id
JOIN directors ON movies.id_directors = directors.id
ORDER BY budget DESC
LIMIT 5
;
-- 6.
SELECT directors.full_name FROM movies
JOIN directors ON movies.id_directors = directors.id
GROUP BY directors.full_name
ORDER BY COUNT(directors.full_name) DESC
LIMIT 1
;
-- 7. 
SELECT movies.title, genres.title FROM movies
JOIN genres ON movies.id_genres = genres.id
JOIN companies ON movies.id_companies = companies.id
WHERE companies.title = (
SELECT companies.title FROM movies
JOIN companies ON movies.id_companies = companies.id
GROUP BY companies.title
ORDER BY SUM(movies.budget) DESC
LIMIT 1
)
;
-- 8.
SELECT avg(movies.budget) FROM movies
JOIN companies ON movies.id_companies = companies.id
WHERE companies.title = 'Warner Bros.'
GROUP BY companies.title
;
-- 9. 
SELECT genres.title, COUNT(movies.id), AVG(movies.budget) FROM movies
JOIN genres ON movies.id_genres = genres.id
GROUP BY genres.title
;
-- 10.
DELETE FROM movies
WHERE id = (SELECT id FROM (SELECT movies.id FROM movies
JOIN genres ON movies.id_genres
WHERE movies.title = 'Дикие истории' AND genres.title = 'комедия'
) as tmp)
;
