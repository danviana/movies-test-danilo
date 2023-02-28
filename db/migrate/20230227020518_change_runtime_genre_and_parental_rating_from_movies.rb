class ChangeRuntimeGenreAndParentalRatingFromMovies < ActiveRecord::Migration[6.1]
  def change
    reversible do |direction|
      change_table :movies do |t|
        direction.up {
          t.change :runtime, :integer, using: 'runtime::integer'
          t.change :genre, :integer, using: 'genre::integer'
          t.change :parental_rating, :integer, using: 'parental_rating::integer'
        }
        direction.down {
          t.change :runtime, :string
          t.change :genre, :string
          t.change :parental_rating, :string
        }
      end
    end
  end
end
