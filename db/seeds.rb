# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

movies = Movie.create([
  {title: '300', plot: 'A greek action story'},
  {title: 'Lord of the rings', plot: 'A fantasy classic'}
])

seasons = Season.create([
  {title: 'A beginning', plot: 'The first arc of the story'},
  {title: 'The end', plot: 'The last arc of the story'}
])
episodes = Episode.create([
  {title: 'pilot', plot: 'A pilot episode', season: seasons[0], number: 1},
  {title: 'ep1', plot: 'First ep', season: seasons[0], number: 2},
  {title: 'ep2', plot: 'Second ep', season: seasons[0], number: 3},
  {title: 'final', plot: 'ending', season: seasons[1], number: 1}
])

p_opts = PurchaseOpt.create([
  {product: movies[0], price: 12.95, quality: SD},
  {product: movies[0], price: 25.00, quality: HD},
  {product: seasons[0], price: 9.99, quality: SD},
  {product: seasons[0], price: 18.00, quality: HD}
])


users = User.create([
  {email: 'carles@gmail.com'},
  {email: 'david@gmail.com'}
])

purchases = Purchase.create([
  {purchase_opt: p_opts[0], user: users[0], created_at: DateTime.now},
  {purchase_opt: p_opts[2], user: users[0], created_at: DateTime.now - 3.days}
])
