require 'rails_helper'

describe "Merchant endpoint" do
  it "returns a merchant" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/#{merchants[0].id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)
    merchant = merchant[:data]

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)

    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to eq(merchants[0].id)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq("merchant")

    attr = merchant[:attributes]

    expect(attr).to have_key(:name)
    expect(attr[:name]).to eq(merchants[0].name)
  end

  it "returns a 404 error given a bad id input" do
    merchants = create_list(:merchant, 3)

    get "/api/v1/merchants/4875875476867678"

    expect(response).to have_http_status(:not_found)


    get "/api/v1/merchants/abcdefg"

    expect(response).to have_http_status(:not_found)
  end
end
