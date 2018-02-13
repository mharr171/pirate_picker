require 'faker'

# Create My Account
my_account = User.new(
  username: 'mharr171',
  email:    'mharr171.z@gmail.com',
  password: 'asdf123'
)
my_account.skip_confirmation!
my_account.save!
puts '*'

count = 0
3.times do
  count += 1
  username = "User" + count.to_s
  email = username + "@example.com"
  u = User.new(
    username: username,
    email:    email,
    password: 'asdf123'
  )
  u.skip_confirmation!
  u.save!
  print '*'
end
users = User.all
puts "#{users.count} users created"

10.times do
  name = Faker::Pokemon.name + "-" + Faker::Pokemon.name
  r = Room.new(
    name:       name,
    user:       users.sample,
    game_start: false,
    game_end:   false
  )
  r.save!
  print '*'
end
rooms = Room.all
puts "#{rooms.count} rooms created"
