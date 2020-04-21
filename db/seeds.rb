User.create!(realname: "example",
             name:  "Example User",
             email: "example@railstutorial.org",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  realname = Faker::Name.name
  name  = Faker::Name.name
  email = "example-#{n+1}@railstutorial.org"
  password = "password"
  User.create!(realname: realname,
               name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
#サンプルデータにマイクロポストを追加
image_num_array=[*1..10].shuffle!
users = User.order(:created_at).take(6)
6.times do
  image_num=image_num_array.shift
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content,picture: File.open("#{Rails.root}/db/images_seeds/#{image_num}.jpeg")) }
end
