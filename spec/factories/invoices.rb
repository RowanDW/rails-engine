FactoryBot.define do
  factory :invoice, class: Invoice do
    status {"in progress"}
    association :customer, factory: :customer
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end

  factory :cancelled_invoice, class: Invoice do
    status {"cancelled"}
    association :customer, factory: :customer
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end

  factory :completed_invoice, class: Invoice do
    status {"completed"}
    association :customer, factory: :customer
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end
end
