User.create!(
  name: 'admin',
  email: 'h_inoue2+test-0@ga-tech.co.jp',
  gender: 0,
  birthday: '2010-12-31',
  password: 'testtest',
  password_confirmation: 'testtest'
)

User.create!(
  name: 'a_endo@ga-tech.co.jp',
  email: 'a_endo@ga-tech.co.jp',
  gender: 0,
  birthday: '2020-01-01',
  password: 'a_endo@ga-tech.co.jp',
  password_confirmation: 'a_endo@ga-tech.co.jp'
)

(1..5).each do |number|
  User.create!(
    name: "user#{number}",
    email: "h_inoue2+test-#{number}@ga-tech.co.jp",
    gender: rand(0..2),
    birthday: rand(Date.parse('1950-01-01')..Date.parse('2020-12-31')),
    password: 'testtest',
    password_confirmation: 'testtest'
  )
end

admin = User.find_by(email: 'h_inoue2+test-0@ga-tech.co.jp')
Authorization.actions.each_key do |key|
  admin.authorizations.create!(action: key)
end

endo_san = User.find_by(email: 'a_endo@ga-tech.co.jp')
Authorization.actions.each_key do |key|
  endo_san.authorizations.create!(action: key)
end

users = (1..5).map { |number| User.find_by(email: "h_inoue2+test-#{number}@ga-tech.co.jp") }
users.each do |user|
  ['index_action', 'show_action', 'new_action', 'create_action'].each do |action|
    user.authorizations.create!(action: action)
  end
end
