class RecipeUserSerializer < ActiveModel::Serializer
  attributes :username, :image_url, :bio
end
