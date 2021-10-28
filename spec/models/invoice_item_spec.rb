require 'rails_helper'

RSpec.describe InvoiceItem do
  describe 'relationships' do
    it { should belong_to(:item) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_presence_of(:created_at) }
    it { should validate_presence_of(:updated_at) }
  end

  describe 'class methods' do
    before :each do
      invoice1 = create(:invoice, created_at: "2012-03-08")
      invoice2 = create(:invoice, created_at: "2012-03-09")
      invoice3 = create(:invoice, created_at: "2012-03-10")
      invoice4 = create(:invoice, created_at: "2012-03-11")
      invoice5 = create(:invoice, created_at: "2012-03-12")
      invoice6 = create(:invoice, status: "packaged", created_at: "2012-03-12")

      ii1 = create(:invoice_item, invoice: invoice1, unit_price: 100, quantity: 2)
      ii2 = create(:invoice_item, invoice: invoice2, unit_price: 100, quantity: 2)
      ii3 = create(:invoice_item, invoice: invoice3, unit_price: 100, quantity: 2)
      ii4 = create(:invoice_item, invoice: invoice4, unit_price: 100, quantity: 2)
      ii5 = create(:invoice_item, invoice: invoice5, unit_price: 100, quantity: 2)
      ii6 = create(:invoice_item, invoice: invoice6, unit_price: 100, quantity: 2)

      trans1 = create(:transaction, invoice: invoice1)
      trans2 = create(:transaction, invoice: invoice2)
      trans3 = create(:transaction, invoice: invoice3)
      trans4 = create(:transaction, invoice: invoice4)
      trans5 = create(:failed_transaction, invoice: invoice5)
      trans6 = create(:transaction, invoice: invoice6)
    end

    describe '#revenue_dates' do
      it "returns total revenue between given dates" do
        result = InvoiceItem.revenue_dates("2012-03-09", "2012-03-12")
        expect(result[0].revenue).to eq(600)
      end
    end
  end
end
