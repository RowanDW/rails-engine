class Api::V1::Revenue::MerchantsController < ApplicationController
  def index
    if params[:quantity] && params[:quantity] !~ /\D/ && params[:quantity].to_i > 0
      merchants = Merchant.most_revenue(params[:quantity])
      render json: MerchantNameRevenueSerializer.new(merchants).serializable_hash
    else
      render json: {error: "Quantity param required" }, status: :bad_request
    end
  end

  def show
    if Merchant.exists?(params[:id])
      rev = Merchant.total_revenue(params[:id])
      render json: MerchantRevenueSerializer.new(rev[0]).serializable_hash
    else
      render json: {error: "Merchant not found" }, status: :not_found
    end
  end
end
