require 'rails_helper'

describe "Merchants endpoint" do
  it "sends a list of merchants" do
    create_list(:merchant, 3)

    get '/api/v1/merchants'

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(3)

    merchants[:data].each do |merchant|
      expect(merchant).to have_key(:attributes)
      expect(merchant[:attributes]).to be_an(Hash)

      expect(merchant).to have_key(:id)
      expect(merchant[:id]).to be_an(String)

      expect(merchant).to have_key(:type)
      expect(merchant[:type]).to eq("merchant")

      attr = merchant[:attributes]

      expect(attr).to have_key(:name)
      expect(attr[:name]).to be_an(String)
    end
  end

  it "returns a subset of items based on per_page and page" do
    merchants = create_list(:merchant, 25)

    get '/api/v1/merchants', params: {per_page: 1, page: 1}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(1)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(merchants[0].name)

    get '/api/v1/merchants', params: {per_page: 2, page: 2}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(2)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(merchants[2].name)


    get '/api/v1/merchants'

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(20)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(merchants[0].name)
  end

  it "returns default per page and page if given bad inputs" do
    merchants = create_list(:merchant, 25)

    get '/api/v1/merchants', params: {per_page: - 20, page: - 1}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(20)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(merchants[0].name)

    get '/api/v1/merchants', params: {per_page: "abc", page: "a"}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(20)

    attr = result[:data][0][:attributes]

    expect(attr[:name]).to eq(merchants[0].name)
  end

  it "returns empty array if no results" do
    merchants = create_list(:merchant, 25)

    get '/api/v1/merchants', params: {per_page: 20, page: 3}

    expect(response).to be_successful

    result = JSON.parse(response.body, symbolize_names: true)

    expect(result[:data].count).to eq(0)
  end
end
