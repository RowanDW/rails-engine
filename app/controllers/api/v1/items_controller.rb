class Api::V1::ItemsController < ApplicationController
  include Pagination
  before_action :item_exists, only: [:show, :update, :destroy]

  def index
    if params[:merchant_id]
      if Merchant.exists?(params[:merchant_id])
        merchant = Merchant.find(params[:merchant_id])
        render json: ItemSerializer.new(merchant.items).serializable_hash.to_json
      else
        render json: { error: "error" }, status: :not_found
      end
    else
      items = Item.limit(limit).offset(per_page)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    end
  end

  def show
    item = Item.find(params[:id])
    render json: ItemSerializer.new(item).serializable_hash.to_json
  end

  def create
    item = Item.new(item_params)
    if item.save
      render json: ItemSerializer.new(item).serializable_hash.to_json, status: :created
    else
      render json: {status: :bad_request, code: 400, message: "Invalid Item inputs" }, status: :bad_request
    end
  end

  def update
    item = Item.find(params[:id])
    if item.update(item_params)
      render json: ItemSerializer.new(item).serializable_hash.to_json
    else
      render json: {status: :bad_request, code: 400, message: "Invalid Item inputs" }, status: :bad_request
    end
  end

  def destroy
    Item.destroy(params[:id])
    Invoice.destroy_empties
  end

  private

  def item_exists
    if !Item.exists?(params[:id])
      render json: {status: :not_found, code: 404, message: "Item does not exist" }, status: :not_found
    end
  end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
