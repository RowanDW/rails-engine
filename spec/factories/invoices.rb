FactoryBot.define do
  factory :invoice, class: Invoice do
    status {"shipped"}
    association :customer, factory: :customer
    association :merchant, factory: :merchant
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end
end
