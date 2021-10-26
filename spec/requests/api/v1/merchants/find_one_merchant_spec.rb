require 'rails_helper'

RSpec.describe 'Merchant Find Endpoint' do
  it "can search for a merchant by name" do
    merchant1 = create(:merchant, name: "Food Shop")
    merchant2 = create(:merchant, name: "Clothing Shop")
    merchant3 = create(:merchant, name: "Toy Shop")

    get "/api/v1/merchants/find", params: {name: "shop"}
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq("Clothing Shop")
  end

  it "returns a null objeect if search has no results" do
    merchant1 = create(:merchant, name: "Food Shop")
    merchant2 = create(:merchant, name: "Clothing Shop")
    merchant3 = create(:merchant, name: "Toy Shop")

    get "/api/v1/merchants/find", params: {name: "nomatch"}
    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant[:data][:attributes][:name]).to eq(nil)
  end

  it "returns an error with a bad search" do
    merchant2 = create(:merchant, name: "Food Shop")
    merchant1 = create(:merchant, name: "Clothing Shop")
    merchant3 = create(:merchant, name: "Toy Shop")

    get "/api/v1/merchants/find"

    expect(response).to have_http_status(:bad_request)

    get "/api/v1/merchants/find", params: {name: ""}

    expect(response).to have_http_status(:bad_request)
  end
end
