module DatabaseViews
  class MoviesWithOnlyOneRating < ActiveRecord::Base
    include NotReadableView
  end
end
