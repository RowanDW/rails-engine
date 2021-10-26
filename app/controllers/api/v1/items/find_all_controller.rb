class Api::V1::Items::FindAllController < ApplicationController

  def index
    if valid_name_search?
      items = Item.search_by_name(params[:name])
      render json: ItemSerializer.new(items).serializable_hash.to_json
    elsif valid_price_search?
      items = Item.search_by_price(params[:min_price].to_i, params[:max_price].to_i)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    else
      render json: { message: "Invalid search" }, status: 400
    end
  end

  private

  def valid_name_search?
    if params[:name] && params[:min_price].nil? && params[:max_price].nil?
      return params[:name] != ""
    end
    false
  end

  def valid_price_search?
    if params[:name]
      return false
    elsif params[:min_price] && params[:max_price]
      valid_max_price_search? && valid_min_price_search?
    else
      valid_max_price_search? || valid_min_price_search?
    end
  end

  def valid_min_price_search?
   params[:min_price] && params[:min_price] !~ /\D/ && params[:min_price].to_i >= 0
  end

  def valid_max_price_search?
    if params[:max_price] && params[:max_price] !~ /\D/ && params[:max_price].to_i > 0
      if valid_min_price_search? && (params[:max_price].to_i < params[:min_price].to_i)
        return false
      end
       return true
    end
    false
  end
end
