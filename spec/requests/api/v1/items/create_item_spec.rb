require 'rails_helper'

describe "create item endpoint" do
  it "can create an item" do
    merchant = create(:merchant)
    item_params = { name: "Thing", description: "Its a thing", unit_price: 22.0, merchant_id: merchant.id}

    post '/api/v1/items', params: { item: item_params}
    item = Item.last

    expect(response).to have_http_status(:created)
    expect(item.name).to eq(item_params[:name])

    new_item = JSON.parse(response.body, symbolize_names: true)
    expect(new_item[:data]).to have_key(:attributes)
    expect(new_item[:data]).to have_key(:id)
    expect(new_item[:data]).to have_key(:type)
  end

  it "create item sad path" do
    merchant = create(:merchant)
    item_params = { description: "Its a thing", unit_price: 22.0, merchant_id: merchant.id}

    post '/api/v1/items', params: { item: item_params}

    expect(response).to have_http_status(:bad_request)

    message = JSON.parse(response.body, symbolize_names: true)
    expect(message).to have_key(:status)
    expect(message[:status]).to eq('bad_request')

    expect(message).to have_key(:code)
    expect(message[:code]).to eq(400)

    expect(message).to have_key(:message)
    expect(message[:message]).to eq("Invalid Item inputs")
  end
end
