require 'rails_helper'

RSpec.describe DatabaseViews::AverageGradeBeforeAndAfterYears, type: :model do
  let!(:movies_before_2010) { create_list(:movie, 10, :with_ratings, release_date: Faker::Date.in_date_period(year: rand(2000..2010), month: rand(1..12))) }
  let!(:movies_after_2010) { create_list(:movie, 10, :with_ratings, release_date: Faker::Date.in_date_period(year: rand(2011..2022), month: rand(1..12))) }
  
  describe 'average grade before and after 2010 view' do
    it 'returns only one result' do
      expect(Movie.all.count).to eq(20)
      expect(DatabaseViews::AverageGradeBeforeAndAfterYears.all.count).to eq(1)
    end

    it 'returns average_grade_before_2010, average_grade_after_2010 and difference_between_averages' do
      averages = DatabaseViews::AverageGradeBeforeAndAfterYears.first

      average_before_2010 = (movies_before_2010.map(&:rating).sum / movies_before_2010.size).round(2)
      average_after_2010 = (movies_after_2010.map(&:rating).sum / movies_before_2010.size).round(2)
      average_difference = (average_before_2010 - average_after_2010).round(2)

      expect(averages[:average_grade_before_2010].round(2)).to eq(average_before_2010)
      expect(averages[:average_grade_after_2010].round(2)).to eq(average_after_2010)
      expect(averages[:difference_between_averages].round(2)).to eq(average_difference)
    end
  end
end
