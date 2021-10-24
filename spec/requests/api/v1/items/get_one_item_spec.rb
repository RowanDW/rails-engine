require 'rails_helper'

describe "Item endpoint" do
  it "returns an item" do
    items = create_list(:item, 3)

    get "/api/v1/items/#{items[0].id}"

    expect(response).to be_successful

    item = JSON.parse(response.body, symbolize_names: true)
    item = item[:data]

    expect(item).to have_key(:attributes)
    expect(item[:attributes]).to be_an(Hash)

    expect(item).to have_key(:id)
    expect(item[:id].to_i).to eq(items[0].id)

    expect(item).to have_key(:type)
    expect(item[:type]).to eq("item")

    attr = item[:attributes]

    expect(attr).to have_key(:name)
    expect(attr[:name]).to eq(items[0].name)

    expect(attr).to have_key(:description)
    expect(attr[:description]).to eq(items[0].description)

    expect(attr).to have_key(:unit_price)
    expect(attr[:unit_price]).to eq(items[0].unit_price)

    expect(attr).to have_key(:merchant_id)
    expect(attr[:merchant_id]).to eq(items[0].merchant_id)
  end

  it "returns a 404 error given a bad id input" do
    items = create_list(:item, 3)

    get "/api/v1/items/4875875476867678"

    expect(response).to have_http_status(:not_found)


    get "/api/v1/items/abcdefg"

    expect(response).to have_http_status(:not_found)
  end
end
