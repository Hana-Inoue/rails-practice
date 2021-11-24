admin = User.create!(
  name: 'admin',
  email: 'h_inoue2+test-0@ga-tech.co.jp',
  gender: 0,
  birthday: '2010-12-31',
  password: 'testtest',
  password_confirmation: 'testtest'
)

endo_san = User.create!(
  name: 'a_endo@ga-tech.co.jp',
  email: 'a_endo@ga-tech.co.jp',
  gender: 0,
  birthday: '2020-01-01',
  password: 'a_endo@ga-tech.co.jp',
  password_confirmation: 'a_endo@ga-tech.co.jp'
)

users = (1..5).map do |number|
  User.create!(
    name: "user#{number}",
    email: "h_inoue2+test-#{number}@ga-tech.co.jp",
    gender: rand(0..2),
    birthday: rand(Date.parse('1950-01-01')..Date.parse('2020-12-31')),
    password: 'testtest',
    password_confirmation: 'testtest'
  )
end

['index', 'show', 'new', 'edit', 'create', 'update', 'destroy'].each do |action|
  Action.create!(controller: 'user', action: action)
end

[admin, endo_san].each do |user|
  Action.all.each { |action| user.authorizations.create!(action_id: action.id) }
end

users.each do |user|
  ['index', 'show', 'new', 'create'].map do |action|
    user.authorizations.create!(action_id: Action.find_by(controller: 'user', action: action).id)
  end
end
