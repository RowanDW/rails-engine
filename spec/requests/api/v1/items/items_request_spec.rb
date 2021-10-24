require 'rails_helper'

describe "Items endpoint" do
  it "sends a list of items" do
    create_list(:item, 3)

    get '/api/v1/items'

    expect(response).to be_successful

    items = JSON.parse(response.body, symbolize_names: true)

    expect(items[:data].count).to eq(3)

    items[:data].each do |item|
      expect(item).to have_key(:attributes)
      expect(item[:attributes]).to be_an(Hash)

      expect(item).to have_key(:id)
      expect(item[:id]).to be_an(String)

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
      expect(attr[:merchant_id]).to be_an(Integer)
    end
  end

  it "returns a subset of items based on per_page and page" do
    items = create_list(:item, 25)

    get '/api/v1/items', params: {per_page: 1, page: 1}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(1)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(items[0].name)
    expect(attr[:description]).to eq(items[0].description)
    expect(attr[:unit_price]).to eq(items[0].unit_price)
    expect(attr[:merchant_id]).to eq(items[0].merchant_id)


    get '/api/v1/items', params: {per_page: 2, page: 2}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(2)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(items[2].name)
    expect(attr[:description]).to eq(items[2].description)
    expect(attr[:unit_price]).to eq(items[2].unit_price)
    expect(attr[:merchant_id]).to eq(items[2].merchant_id)

    get '/api/v1/items'

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(20)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(items[0].name)
    expect(attr[:description]).to eq(items[0].description)
    expect(attr[:unit_price]).to eq(items[0].unit_price)
    expect(attr[:merchant_id]).to eq(items[0].merchant_id)
  end

  it "returns default per page and page if given bad inputs" do
    items = create_list(:item, 25)

    get '/api/v1/items', params: {per_page: - 20, page: - 1}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(20)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(items[0].name)
    expect(attr[:description]).to eq(items[0].description)
    expect(attr[:unit_price]).to eq(items[0].unit_price)
    expect(attr[:merchant_id]).to eq(items[0].merchant_id)

    get '/api/v1/items', params: {per_page: "abc", page: "a"}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(20)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(items[0].name)
    expect(attr[:description]).to eq(items[0].description)
    expect(attr[:unit_price]).to eq(items[0].unit_price)
    expect(attr[:merchant_id]).to eq(items[0].merchant_id)
  end

  it "returns empty array if no results" do
    items = create_list(:item, 25)

    get '/api/v1/items', params: {per_page: 20, page: 3}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(0)
  end
end
