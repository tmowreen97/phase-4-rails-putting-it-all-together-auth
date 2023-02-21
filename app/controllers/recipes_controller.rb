class RecipesController < ApplicationController
  rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response


  def index
    recipes = Recipe.all
    render json: recipes, status: :ok
  end

  def create
    recipe_params_w_user = recipe_params
    recipe_params_w_user[:user_id]=session[:user_id]
    recipe = Recipe.create!(recipe_params_w_user)
    render json: recipe, status: :created
  end

  private

  def recipe_params
    params.permit(:title, :instructions, :minutes_to_complete)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: ["Unprocessable"]}, status: :unprocessable_entity
  end

  def render_not_found_response invalid
    render json: {errors: ["Unauthorized"]}, status: :unauthorized
  end



end
