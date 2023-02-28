module DatabaseViews
  class YearWithMostMovies < ActiveRecord::Base
    include NotReadableView
  end
end
