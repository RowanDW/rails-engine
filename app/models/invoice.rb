class Invoice < ApplicationRecord
  belongs_to :customer
  belongs_to :merchant
  has_many :transactions
  has_many :invoice_items, dependent: :destroy
  has_many :items, through: :invoice_items

  validates :customer_id, :merchant_id, :created_at, :updated_at, presence: true

  enum status: [:shipped]
  
  def self.destroy_empties
    invoices = Invoice.left_outer_joins(:invoice_items).where(invoice_items: {id: nil})
    invoices.destroy_all
  end
end
