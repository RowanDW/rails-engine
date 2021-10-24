class Api::V1::ItemsController < ApplicationController
  include Pagination
  def index
    items = Item.limit(limit).offset(per_page)
    render json: ItemSerializer.new(items).serializable_hash.to_json
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item).serializable_hash.to_json
  end
end
