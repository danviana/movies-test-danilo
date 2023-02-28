module DatabaseViews
  class LastTwoMonthsRatingAverage < ActiveRecord::Base
    include NotReadableView
  end
end
