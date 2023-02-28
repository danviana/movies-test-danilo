class Movie < ApplicationRecord
  has_many :ratings

  validates :title, :release_date, presence: true, allow_blank: false

  enum genre: {
    action: 0,
    adventure: 1,
    animated: 2,
    comedy: 3,
    drama: 4,
    fantasy: 5,
    historical: 6,
    horror: 7,
    musical: 8,
    romance: 9,
    science_fiction: 10,
    thriller: 11,
    western: 12
  }

  enum parental_rating: {
    g: 0,
    pg: 1,
    pg_13: 2,
    r: 3,
    nc_17: 4
  }
end
