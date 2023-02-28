require 'rails_helper'

RSpec.describe Movies::API do
  let!(:movie) { Movie.create(title: "teste", release_date: Date.today) }
  let!(:movie2) { Movie.create(title: "teste2", release_date: Date.tomorrow) }

  let(:valid_attributes) {
    { title: 'Any Name', release_date: Date.yesterday }
  }

  let(:invalid_attributes) {
    { title: '', release_date: '' }
  }

  describe 'GET /api/v1/movies' do
    it 'returns all movies' do
      get "/api/v1/movies/"
      expect(response).to have_http_status(:ok)
      expect(response.body).to include("teste")
      expect(response.body).to include("teste2")
    end
  end

  describe 'GET /api/v1/movies/search' do
    context 'with success' do
      it 'returns searched movie' do
        get '/api/v1/movies/search?title=2'
        expect(response).to have_http_status(:ok)
        expect(response.body).to include('teste2')
      end
    end

    context 'with error' do
      it 'returns not found status' do
        get '/api/v1/movies/search?title=foo'

        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        get '/api/v1/movies/search?title=foo'

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('nothing for this search')
      end
    end
  end

  describe 'GET /api/v1/movies/:id' do
    context 'with success' do
      it 'returns movie using id' do
        get "/api/v1/movies/#{movie2.id}"
        expect(response).to have_http_status(:ok)
        expect(response.body).to include("teste2")
      end
    end

    context 'with error' do
      it 'returns not found status' do
        get '/api/v1/movies/123'

        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        get '/api/v1/movies/123'

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('movie not found')
      end
    end
  end

  describe 'POST /api/v1/movies' do
    context 'with success' do
      it 'returns created movie' do
        post '/api/v1/movies', params: valid_attributes

        expect(response).to have_http_status(:created)
        expect(Movie.count).to eq(3)
      end
    end

    context 'with error' do
      it 'returns unprocessable entity status' do
        post '/api/v1/movies', params: invalid_attributes

        expect(response).to have_http_status(:unprocessable_entity)
      end

      it 'returns error message' do
        post '/api/v1/movies', params: invalid_attributes

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).not_to be_empty
      end
    end
  end

  describe 'DELETE /api/v1/movies' do
    context 'with success' do
      it 'remove movie' do
        delete "/api/v1/movies/#{movie2.id}"
        expect(response).to have_http_status(:ok)
        expect(Movie.count).to eq(1)
      end
    end

    context 'with error' do
      it 'returns not found status' do
        delete '/api/v1/movies/123'

        expect(response).to have_http_status(:not_found)
      end

      it 'returns error message' do
        delete '/api/v1/movies/123'

        parsed_body = JSON.parse(response.body)
        expect(parsed_body['error']).to eq('movie not found')
      end
    end
  end
end
