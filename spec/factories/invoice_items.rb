FactoryBot.define do
  factory :invoice_item, class: InvoiceItem do
    quantity { Faker::Number.within(range: 1..100) }
    unit_price  { Faker::Number.within(range: 50..100000) }
    status {"pending"}
    association :invoice, factory: :invoice
    association :item, factory: :item
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end

  factory :packaged_invoice_item, class: InvoiceItem do
    quantity { Faker::Number.within(range: 1..100) }
    unit_price  { Faker::Number.within(range: 50..100000) }
    status {"packaged"}
    association :invoice, factory: :invoice
    association :item, factory: :item
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end

  factory :shipped_invoice_item, class: InvoiceItem do
    quantity { Faker::Number.within(range: 1..100) }
    unit_price  { Faker::Number.within(range: 50..100000) }
    status {"shipped"}
    association :invoice, factory: :invoice
    association :item, factory: :item
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end
end
