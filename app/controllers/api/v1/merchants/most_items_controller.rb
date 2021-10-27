class Api::V1::Merchants::MostItemsController < ApplicationController
  def index
    if params[:quantity] && params[:quantity] !~ /\D/ && params[:quantity].to_i > 0
      merchants = Merchant.most_items(params[:quantity])
      render json: MerchantItemSerializer.new(merchants).serializable_hash
    else
      render json: {error: "Bad Quantity" }, status: :bad_request
    end
  end
end
