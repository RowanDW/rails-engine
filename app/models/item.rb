class Item < ApplicationRecord
  belongs_to :merchant
  has_many :invoice_items, dependent: :destroy
  has_many :invoices, through: :invoice_items
  validates :name, :description, :unit_price, presence: true
  validates_associated :merchant
  enum status: [:disabled, :enabled]

  def self.search_by_name(search_params)
    where("name ILIKE ?", "%#{search_params}%").order(name: :asc)
  end

  def self.search_by_price(min = 0, max = 0)
    if max == 0
      where("unit_price >= #{min}").order(:name)
    else
      where(unit_price: min..max).order(:name)
    end
  end
end
