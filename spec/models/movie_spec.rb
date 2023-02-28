require 'rails_helper'

RSpec.describe Movie, type: :model do
  describe 'associations' do
    it { is_expected.to have_many :ratings }
  end

  describe 'validations' do
    subject { build(:movie) }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:release_date) }
    it { is_expected.to be_valid }
  end

  describe 'enums' do
    it {
      is_expected.to define_enum_for(:genre).with_values(
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
      )
    }

    it {
      is_expected.to define_enum_for(:parental_rating).with_values(
        g: 0,
        pg: 1,
        pg_13: 2,
        r: 3,
        nc_17: 4
      )
    }
  end
end
