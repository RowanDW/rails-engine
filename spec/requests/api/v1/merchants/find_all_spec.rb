require 'rails_helper'

RSpec.describe 'Items find all endpoint' do
  before :each do
    merchant1 = create(:merchant, name: "Food Shop")
    merchant2 = create(:merchant, name: "Clothing Shop")
    merchant3 = create(:merchant, name: "Toy Shop")
  end

  it "finds all Items based on name search" do
    get "/api/v1/merchants/find_all", params: {name: "Shop"}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)
    expect(merchants[:data].first[:attributes][:name]).to eq("Clothing Shop")
  end


  it "returns an error given bad params" do
    get "/api/v1/merchants/find_all"
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/merchants/find_all", params: {name: ""}
    expect(response).to have_http_status(:bad_request)
  end
end
