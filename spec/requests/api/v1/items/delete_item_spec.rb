require 'rails_helper'

describe "delete item endpoint" do
  it "can delete an item" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id}"

    expect(response).to be_successful
    expect(Item.count).to eq(0)
  end

  it "returns an error given bad item id" do
    item = create(:item)

    expect(Item.count).to eq(1)

    delete "/api/v1/items/#{item.id + 1}"

    expect(response).to have_http_status(:not_found)

    message = JSON.parse(response.body, symbolize_names: true)

    expect(message).to have_key(:message)
    expect(message[:message]).to eq("Item does not exist")
  end
end
