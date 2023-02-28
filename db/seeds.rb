# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
unless Rails.env.test?
  ActiveRecord::Base.transaction do
    Kernel.puts 'Starting on 200 movies creation'
    FactoryBot.create_list(:movie, 200)
    Kernel.puts 'Movies created successfully'

    Kernel.puts 'Starting on ratings creation'
    Movie.all.each do |movie|
      rand(1..3).times do
        creating_date = (rand(1..365)).days.ago
        FactoryBot.create(:rating, movie: movie, created_at: creating_date, updated_at: creating_date)
      end
    end
    Kernel.puts 'Ratings created successfully'
  end
end