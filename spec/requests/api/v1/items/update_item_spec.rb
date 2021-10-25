require 'rails_helper'

describe "update item endpoint" do
  it "can update an existing item" do
    item = create(:item)
    item_params = { name: "Thing"}

    put "/api/v1/items/#{item.id}", params: { item: item_params}

    expect(response).to be_successful
  end

  it "returns an error given bad merchant id" do
    item = create(:item)
    item_params = { name: "Thing", merchant_id: 123748}

    put "/api/v1/items/#{item.id}", params: { item: item_params}
    expect(response).to have_http_status(:bad_request)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:message)
    expect(message[:message]).to eq("Invalid Item inputs")
  end

  it "returns an error given bad item id" do
    item = create(:item)
    item_params = { name: "Thing"}

    put "/api/v1/items/1234566", params: { item: item_params}

    expect(response).to have_http_status(:not_found)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:message)
    expect(message[:message]).to eq("Item does not exist")
  end
end
