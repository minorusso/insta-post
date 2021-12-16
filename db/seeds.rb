50.times do |_n|
  name = Faker::Games::Pokemon.name
  email = Faker::Internet.email
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password)
end
