class Api::V1::MerchantsController < ApplicationController
  include Pagination
  
  def index
    merchants = Merchant.limit(limit).offset(per_page)
    render json: MerchantSerializer.new(merchants).serializable_hash.to_json
  end
end
