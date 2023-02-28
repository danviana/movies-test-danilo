class CreateMoviesWithOnlyOneRatings < ActiveRecord::Migration[6.1]
  def change
    create_view :movies_with_only_one_ratings
  end
end
