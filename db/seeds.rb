# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

  99.times do |n|
    name  = "サンプルユーザー#{n+1}"
    email = "example-#{n+1}@railstutorial.jp"
    password  = "password"
    User.create!(name:     name,
                 email:    email,
                 password: password)
  end
  
  users = User.all
  11.times do |n|
    content = "つぶやきますです#{n+1}。"
    users.each do |user|
      user.microposts.create(content: content)
    end
  end
