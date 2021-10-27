class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  validates :name, presence: true

  enum status: [:disabled, :enabled]

  def self.search_by_name(search_params)
    where("name ILIKE ?", "%#{search_params}%").order(name: :asc)
  end

  def self.most_revenue(limit)
    joins(invoices: :transactions)
    .where('transactions.result = ?', "success")
    .select('merchants.*, SUM(invoice_items.unit_price*invoice_items.quantity) AS revenue')
    .group(:id)
    .order(revenue: :desc)
    .limit(limit)
  end

  def self.most_items(limit = 5)
    joins(invoices: :transactions)
    .where('transactions.result = ?', "success")
    .select('merchants.*, SUM(invoice_items.quantity) AS count')
    .group(:id)
    .order("count DESC")
    .limit(limit)
  end
end
