class CreateYearWithMostMovies < ActiveRecord::Migration[6.1]
  def change
    create_view :year_with_most_movies
  end
end
