require 'rails_helper'

RSpec.describe 'Items find all endpoint' do
  before :each do
    @item1 = create(:item, name: "Dog Book", unit_price: 2)
    @item2 = create(:item, name: "Cat Book", unit_price: 3)
    @item3 = create(:item, name: "Horse Book", unit_price: 4)
    @item4 = create(:item, name: "Dictionary", unit_price: 5)
  end

  it "finds all Items based on name search" do
    get "/api/v1/items/find", params: {name: "Book"}

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data][:attributes][:name]).to eq("Cat Book")
  end

  it "finds all items by price" do
    get "/api/v1/items/find", params: {max_price: 3}
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data][:attributes][:name]).to eq("Cat Book")

    get "/api/v1/items/find", params: {min_price: 3}
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)


    expect(items[:data][:attributes][:name]).to eq("Cat Book")

    get "/api/v1/items/find", params: {min_price: 1, max_price: 3}
    expect(response).to be_successful
    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data][:attributes][:name]).to eq("Cat Book")
  end

  it "returns an error if price and name params given" do
    get "/api/v1/items/find", params: {max_price: 3, name: "Book"}
    expect(response).to have_http_status(:bad_request)
  end

  it "returns an error given bad params" do
    get "/api/v1/items/find"
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/items/find", params: {name: ""}
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/items/find", params: {min_price: 3, max_price: 1}
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/items/find", params: {min_price: -4, max_price: -1}
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/items/find", params: {min_price: -4}
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/items/find", params: {max_price: -4}
    expect(response).to have_http_status(:bad_request)
  end
end
