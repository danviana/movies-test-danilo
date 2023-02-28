class CreateAverageGradeBeforeAndAfterYears < ActiveRecord::Migration[6.1]
  def change
    create_view :average_grade_before_and_after_years
  end
end
