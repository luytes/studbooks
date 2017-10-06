require "yaml"
require "open-uri"

puts 'Cleaning database...'
Book.destroy_all
User.destroy_all

password = Faker::Internet.password(8)
FIELD = ["Math", "Chemistry", "Engineering", "Science"]
GENDER = ["men", "women"]
NUMBER = (0..99)
UNIVERSITY = ["ETH", "University of Berlin"]
COUNTRY = ["Germany", "Afghanistan", "England", "China", "Japan"]

# SEEDING USERS
puts 'Creating Users...'
3.times do
  u = User.new(
    email: Faker::Internet.email,
    password: password,
    password_confirmation: password,
    first_name: Faker::Name.first_name,
    last_name: Faker::Name.last_name,
    gender: GENDER.sample,
    age: rand(18..30),
    university: UNIVERSITY.sample,
    country: COUNTRY.sample
    )
  u.remote_picture_url = "https://randomuser.me/api/portraits/#{GENDER.sample}/#{rand(NUMBER)}.jpg"
  u.save!
end

puts 'Creating Books...'

Book.create!(
    title: FIELD.sample,
    author: "Albert Einstein",
    field: FIELD.sample,
    remote_picture_url: "https://ksr-ugc.imgix.net/assets/016/205/161/dc52b24cf918b327820fe59cd9286b66_original.png?w=680&fit=max&v=1491844850&auto=format&lossless=true&s=e9f5719089c4b5dd161ccb69fe2958e0",
    owner: User.all.sample,
    condition: 'bad',
    price: 10,
    publish_year: "April 24th, 2007",
  )

Book.create!(
    title: FIELD.sample,
    author: "John Wick",
    field: FIELD.sample,
    remote_picture_url: "https://ksr-ugc.imgix.net/assets/016/118/731/1e64c31529f786fee57fb6b78125b995_original.jpg?w=680&fit=max&v=1491248233&auto=format&q=92&s=38783ac2eadede486bb5f2348ed7674b",
    owner: User.all.sample,
    condition: 'like new',
    price: 22,
    publish_year: "April 25th, 2007",
  )

Book.create!(
    title: FIELD.sample,
    author: "Philipp Klink",
    field: FIELD.sample,
    remote_picture_url: "https://ksr-ugc.imgix.net/assets/016/063/697/187f0c894fa55e864f0bdfea333c5706_original.png?w=680&fit=max&v=1490870733&auto=format&lossless=true&s=241882d4b02654f5c98012859b9a8b00",
    owner: User.all.sample,
    condition: 'ok',
    price: 5,
    publish_year: "April 26th, 2007",
  )

Book.create!(
    title: FIELD.sample,
    author: "Peter Griffin",
    field: FIELD.sample,
    remote_picture_url: "https://ksr-ugc.imgix.net/assets/016/481/464/84ac7de1832e19a38cb480e70672cd7f_original.jpg?w=680&fit=max&v=1493666758&auto=format&q=92&s=5aa629f3e0622619194178a49a28a02e",
    owner: User.all.sample,
    condition: 'good',
    price: 26,
    publish_year: "April 28th, 2007",
  )


Book.create!(
    title: FIELD.sample,
    author: "Ash Ketchum",
    field: FIELD.sample,
    remote_picture_url: "https://ksr-ugc.imgix.net/assets/016/316/565/cff9e7bdc4eb8fefbfb5c0e47e179a43_original.png?w=680&fit=max&v=1492614995&auto=format&lossless=true&s=0cbd8b4a2669c9b24a015a34fa1a3260",
    owner: User.all.sample,
    condition: 'used',
    price: 12,
    publish_year: "April 25th, 2016",
  )

Book.create(
    title: FIELD.sample,
    author: "Takoto Kino",
    field: FIELD.sample,
    remote_picture_url: "https://ksr-ugc.imgix.net/assets/003/775/929/314c481354d012aa67852eea7128c053_original.jpg?w=680&fit=max&v=1431418793&auto=format&q=92&s=832da987e7c9422848130e269bfd3449",
    owner: User.all.sample,
    condition: 'good',
    price: 8,
    publish_year: "April 25th, 2007",
  )

puts 'Finished!'

