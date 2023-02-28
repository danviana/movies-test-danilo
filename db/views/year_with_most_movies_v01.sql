SELECT
  DATE_PART('YEAR', release_date) AS year,
  COUNT(*) AS movies_count
FROM movies
GROUP BY year
ORDER BY movies_count
DESC
LIMIT 1;