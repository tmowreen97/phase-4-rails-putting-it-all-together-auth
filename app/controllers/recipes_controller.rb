class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response
  
  def index
    user = User.find_by!(id: session[:user_id])
    recipes = user.recipes
    render json: recipes, status: :ok
  end

  def create
    user = User.find_by!(id: session[:user_id])
    user.recipes.create!(recipe_params)
    recipe = user.recipes.last
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end
  def render_unprocessable_entity_response invalid
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
  
  def render_record_not_found_response errors
    errors_array = []
    errors_array.push(errors.message)
    render json: {errors: errors_array}, status: :unauthorized
  end
end
