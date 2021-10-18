class User < ApplicationRecord
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

  enum gender: {
    men: 0,
    women: 1,
    others: 2
  }

  validates :name, presence: true, length: { maximum: 30 }, uniqueness: { case_sensitive: true }
  validates :email,
            presence: true,
            format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :gender, presence: true, inclusion: { in: genders.keys }
  validates :birthday, presence: true

  before_save { downcase_email }

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

  private

  def downcase_email
    email.downcase!
  end
end
