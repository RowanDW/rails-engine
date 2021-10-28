class Api::V1::Items::FindController < ApplicationController
  include ItemQueryValidations
  def index
    if valid_name_search?
      item = Item.search_by_name(params[:name])
      item.empty? ? result = Item.new : result = item.first
      render json: ItemSerializer.new(result).serializable_hash.to_json
    elsif valid_price_search?
      item = Item.search_by_price(params[:min_price].to_i, params[:max_price].to_i)
      item.empty? ? result = Item.new : result = item.first
      render json: ItemSerializer.new(result).serializable_hash.to_json
    else
      render json: { error: "Invalid search" }, status: 400
    end
  end
end
