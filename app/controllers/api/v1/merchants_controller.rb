class Api::V1::MerchantsController < ApplicationController
  include Pagination

  def index
    merchants = Merchant.limit(limit).offset(per_page)
    render json: MerchantSerializer.new(merchants).serializable_hash.to_json
  end

  def show
    if Merchant.exists?(params[:id])
      merchant = Merchant.find(params[:id])
      render json: MerchantSerializer.new(merchant).serializable_hash.to_json
    else
      merchant = Merchant.new
      render json: MerchantSerializer.new(merchant).serializable_hash.to_json, status: :not_found
    end
  end
end
