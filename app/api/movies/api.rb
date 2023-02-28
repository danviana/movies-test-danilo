module Movies
  class API < Grape::API
    version 'v1', using: :path
    prefix "api"
    format :json

    resource :movies do
      desc 'returns all movies'
      get do
        Movie.all
      end

      desc 'searches a movie using title'
      params do
        requires :title, type: String, desc: 'search term'
      end

      get '/search' do
        movies = Movie.where("title ILIKE '%#{params[:title]}%'")

        return movies if movies.any?

        error! "nothing for this search", :not_found
      end

      desc 'Show information about a particular movie'
      params do
        requires :id, type: Integer, desc: 'movie ID.'
      end

      get '/:id' do
        movie = Movie.find_by_id(params[:id])

        return movie if movie.present?

        error! "movie not found", :not_found
      end

      desc 'Create a movie.'
      params do
        requires :title, type: String, desc: 'Movie title.'
        requires :release_date, type: Date, desc: 'Movie release date'
        optional :runtime, type: String, desc: 'Movie runtime'
        optional :genre, type: String, desc: 'Movie genre'
        optional :parental_rating, type: String, desc: 'Movie'
        optional :plot, type: String, desc: 'Movie'
      end

      post do
        Movie.create!(declared(params))
      rescue StandardError => e
        error! e, :unprocessable_entity
      end

      desc 'Update a movie.'
      params do
        requires :id, type: String, desc: 'Movie id.'
        requires :title, type: String, desc: 'Movie title.'
        requires :release_date, type: Date, desc: 'Movie release date'
        optional :runtime, type: String, desc: 'Movie runtime'
        optional :genre, type: String, desc: 'Movie genre'
        optional :parental_rating, type: String, desc: 'Movie'
        optional :plot, type: String, desc: 'Movie'
      end

      put ':id' do
        movie = Movie.find_by_id(params[:id])

        return movie.update(declared(params)) if movie.present?

        error! "not found", :not_found
      rescue e
        error! e, :unprocessable_entity
      end

      desc 'Delete a movie.'
      params do
        requires :id, type: String, desc: 'movie ID.'
      end
      delete ':id' do
        movie = Movie.find_by_id(params[:id])

        return movie.destroy if movie.present?

        error! "movie not found", :not_found
      rescue e
        error! e, :unprocessable_entity
      end
    end
  end
end
