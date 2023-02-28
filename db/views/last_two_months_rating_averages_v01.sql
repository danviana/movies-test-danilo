SELECT
  DATE_PART('month', created_at) AS month,
  DATE_PART('year', created_at) AS year,
  AVG(grade) as average_grade
FROM ratings
WHERE
  created_at > CURRENT_DATE - INTERVAL '1 months'
GROUP BY
  month, year
ORDER BY
  year, month
DESC;