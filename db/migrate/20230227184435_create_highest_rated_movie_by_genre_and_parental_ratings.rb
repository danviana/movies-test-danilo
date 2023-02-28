class CreateHighestRatedMovieByGenreAndParentalRatings < ActiveRecord::Migration[6.1]
  def change
    create_view :highest_rated_movie_by_genre_and_parental_ratings
  end
end
