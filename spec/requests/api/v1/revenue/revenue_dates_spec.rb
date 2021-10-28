require 'rails_helper'

describe "Total revenue between dates endpoint" do
  before :each do
    invoice1 = create(:invoice, created_at: "2012-03-08")
    invoice2 = create(:invoice, created_at: "2012-03-09")
    invoice3 = create(:invoice, created_at: "2012-03-10")
    invoice4 = create(:invoice, created_at: "2012-03-11")
    invoice5 = create(:invoice, created_at: "2012-03-12")
    invoice6 = create(:invoice, status: "packaged", created_at: "2012-03-12")

    ii1 = create(:invoice_item, invoice: invoice1, unit_price: 100, quantity: 2)
    ii2 = create(:invoice_item, invoice: invoice2, unit_price: 100, quantity: 2)
    ii3 = create(:invoice_item, invoice: invoice3, unit_price: 100, quantity: 2)
    ii4 = create(:invoice_item, invoice: invoice4, unit_price: 100, quantity: 2)
    ii5 = create(:invoice_item, invoice: invoice5, unit_price: 100, quantity: 2)
    ii6 = create(:invoice_item, invoice: invoice6, unit_price: 100, quantity: 2)

    trans1 = create(:transaction, invoice: invoice1)
    trans2 = create(:transaction, invoice: invoice2)
    trans3 = create(:transaction, invoice: invoice3)
    trans4 = create(:transaction, invoice: invoice4)
    trans5 = create(:failed_transaction, invoice: invoice5)
    trans6 = create(:transaction, invoice: invoice6)
  end

  it "returns the total revenue for the date range" do
    get "/api/v1/revenue", params: {start: "2012-03-09", end: "2012-03-12"}

    expect(response).to be_successful

    rev = JSON.parse(response.body, symbolize_names: true)

    expect(rev).to be_a Hash

    expect(rev).to have_key(:data)
    expect(rev[:data]).to be_an(Hash)

    rev = rev[:data]

    expect(rev).to have_key(:attributes)
    expect(rev[:attributes]).to be_an(Hash)

    expect(rev[:attributes]).to have_key(:revenue)
    expect(rev[:attributes][:revenue].to_i).to eq(600)
  end

  it "returns an error with bad or no date params" do
    get "/api/v1/revenue", params: {start: "", end: "2012-03-12"}
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/revenue", params: {start: "2012-03-09"}
    expect(response).to have_http_status(:bad_request)

    get "/api/v1/revenue"
    expect(response).to have_http_status(:bad_request)
  end
end
