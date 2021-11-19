User.create!(
  name: 'admin',
  email: 'h_inoue2+test-0@ga-tech.co.jp',
  gender: 0,
  birthday: '2010-12-31',
  password: 'testtest',
  password_confirmation: 'testtest',
  index_action: true,
  show_action: true,
  new_action: true,
  edit_action: true,
  create_action: true,
  update_action: true,
  destroy_action: true
)

5.times do |number|
  User.create!(
    name: "user#{number + 1}",
    email: "h_inoue2+test-#{number + 1}@ga-tech.co.jp",
    gender: rand(0..2),
    birthday: rand(Date.parse('1950-01-01')..Date.parse('2020-12-31')),
    password: 'testtest',
    password_confirmation: 'testtest'
  )
end

User.create!(
  name: 'a_endo@ga-tech.co.jp',
  email: 'a_endo@ga-tech.co.jp',
  gender: 0,
  birthday: '2020-01-01',
  password: 'a_endo@ga-tech.co.jp',
  password_confirmation: 'a_endo@ga-tech.co.jp',
  index_action: true,
  show_action: true,
  new_action: true,
  edit_action: true,
  create_action: true,
  update_action: true,
  destroy_action: true
)
