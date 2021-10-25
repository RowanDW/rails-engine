class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items, dependent: :destroy
  validates :name, :description, :unit_price, presence: true
  validates_associated :merchant
  enum status: [:disabled, :enabled]
end
