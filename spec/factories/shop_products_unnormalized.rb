FactoryBot.define do
  factory :shop_product_unnormalized do
    shop_name { 'shop' }
    product_name { 'product' }
    price { 200 }
  end
end
