class Api::V1::Merchants::FindAllController < ApplicationController

  def index
    return render json: { message: "Invalid search" }, status: 400 if params[:name]== nil || params[:name] == ""

    merchants = Merchant.search_by_name(params[:name])
    render json: MerchantSerializer.new(merchants).serializable_hash
  end
end
