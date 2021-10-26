require 'rails_helper'

RSpec.describe Invoice, type: :model do

  describe 'relationships' do
    it { should belong_to(:customer) }
    it { should have_many(:transactions) }
    it { should have_many(:invoice_items) }
    it { should have_many(:items).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  it 'destroy_empties' do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant_id: merchant.id)
    invoices = create_list(:invoice, 3)
    ii_1 = create(:invoice_item, item_id: items[0].id, invoice_id: invoices[0].id)
    ii_2 = create(:invoice_item, item_id: items[0].id, invoice_id: invoices[1].id)
    ii_3 = create(:invoice_item, item_id: items[0].id, invoice_id: invoices[2].id)
    ii_4 = create(:invoice_item, item_id: items[1].id, invoice_id: invoices[1].id)
    ii_5 = create(:invoice_item, item_id: items[2].id, invoice_id: invoices[2].id)

    expect(Invoice.all).to eq([invoices[0], invoices[1], invoices[2]])

    items[0].destroy
    Invoice.destroy_empties

    expect(Invoice.all).to eq([invoices[1], invoices[2]])

    items[1].destroy
    Invoice.destroy_empties

    expect(Invoice.all).to eq([invoices[2]])
  end
end
