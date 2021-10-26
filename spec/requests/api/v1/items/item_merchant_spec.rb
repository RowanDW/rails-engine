require 'rails_helper'

describe "Item merchant endpoint" do
  it "returns an items merchant" do
    merchant = create(:merchant, name: "Book Store")
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{item.id}/merchant"

    expect(response).to be_successful

    merch = JSON.parse(response.body, symbolize_names: true)

    expect(merch[:data][:attributes][:name]).to eq("Book Store")
  end

  it "returns an error given bad item id" do
    merchant = create(:merchant, name: "Book Store")
    item = create(:item, merchant_id: merchant.id)

    get "/api/v1/items/#{(item.id + 1)}/merchant"

    expect(response).to have_http_status(:not_found)
  end
end
