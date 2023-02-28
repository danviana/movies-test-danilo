SELECT
  MAX(rating) as max_rating,
  COUNT(*) as total_movies_count,
  genre,
  parental_rating
FROM movies
GROUP BY
  genre, parental_rating
ORDER BY
  genre, parental_rating;