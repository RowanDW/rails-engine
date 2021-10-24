FactoryBot.define do
  factory :transaction, class: Transaction do
    credit_card_number { Faker::Business.credit_card_number }
    result {"success"}
    association :invoice, factory: :invoice
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end

  factory :failed_transaction, class: Transaction do
    credit_card_number { Faker::Business.credit_card_number }
    result {"failed"}
    association :invoice, factory: :invoice
    created_at {"2012-03-27 14:54:09 UTC"}
    updated_at {"2012-03-27 14:54:09 UTC"}
  end
end
