class RecipeSerializer < ActiveModel::Serializer
  attributes :title, :instructions, :minutes_to_complete, :id
  belongs_to :user
end
