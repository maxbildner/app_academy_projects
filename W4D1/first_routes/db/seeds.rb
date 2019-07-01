# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# USERS

vg = User.create(username: 'van_gogh')
mon = User.create(username: 'monet')
war = User.create(username: 'warhol')

# ARTWORKS

starry = Artwork.create(title: 'Starry Night', image_url: 'scoobydoo.com', artist_id: 13)
poppies = Artwork.create(title: 'Poppies', image_url: 'poppies.com', artist_id: 14)
soup = Artwork.create(title: 'Campbell Soup', image_url: 'campbellsoup.com', artist_id: 15)
