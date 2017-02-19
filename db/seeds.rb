# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

10.times do |n|
    first_name = "UserFirstName"
    middle_initial = "C"
    last_name = "UserLastName"
    birthdate = "2017-02-16"
    email = "collegeBlendUser-#{n+1}@mail.com"
    password = "password"
    User.create!(
            first_name: first_name,
            middle_initial: middle_initial, 
            last_name: last_name,
            birthdate: birthdate,
            email: email, 
            password: password,
            password_confirmation: password)
end
