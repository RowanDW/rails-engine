class Api::V1::ItemsController < ApplicationController
  include Pagination
  #skip_before_action :item_exists, only: [:index, :create]
  def index
    if params[:merchant_id]
      if Merchant.exists?(params[:merchant_id])
        merchant = Merchant.find(params[:merchant_id])
        items = merchant.items
        render json: ItemSerializer.new(items).serializable_hash.to_json
      else
        render json: {status: :not_found, code: 404, message: "error" }, status: :not_found
      end
    else
      items = Item.limit(limit).offset(per_page)
      render json: ItemSerializer.new(items).serializable_hash.to_json
    end
  end

  def show
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      render json: ItemSerializer.new(item).serializable_hash.to_json
    else
      item = Item.new
      render json: ItemSerializer.new(item).serializable_hash.to_json, status: :not_found
    end
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
    if Item.exists?(params[:id])
      item = Item.find(params[:id])
      if item.update(item_params)
        render json: ItemSerializer.new(item).serializable_hash.to_json
      else
        render json: {status: :bad_request, code: 400, message: "Invalid Item inputs" }, status: :bad_request
      end
    else
      render json: {status: :not_found, code: 404, message: "Item does not exist" }, status: :not_found
    end
  end

  def destroy
    if Item.exists?(params[:id])
      Item.delete(params[:id])
    else
      render json: {status: :not_found, code: 404, message: "Item does not exist" }, status: :not_found
    end
  end

  private

  # def item_exists?
  #   if !Item.exists?(params[:id])
  #     render json: {status: :not_found, code: 404, message: "Item does not exist" }, status: :not_found
  #   end
  # end

  def item_params
    params.require(:item).permit(:name, :description, :unit_price, :merchant_id)
  end
end
