module UserHelper
  def gender_in_japanese(gender)
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
