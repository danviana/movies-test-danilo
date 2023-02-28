class CreateLastTwoMonthsRatingAverages < ActiveRecord::Migration[6.1]
  def change
    create_view :last_two_months_rating_averages
  end
end
