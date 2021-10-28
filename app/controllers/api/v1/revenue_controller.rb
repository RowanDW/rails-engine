class Api::V1::RevenueController < ApplicationController
  def index
    if valid_param?(params[:start]) && valid_param?(params[:end])
      rev = InvoiceItem.revenue_dates(params[:start], params[:end])
      render json: RevenueDateSerializer.new(rev[0]).serializable_hash
    else
      render json: {error: "Start and End date params required" }, status: :bad_request
    end
  end

  private

  def valid_param?(param)
     !param.nil? && param != ""
  end
end
