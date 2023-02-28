module DatabaseViews
  class HighestRatedMovieByGenreAndParentalRating < ActiveRecord::Base
    include NotReadableView
  end
end
