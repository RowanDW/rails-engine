class Api::V1::Merchants::FindController < ApplicationController

  def index
    return render json: { message: "Invalid search" }, status: 400 if params[:name]== nil || params[:name] == ""

    merchant = Merchant.search_by_name(params[:name])
    if merchant.size > 0
      render json: MerchantSerializer.new(merchant.first).serializable_hash.to_json
    else
      render json: MerchantSerializer.new(Merchant.new).serializable_hash.to_json, status: 200
    end
  end
end
