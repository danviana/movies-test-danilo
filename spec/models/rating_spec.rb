require 'rails_helper'

RSpec.describe Rating, type: :model do
  describe 'associations' do
    it { is_expected.to belong_to :movie }
  end

  describe 'validations' do
    subject { build(:rating, :with_dependencies) }

    it { is_expected.to validate_presence_of(:grade) }
    it { is_expected.to validate_numericality_of(:grade).is_greater_than(0).is_less_than(6)}
    it { is_expected.to be_valid }
  end

  context '.calculate_movie_ratings' do
    let(:movie) { create(:movie) }
    let!(:rating1) { create(:rating, movie: movie, grade: 5) }
    let!(:rating2) { create(:rating, movie: movie, grade: 3) }

    it 'recalculates the movie rating' do
      expect(movie.rating).to eq(4.0)
    end
  end
end
