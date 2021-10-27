require 'rails_helper'

describe "Merchants with most items sold endpoint" do
  before :each do
    @merch = create_list(:merchant, 7)
    item1 = create(:item, merchant: @merch[0])
    item2 = create(:item, merchant: @merch[0])
    item3 = create(:item, merchant: @merch[0])
    item4 = create(:item, merchant: @merch[1])
    item5 = create(:item, merchant: @merch[2])
    item6 = create(:item, merchant: @merch[3])
    item7 = create(:item, merchant: @merch[4])
    item8 = create(:item, merchant: @merch[5])
    item9 = create(:item, merchant: @merch[6])
    invoices = create_list(:invoice, 9)
    inv_item1 = create(:invoice_item, invoice: invoices[0], item: item1, unit_price: 2000, quantity: 1)
    inv_item2 = create(:invoice_item, invoice: invoices[0], item: item1, unit_price: 1000, quantity: 1)
    inv_item3 = create(:invoice_item, invoice: invoices[1], item: item2, unit_price: 1000, quantity: 1)
    inv_item4 = create(:invoice_item, invoice: invoices[1], item: item2, unit_price: 1000, quantity: 1)
    inv_item5 = create(:invoice_item, invoice: invoices[2], item: item4, unit_price: 1000, quantity: 1)
    inv_item6 = create(:invoice_item, invoice: invoices[3], item: item5, unit_price: 2000, quantity: 2)
    inv_item7 = create(:invoice_item, invoice: invoices[4], item: item6, unit_price: 3000, quantity: 1)
    inv_item8 = create(:invoice_item, invoice: invoices[5], item: item6, unit_price: 2500, quantity: 2)
    inv_item9 = create(:invoice_item, invoice: invoices[5], item: item7, unit_price: 1500, quantity: 2)
    inv_item10 = create(:invoice_item, invoice: invoices[5], item: item8, unit_price: 3500, quantity: 2)
    inv_item11 = create(:invoice_item, invoice: invoices[6], item: item9, unit_price: 3000, quantity: 3)
    inv_item13 = create(:invoice_item, invoice: invoices[8], item: item3, unit_price: 3000, quantity: 3)
    transaction = create(:transaction, invoice: invoices[0])
    transaction2 = create(:transaction, invoice: invoices[1])
    transaction3 = create(:transaction, invoice: invoices[2])
    transaction4 = create(:transaction, invoice: invoices[3])
    transaction5 = create(:transaction, invoice: invoices[4])
    transaction6 = create(:transaction, invoice: invoices[5])
    transaction7 = create(:failed_transaction, invoice: invoices[6])
    transaction8 = create(:failed_transaction, invoice: invoices[4])
  end

  it "sends a list of merchants" do
    get "/api/v1/merchants/most_items", params: {quantity: 5}

    expect(response).to be_successful

    merchants = JSON.parse(response.body, symbolize_names: true)

    expect(merchants[:data].count).to eq(5)
    expect(merchants[:data][0][:id].to_i).to eq(@merch[0].id)
    expect(merchants[:data][0][:attributes][:count]).to eq(4)

    expect(merchants[:data][1][:id].to_i).to eq(@merch[3].id)
    expect(merchants[:data][1][:attributes][:count]).to eq(3)

    expect(merchants[:data][2][:id].to_i).to eq(@merch[2].id)
    expect(merchants[:data][2][:attributes][:count]).to eq(2)

    expect(merchants[:data][3][:id].to_i).to eq(@merch[4].id)
    expect(merchants[:data][3][:attributes][:count]).to eq(2)

    expect(merchants[:data][4][:id].to_i).to eq(@merch[5].id)
    expect(merchants[:data][4][:attributes][:count]).to eq(2)
  end

  it "returns an error if no quantity is given" do
    get "/api/v1/merchants/most_items", params: {quantity: "abc"}
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/merchants/most_items"
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/merchants/most_items", params: {quantity: 0}
    expect(response).to have_http_status(:bad_request)
  end
end
