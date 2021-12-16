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

# controllerとそのcontrollerが持つactionをcontrollers変数に定義
controllers = {
  users: ['index', 'show', 'new', 'create', 'destroy', 'update', 'edit'],
  authorizations: ['update', 'edit'],
  static_pages: ['about_server_logs', 'about_activerecord_logs']
}

# authorizationsテーブルへ値を挿入
controllers.each do |controller, actions|
  actions.each { |action| Authorizations.create!(controller: controller, action: action) }
end

# 管理者・遠藤さん用アカウントに全アクセス権限を付与
[admin, endo_san].each do |user|
  Authorizations.all.each do |authorization|
    user.user_authorizations.create!(authorization_id: authorization.id)
  end
end

# テスト用アカウントに一部のアクセス権限を付与
users.each do |user|
  controllers[:users].first(4).each do |action|
    user.user_authorizations.create!(
      authorization_id: Authorizations.find_by(controller: 'users', action: action).id
    )
  end
end
