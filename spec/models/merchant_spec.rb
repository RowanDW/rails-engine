require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe "#search_by_name" do
    it "returns partial matches alphabetically" do
      merchant1 = create(:merchant, name: "Food Shop")
      merchant2 = create(:merchant, name: "Clothing Shop")
      merchant3 = create(:merchant, name: "Toy Shop")
      merchant4 = create(:merchant, name: "Craft Shop")
      merchant5 = create(:merchant, name: "clothing shop")

      merchant = Merchant.search_by_name("shop").first

      expect(merchant.name).to eq('Clothing Shop')
    end
  end

  describe 'class methods' do
    before :each do
      @merch = create_list(:merchant, 7)
      item1 = create(:item, merchant: @merch[0])
      item2 = create(:item, merchant: @merch[0])
      item3 = create(:item, merchant: @merch[0])
      item4 = create(:item, merchant: @merch[1])
      item5 = create(:item, merchant: @merch[2])
      item6 = create(:item, merchant: @merch[3])
      item7 = create(:item, merchant: @merch[4])
      item8 = create(:item, merchant: @merch[5])
      item9 = create(:item, merchant: @merch[6])
      invoices = create_list(:invoice, 9)
      inv_item1 = create(:invoice_item, invoice: invoices[0], item: item1, unit_price: 2000, quantity: 1)
      inv_item2 = create(:invoice_item, invoice: invoices[0], item: item1, unit_price: 1000, quantity: 1)
      inv_item3 = create(:invoice_item, invoice: invoices[1], item: item2, unit_price: 1000, quantity: 1)
      inv_item4 = create(:invoice_item, invoice: invoices[1], item: item2, unit_price: 1000, quantity: 1)
      inv_item5 = create(:invoice_item, invoice: invoices[2], item: item4, unit_price: 1000, quantity: 1)
      inv_item6 = create(:invoice_item, invoice: invoices[3], item: item5, unit_price: 2000, quantity: 2)
      inv_item7 = create(:invoice_item, invoice: invoices[4], item: item6, unit_price: 3000, quantity: 1)
      inv_item8 = create(:invoice_item, invoice: invoices[5], item: item6, unit_price: 2500, quantity: 2)
      inv_item9 = create(:invoice_item, invoice: invoices[5], item: item7, unit_price: 1500, quantity: 2)
      inv_item10 = create(:invoice_item, invoice: invoices[5], item: item8, unit_price: 3500, quantity: 2)
      inv_item11 = create(:invoice_item, invoice: invoices[6], item: item9, unit_price: 3000, quantity: 3)
      inv_item13 = create(:invoice_item, invoice: invoices[8], item: item3, unit_price: 3000, quantity: 3)
      transaction = create(:transaction, invoice: invoices[0])
      transaction2 = create(:transaction, invoice: invoices[1])
      transaction3 = create(:transaction, invoice: invoices[2])
      transaction4 = create(:transaction, invoice: invoices[3])
      transaction5 = create(:transaction, invoice: invoices[4])
      transaction6 = create(:transaction, invoice: invoices[5])
      transaction7 = create(:failed_transaction, invoice: invoices[6])
      transaction8 = create(:failed_transaction, invoice: invoices[4])
    end

    describe "#most_revenue" do
      it "returns x top merchants by revenue" do
        result = Merchant.most_revenue(5)
        expect(result).to eq([@merch[3], @merch[5], @merch[0], @merch[2], @merch[4]])
      end
    end

    describe '#most_items' do
      it "returns x top merchants by items sold" do
        result = Merchant.most_items(5)

        expect(result).to eq([@merch[0], @merch[3], @merch[2], @merch[4], @merch[5]])
      end
    end
  end

  describe 'instance methods' do
    before :each do
      @merch = create(:merchant)
      item = create(:item, merchant: @merch)
      invoice1 = create(:invoice)
      invoice2 = create(:invoice)
      invoice3 = create(:invoice, status: "packaged")

      ii1 = create(:invoice_item, item: item, invoice: invoice1, unit_price: 100, quantity: 2)
      ii2 = create(:invoice_item, item: item, invoice: invoice2, unit_price: 100, quantity: 2)
      ii3 = create(:invoice_item, item: item, invoice: invoice3, unit_price: 100, quantity: 2)

      trans1 = create(:transaction, invoice: invoice1)
      trans2 = create(:failed_transaction, invoice: invoice2)
      trans3 = create(:transaction, invoice: invoice3)
    end

    it "total_revenue" do
      rev = Merchant.total_revenue(@merch.id)
      expect(rev[0].revenue).to eq(200)
    end
  end
end
