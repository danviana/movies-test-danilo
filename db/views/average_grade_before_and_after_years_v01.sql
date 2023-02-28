SELECT
  AVG(before_2010.avg) as average_grade_before_2010,
  AVG(after_2010.avg) as  average_grade_after_2010,
  (AVG(before_2010.avg) - AVG(after_2010.avg)) as difference_between_averages
FROM (
  SELECT AVG(r.grade) AS avg
  FROM movies m
  INNER JOIN ratings r ON m.id = r.movie_id
  WHERE DATE_PART('YEAR', m.release_date) <= 2010
  GROUP BY m.id
) AS before_2010, (
  SELECT AVG(r.grade) AS avg
  FROM movies m
  INNER JOIN ratings r ON m.id = r.movie_id
  WHERE DATE_PART('YEAR', m.release_date) > 2010
  GROUP BY m.id
) AS after_2010;