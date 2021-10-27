class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity] && params[:quantity] !~ /\D/ && params[:quantity].to_i >= 0
      merchants = Merchant.most_revenue(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchants).serializable_hash
    else
      render json: {error: "Quantity param required" }, status: :bad_request
    end
  end
end
