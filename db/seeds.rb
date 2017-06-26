5.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password,
  standard: true,
  premium: false,
  admin: false
  )
end

3.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password,
  standard: false,
  premium: true,
  admin: false
  )
end

2.times do
  User.create!(
  email: Faker::Internet.email,
  password: Faker::Internet.password,
  standard: false,
  premium: false,
  admin: true
  )
end

users = User.all

100.times do
  Wiki.create!(
  title: Faker::Hipster.sentence,
  body: Faker::Hipster.paragraph,
  private: false
  )
end

wikis = Wiki.all

puts "Seed finished"
puts "#{users.count} users created"
puts "#{wikis.count} wikis created"
