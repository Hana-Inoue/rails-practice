class UserAddress < ApplicationRecord
  belongs_to :user

  VALID_POSTAL_CODE_REGEX = /\A\d{3}-\d{4}\z/

  validates :postal_code, presence: true, format: { with: VALID_POSTAL_CODE_REGEX }
  validates :prefecture, presence: true, length: { maximum: 20 }
  validates :city, presence: true, length: { maximum: 50 }
  validates :address_line, presence: true, length: { maximum: 200 }

  def full_address
    prefecture + city + address_line
  end
end
