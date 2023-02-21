class UsersController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
skip_before_action :authorized, only:[:create]
  def create
    user = User.create!(user_params)
    if user.valid?
      session[:user_id]||=user.id
      render json: user, status: :created
    else
      raise ActiveRecord::RecordInvalid
    end
  end

  def show
    user= User.find(session[:user_id])
    render json: user, status: :ok
  end

  private

  def user_params
    params.permit(:username, :password, :password_confirmation, :image_url, :bio)
  end

  def render_unprocessable_entity_response(invalid)
    render json: {errors: [invalid.record.errors]}, status: :unprocessable_entity
  end

  def render_not_found_response
    render json: {errors: "Unauthorized"}, status: :unauthorized
  end
end
