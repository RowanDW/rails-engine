class MerchantItemSerializer
  include JSONAPI::Serializer
  attributes :name, :count
end
