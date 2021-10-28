class RevenueDateSerializer
  include JSONAPI::Serializer
  attributes :revenue
  set_type :revenue
end
