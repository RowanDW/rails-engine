class InvoiceItem < ApplicationRecord
  validates :quantity, :unit_price, :created_at, :updated_at, presence: true
  belongs_to :item
  belongs_to :invoice

  def self.revenue_dates(start_date, end_date)
    joins(invoice: :transactions)
    .where(transactions: {result: "success"})
    .where(invoices: {status: "shipped"})
    .where(invoices: {created_at: start_date...end_date.to_date.end_of_day})
    .select('SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue')
  end
end
