class Rating < ApplicationRecord
  belongs_to :movie

  validates :grade, presence: true, allow_blank: false
  validates_numericality_of :grade, :greater_than => 0, :less_than => 6

  after_save :calculate_movie_ratings

  private

  def calculate_movie_ratings
    rating = movie.ratings.average(:grade)

    movie.update(rating: rating)
  end
end
