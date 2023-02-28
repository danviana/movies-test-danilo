require 'rails_helper'

RSpec.describe DatabaseViews::HighestRatedMovieByGenreAndParentalRating, type: :model do
  let!(:movie1) { create(:movie, :with_ratings, quantity: 1, grade: 4, genre: 0, parental_rating: 0) }
  let!(:movie2) { create(:movie, :with_ratings, quantity: 1, grade: 2, genre: 0, parental_rating: 1) }
  let!(:movie3) { create(:movie, :with_ratings, quantity: 1, grade: 1, genre: 0, parental_rating: 1) }
  let!(:movie4) { create(:movie, :with_ratings, quantity: 1, grade: 3, genre: 1, parental_rating: 0) }
  let!(:movie5) { create(:movie, :with_ratings, quantity: 1, grade: 3, genre: 1, parental_rating: 2) }
  let!(:movie6) { create(:movie, :with_ratings, quantity: 1, grade: 5, genre: 1, parental_rating: 2) }
  
  describe 'last two months rating average view' do
    it 'returns 2 results' do
      expect(Movie.all.count).to eq(6)
      expect(DatabaseViews::HighestRatedMovieByGenreAndParentalRating.all.count).to eq(4)
    end

    it 'returns movie titles' do
      highest_rateds = DatabaseViews::HighestRatedMovieByGenreAndParentalRating.all

      expect(highest_rateds[0].max_rating).to eq(4.0)
      expect(highest_rateds[0].genre).to eq(0)
      expect(highest_rateds[0].parental_rating).to eq(0)
      expect(highest_rateds[1].max_rating).to eq(2.0)
      expect(highest_rateds[1].genre).to eq(0)
      expect(highest_rateds[1].parental_rating).to eq(1)
      expect(highest_rateds[2].max_rating).to eq(3.0)
      expect(highest_rateds[2].genre).to eq(1)
      expect(highest_rateds[2].parental_rating).to eq(0)
      expect(highest_rateds[3].max_rating).to eq(5.0)
      expect(highest_rateds[3].genre).to eq(1)
      expect(highest_rateds[3].parental_rating).to eq(2)
    end
  end
end
