# #Create Users
#
# 5.times do
#   user = User.create!(
#   email:    Faker::Internet.email,
#   password: Faker::Pokemon.name
#   )
# end
# users = User.all
#
# #create wikis
# 50.times do
#   wiki.create!(
#   title: Faker::Hipster.sentence
#   body: Faker::Hipster.paragraph
#   )
# end
# wikis = Wiki.all
#
# puts "Seed finished"
# puts "#{User.count} users created."
# puts "#{Wiki.count} posts created."
