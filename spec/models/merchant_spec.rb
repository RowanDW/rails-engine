require 'rails_helper'

RSpec.describe Merchant do
  describe 'relationships' do
    it { should have_many(:items) }
    it { should have_many(:invoices).through :items }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
  end

  describe 'class methods' do
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
  end
end
