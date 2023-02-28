require 'rails_helper'

RSpec.describe Ratings::API do
  let!(:movie) { Movie.create(title: "teste", release_date: Date.today) }

  let(:valid_attributes) {
    { movie_id: movie.id.to_s, grade: '2' }
  }

  let(:invalid_attributes) {
    { movie_id: movie.id.to_s, grade: '10' }
  }

  describe 'POST /api/v1/ratings' do
    context 'with success' do
      it 'adds rating to movie' do
        post "/api/v1/ratings", params: valid_attributes
        expect(response).to have_http_status(:created)
        expect(movie.ratings.count).to eq(1)
      end
    end

    context 'with error' do
      it 'returns unprocessable entity status' do
        post "/api/v1/ratings", params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post "/api/v1/ratings", params: invalid_attributes

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).not_to be_empty
      end
    end
  end
end
