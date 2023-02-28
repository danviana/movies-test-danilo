SELECT
  m.title,
  COUNT(r.movie_id)
FROM movies m
INNER JOIN ratings r
  ON r.movie_id = m.id
GROUP BY
  m.id
HAVING
  COUNT(r.movie_id) = 1;