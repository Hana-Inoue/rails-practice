# 管理者用アカウントの作成
admin = User.create!(
  name: 'admin',
  email: 'h_inoue2+test-0@ga-tech.co.jp',
  gender: 0,
  birthday: '2010-12-31',
  password: 'testtest',
  password_confirmation: 'testtest'
)

# 遠藤さん用アカウントの作成
endo_san = User.create!(
  name: 'a_endo@ga-tech.co.jp',
  email: 'a_endo@ga-tech.co.jp',
  gender: 0,
  birthday: '2020-01-01',
  password: 'a_endo@ga-tech.co.jp',
  password_confirmation: 'a_endo@ga-tech.co.jp'
)

# テスト用アカウントの作成
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

# controller_actionsテーブルへ値を挿入
['index', 'show', 'new', 'edit', 'create', 'update', 'destroy'].each do |action|
  ControllerAction.create!(controller: 'users', action: action)
end
['about_server_logs', 'about_activerecord_logs'].each do |action|
  ControllerAction.create!(controller: 'static_pages', action: action)
end

# 管理者・遠藤さん用アカウントに全アクセス権限を付与
[admin, endo_san].each do |user|
  ControllerAction.all.each do |controller_action|
    user.user_authorizations.create!(controller_action_id: controller_action.id)
  end
end

# テスト用アカウントに一部のアクセス権限を付与
users.each do |user|
  ['index', 'show', 'new', 'create'].map do |action|
    user
      .user_authorizations
      .create!(
        controller_action_id: ControllerAction.find_by(controller: 'users', action: action).id
      )
  end
end
