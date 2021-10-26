class Merchant < ApplicationRecord
  has_many :items, dependent: :destroy
  has_many :invoices, through: :items
  validates :name, presence: true

  enum status: [:disabled, :enabled]

  def self.search_by_name(search_params)
    where("name ILIKE ?", "%#{search_params}%").order(name: :asc)
  end
end
