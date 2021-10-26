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

  it "destroys all invoices with only the item" do
    merchant = create(:merchant)
    items = create_list(:item, 3, merchant_id: merchant.id)
    invoices = create_list(:invoice, 3)
    ii_1 = create(:invoice_item, item_id: items[0].id, invoice_id: invoices[0].id)
    ii_2 = create(:invoice_item, item_id: items[0].id, invoice_id: invoices[1].id)
    ii_3 = create(:invoice_item, item_id: items[0].id, invoice_id: invoices[2].id)
    ii_4 = create(:invoice_item, item_id: items[1].id, invoice_id: invoices[1].id)
    ii_5 = create(:invoice_item, item_id: items[2].id, invoice_id: invoices[2].id)

    expect(Invoice.all).to eq([invoices[0], invoices[1], invoices[2]])

    delete "/api/v1/items/#{items[0].id}"

    expect(Invoice.all).to eq([invoices[1], invoices[2]])

    delete "/api/v1/items/#{items[1].id}"

    expect(Invoice.all).to eq([invoices[2]])
  end
end
