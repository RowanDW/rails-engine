FactoryBot.define do
  factory :merchant, class: Merchant do
    name { Faker::Commerce.brand }
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end
end
