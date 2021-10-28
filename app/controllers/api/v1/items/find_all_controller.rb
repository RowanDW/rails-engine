class Api::V1::Items::FindAllController < ApplicationController
  include ItemQueryValidations
  def index
    if valid_name_search?
      items = Item.search_by_name(params[:name])
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif valid_price_search?
      items = Item.search_by_price(params[:min_price].to_i, params[:max_price].to_i)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    else
      render json: { error: "Invalid search" }, status: 400
    end
  end
end
