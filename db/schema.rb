# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2023_02_28_041444) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "movies", force: :cascade do |t|
    t.string "title", null: false
    t.date "release_date", null: false
    t.integer "runtime"
    t.integer "genre"
    t.integer "parental_rating"
    t.text "plot"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "rating"
  end

  create_table "ratings", force: :cascade do |t|
    t.bigint "movie_id", null: false
    t.float "grade", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["movie_id"], name: "index_ratings_on_movie_id"
  end

  add_foreign_key "ratings", "movies"

  create_view "year_with_most_movies", sql_definition: <<-SQL
      SELECT date_part('YEAR'::text, movies.release_date) AS year,
      count(*) AS movies_count
     FROM movies
    GROUP BY (date_part('YEAR'::text, movies.release_date))
    ORDER BY (count(*)) DESC
   LIMIT 1;
  SQL
  create_view "last_two_months_rating_averages", sql_definition: <<-SQL
      SELECT date_part('month'::text, ratings.created_at) AS month,
      date_part('year'::text, ratings.created_at) AS year,
      avg(ratings.grade) AS average_grade
     FROM ratings
    WHERE (ratings.created_at > (CURRENT_DATE - 'P1M'::interval))
    GROUP BY (date_part('month'::text, ratings.created_at)), (date_part('year'::text, ratings.created_at))
    ORDER BY (date_part('year'::text, ratings.created_at)), (date_part('month'::text, ratings.created_at)) DESC;
  SQL
  create_view "highest_rated_movie_by_genre_and_parental_ratings", sql_definition: <<-SQL
      SELECT max(movies.rating) AS max_rating,
      count(*) AS total_movies_count,
      movies.genre,
      movies.parental_rating
     FROM movies
    GROUP BY movies.genre, movies.parental_rating
    ORDER BY movies.genre, movies.parental_rating;
  SQL
  create_view "movies_with_only_one_ratings", sql_definition: <<-SQL
      SELECT m.title,
      count(r.movie_id) AS count
     FROM (movies m
       JOIN ratings r ON ((r.movie_id = m.id)))
    GROUP BY m.id
   HAVING (count(r.movie_id) = 1);
  SQL
  create_view "average_grade_before_and_after_years", sql_definition: <<-SQL
      SELECT avg(before_2010.avg) AS average_grade_before_2010,
      avg(after_2010.avg) AS average_grade_after_2010,
      (avg(before_2010.avg) - avg(after_2010.avg)) AS difference_between_averages
     FROM ( SELECT avg(r.grade) AS avg
             FROM (movies m
               JOIN ratings r ON ((m.id = r.movie_id)))
            WHERE (date_part('YEAR'::text, m.release_date) <= (2010)::double precision)
            GROUP BY m.id) before_2010,
      ( SELECT avg(r.grade) AS avg
             FROM (movies m
               JOIN ratings r ON ((m.id = r.movie_id)))
            WHERE (date_part('YEAR'::text, m.release_date) > (2010)::double precision)
            GROUP BY m.id) after_2010;
  SQL
end
