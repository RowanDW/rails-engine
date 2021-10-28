require 'rails_helper'

RSpec.describe Item do
  describe 'relationships' do
    it { should belong_to(:merchant) }
    it { should have_many(:invoice_items) }
    it { should have_many(:invoices).through(:invoice_items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_presence_of(:unit_price) }
  end

  describe 'class methods' do
    before :each do
      @item1 = create(:item, name: "Dog Book", unit_price: 2)
      @item2 = create(:item, name: "Cat Book", unit_price: 3)
      @item3 = create(:item, name: "Horse Book", unit_price: 4)
      @item4 = create(:item, name: "Dictionary", unit_price: 5)
    end
    describe "#search_by_name" do
      it "returns partial matches alphabetically" do

        items = Item.search_by_name("book")

        expect(items.count).to eq(3)
        expect(items.first.name).to eq("Cat Book")
      end
    end

    describe "#search_by_price" do
      it "returns price searches matches alphabetically" do
        items = Item.search_by_price(3, 4)

        expect(items.count).to eq(2)
        expect(items.first.name).to eq("Cat Book")

        items = Item.search_by_price(4, 20)

        expect(items.count).to eq(2)
        expect(items.first.name).to eq("Dictionary")
      end
    end
  end
end
