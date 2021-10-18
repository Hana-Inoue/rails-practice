class User < ApplicationRecord
  enum gender: {
    men: 0,
    women: 1,
    others: 2
  }

  def gender_in_japanese
    case gender
    when 'men'
      '男性'
    when 'women'
      '女性'
    when 'others'
      'その他'
    end
  end
end
