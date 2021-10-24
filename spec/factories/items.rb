FactoryBot.define do
  factory :item, class: Item do
    name { Faker::Commerce.product_name }
    description { Faker::Lorem.sentence }
    unit_price  { Faker::Number.within(range: 50..100000) }
    association :merchant, factory: :merchant
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end
end
