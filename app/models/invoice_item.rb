class InvoiceItem < ApplicationRecord
validates :quantity, :unit_price, :created_at, :updated_at, presence: true
  belongs_to :item
  belongs_to :invoice
end
