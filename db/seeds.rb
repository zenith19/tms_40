## supervisors
 User.create!(first_name: "test",
              last_name: "test",
              email: "test@test.com",
              password: "password",
              supervisor: true)
 User.create!(first_name: "test1",
              last_name: "test1",
              email: "test1@test.com",
              password: "password",
              supervisor: true)
## trainees
99.times do |n|
  first_name = Faker::Name.first_name
  last_name =  Faker::Name.last_name
  email = "example-#{n+1}@test.com"
  password = "password"
  User.create!(first_name:  first_name,
               last_name: last_name,
               email: email,
               password: password)
end
