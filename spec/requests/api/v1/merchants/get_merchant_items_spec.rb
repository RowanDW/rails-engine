require 'rails_helper'

RSpec.describe 'Merchant items endpoint' do
  it "sends a list of merchants items" do
    merchant1 = create(:merchant)
    merchant2 = create(:merchant)
    merch1_items = create_list(:item, 3, merchant_id: merchant1.id)
    merch2_items = create_list(:item, 3, merchant_id: merchant2.id)

    get "/api/v1/merchants/#{merchant1.id}/items"

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)
      expect(item[:id]).to_not eq(merch2_items[0].id)
      expect(item[:id]).to_not eq(merch2_items[1].id)
      expect(item[:id]).to_not eq(merch2_items[2].id)

      expect(item).to have_key(:type)
      expect(item[:type]).to eq("item")

      attr = item[:attributes]

      expect(attr).to have_key(:name)
      expect(attr[:name]).to be_an(String)

      expect(attr).to have_key(:description)
      expect(attr[:description]).to be_an(String)

      expect(attr).to have_key(:unit_price)
      expect(attr[:unit_price]).to be_an(Float)

      expect(attr).to have_key(:merchant_id)
      expect(attr[:merchant_id]).to be_an Integer
    end
  end

  it "returns an error given a bad merchant id" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/4875875476867678/items"

    expect(response).to have_http_status(:not_found)
  end
end
