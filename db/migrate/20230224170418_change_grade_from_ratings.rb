class ChangeGradeFromRatings < ActiveRecord::Migration[6.1]
  def change
    change_column_null :ratings, :grade, false
    change_column :ratings, :grade, :float
  end
end
