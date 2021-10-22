5.times do |number|
  User.create!(
    name: "user#{number + 1}",
    email: "h_inoue2+test-#{number + 1}@ga-tech.co.jp",
    gender: rand(0..2),
    birthday: rand(Date.parse('1950-01-01')..Date.parse('2020-12-31'))
  )
end
