require 'rails_helper'

describe "Total revenue for one merchant endpoint" do
  before :each do
    @merch = create(:merchant)
    item = create(:item, merchant: @merch)
    invoice1 = create(:invoice)
    invoice2 = create(:invoice)
    invoice3 = create(:invoice, status: "packaged")

    ii1 = create(:invoice_item, item: item, invoice: invoice1, unit_price: 100, quantity: 2)
    ii2 = create(:invoice_item, item: item, invoice: invoice2, unit_price: 100, quantity: 2)
    ii3 = create(:invoice_item, item: item, invoice: invoice3, unit_price: 100, quantity: 2)

    trans1 = create(:transaction, invoice: invoice1)
    trans2 = create(:failed_transaction, invoice: invoice2)
    trans3 = create(:transaction, invoice: invoice3)
  end

  it "returns the total revenue for the merchant" do
    get "/api/v1/revenue/merchants/#{@merch.id}"

    expect(response).to be_successful

    merchant = JSON.parse(response.body, symbolize_names: true)

    expect(merchant).to be_a Hash

    expect(merchant).to have_key(:data)
    expect(merchant[:data]).to be_an(Hash)

    merchant = merchant[:data]

    expect(merchant).to have_key(:attributes)
    expect(merchant[:attributes]).to be_an(Hash)

    expect(merchant).to have_key(:id)
    expect(merchant[:id].to_i).to eq(@merch.id)

    expect(merchant).to have_key(:type)
    expect(merchant[:type]).to eq("merchant_revenue")

    expect(merchant[:attributes]).to have_key(:revenue)
    expect(merchant[:attributes][:revenue].to_i).to eq(200)
  end

  it "returns an error with bad merchant id" do
    get "/api/v1/revenue/merchants/1123121212123123"
    expect(response).to have_http_status(:not_found)
  end
end
