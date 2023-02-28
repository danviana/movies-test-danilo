require 'rails_helper'

RSpec.describe DatabaseViews::MoviesWithOnlyOneRating, type: :model do
  let!(:movies_with_one_rating) { create_list(:movie, 3, :with_ratings, quantity: 1) }
  let!(:movies_with_more_than_one_rating) { create_list(:movie, 2, :with_ratings, quantity: rand(2..3)) }
  
  describe 'movies with only one rating view' do
    it 'returns ten results' do
      expect(Movie.all.count).to eq(5)
      expect(DatabaseViews::MoviesWithOnlyOneRating.all.count).to eq(3)
    end

    it 'returns movie titles' do
      expect(DatabaseViews::MoviesWithOnlyOneRating.all.pluck(:title)).to match_array(movies_with_one_rating.pluck(:title))
    end
  end
end
