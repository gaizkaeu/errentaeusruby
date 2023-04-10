class Api::V1::Serializers::TagSerializer
  include JSONAPI::Serializer

  set_type :tag
  set_id :id
  attributes :name, :hex_color, :taggings_count, :emoji, :dark_hex_color, :parent_tag_id
end
