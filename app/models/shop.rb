class Shop < ApplicationRecord
  has_many :shop_products, dependent: :destroy

  validates :name, presence: true, length: { maximum: 30 }
end
