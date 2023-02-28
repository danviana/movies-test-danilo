require 'rails_helper'

RSpec.describe DatabaseViews::YearWithMostMovies, type: :model do
  let!(:movies) { create_list(:movie, 3) }
  let!(:movies_released_at_1999) { create_list(:movie, 5, release_date: Faker::Date.in_date_period(year: 1999, month: 2)) }
  
  describe 'year with most movies view' do
    it 'returns only one result' do
      expect(Movie.all.count).to eq(8)
      expect(DatabaseViews::YearWithMostMovies.all.count).to eq(1)
    end

    it 'returns year 1999 and moview_cont 5' do
      expect(DatabaseViews::YearWithMostMovies.first.year).to eq(1999)
      expect(DatabaseViews::YearWithMostMovies.first.movies_count).to eq(5)
    end
  end
end
