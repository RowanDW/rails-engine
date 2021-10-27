class Transaction < ApplicationRecord
  validates :credit_card_number, :result, :created_at, :updated_at, presence: true
  belongs_to :invoice
end
