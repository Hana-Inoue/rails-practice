class ProductBeforeNormalized < ApplicationRecord
  validates :shop_name, presence: true, length: { maximum: 30 }
  validates :product_name, presence: true, length: { maximum: 30 }
  validates :price, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
