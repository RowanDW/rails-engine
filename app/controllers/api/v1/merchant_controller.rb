class Api::V1::MerchantController < ApplicationController
  def index
    if Item.exists?(params[:item_id])
      item = Item.find(params[:item_id])
      render json: MerchantSerializer.new(item.merchant).serializable_hash.to_json
    else
      render json: {status: :not_found, code: 404, message: "error" }, status: :not_found
    end
  end
end
