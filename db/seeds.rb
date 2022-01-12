# 管理者用アカウントの作成
admin = User.create!(
  name: 'admin',
  email: 'h_inoue2+test-0@ga-tech.co.jp',
  gender: 0,
  birthday: '2010-12-31',
  password: 'testtest',
  password_confirmation: 'testtest'
)

# adminアカウントの住所を登録
admin.create_user_address!(
  postal_code: '111-1111',
  prefecture: '埼玉県',
  city: 'さいたま市',
  address_line: 'さいたま1-1-1',
)

# adminアカウントのuser_postsデータを作成
admin_posts = 1.upto(50).map { |number| admin.user_posts.create!(body: "admin ポスト#{number}") }

# 遠藤さん用アカウントの作成
endo_san = User.create!(
  name: 'a_endo@ga-tech.co.jp',
  email: 'a_endo@ga-tech.co.jp',
  gender: 0,
  birthday: '2020-01-01',
  password: 'a_endo@ga-tech.co.jp',
  password_confirmation: 'a_endo@ga-tech.co.jp'
)

# 遠藤さんアカウントの住所を登録
endo_san.create_user_address!(
  postal_code: '222-2222',
  prefecture: '東京都',
  city: '港区',
  address_line: '六本木1-1-1',
)

# 遠藤さんアカウントのuser_postsデータを作成
endo_san_posts =
  1.upto(50).map { |number| endo_san.user_posts.create!(body: "遠藤さん ポスト#{number}") }

# テスト用アカウントの作成
users = (1..25).map do |number|
  User.create!(
    name: "user#{number}",
    email: "h_inoue2+test-#{number}@ga-tech.co.jp",
    gender: rand(0..2),
    birthday: rand(Date.parse('1950-01-01')..Date.parse('2020-12-31')),
    password: 'testtest',
    password_confirmation: 'testtest'
  )
end

# user_posts にコメントを登録
[admin_posts, endo_san_posts].each do |posts|
  posts.first(10).each do |post|
    users.each do |user|
      post.user_post_comments.create(body: "#{user.name} コメント", commented_by: user.name)
    end
  end
end

# tags テーブルへ値を挿入
['fashion', 'music', 'food', 'travel', 'interior', 'recipe'].each do |tag|
  Tag.create!(name: tag)
end

# user_posts にタグを登録
[admin_posts, endo_san_posts].each do |posts|
  posts.first(10).each do |post|
    Tag.first(3).each { |tag| post.user_post_tags.create(tag: tag) }
  end
end

# eventsデータを作成
1.upto(10).map do |number|
  Event.create!(title: "イベント#{number}",
                 body: "これはイベント#{number}です。",
                 max_participants: number * 5,
                 start_at: DateTime.now + number,
                 finish_at: DateTime.now + number + Rational('2/24'),
                 host: 'user')
end

# controllerとそのcontrollerが持つactionをcontrollers変数に定義
controllers = {
  users: ['index', 'show', 'new', 'create', 'destroy', 'update', 'edit'],
  user_addresses: ['destroy', 'update', 'edit'],
  user_posts: ['index', 'new', 'create', 'destroy', 'update', 'edit'],
  user_post_comments: ['index', 'create', 'destroy'],
  events: ['index', 'show', 'new', 'edit', 'create', 'update', 'destroy'],
  authorizations: ['update', 'edit'],
  static_pages: ['about_server_logs', 'about_activerecord_logs']
}

# authorizationsテーブルへ値を挿入
controllers.each do |controller, actions|
  actions.each { |action| Authorization.create!(controller: controller, action: action) }
end

# 管理者・遠藤さん用アカウントに全アクセス権限を付与
[admin, endo_san].each do |user|
  Authorization.all.each do |authorization|
    user.user_authorizations.create!(authorization_id: authorization.id)
  end
end

# テスト用アカウントに一部のアクセス権限を付与
users.each do |user|
  controllers[:users].first(4).each do |action|
    user.user_authorizations.create!(
      authorization_id: Authorization.find_by(controller: 'users', action: action).id
    )
  end
  controllers[:user_addresses].each do |action|
    user.user_authorizations.create!(
      authorization_id: Authorization.find_by(controller: 'user_addresses', action: action).id
    )
  end
  controllers[:user_posts].each do |action|
    user.user_authorizations.create!(
      authorization_id: Authorization.find_by(controller: 'user_posts', action: action).id
    )
  end
  controllers[:user_post_comments].each do |action|
    user.user_authorizations.create!(
      authorization_id: Authorization.find_by(controller: 'user_post_comments', action: action).id
    )
  end
  controllers[:events].each do |action|
    user.user_authorizations.create!(
      authorization_id: Authorization.find_by(controller: 'events', action: action).id
    )
  end
end
