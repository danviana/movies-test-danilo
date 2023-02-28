module DatabaseViews
  class AverageGradeBeforeAndAfterYears < ActiveRecord::Base
    include NotReadableView
  end
end
