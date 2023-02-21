class UserSerializer < ActiveModel::Serializer
  attributes :username, :id, :image_url, :bio
end
