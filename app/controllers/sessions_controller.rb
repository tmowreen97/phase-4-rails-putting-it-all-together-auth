class SessionsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_not_found_response
skip_before_action :authorized, only:[:create]
  def create
    user= User.find_by(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id]||=user.id
      render json: user, status: :ok
    else
      raise ActiveRecord::RecordInvalid
    end
  end

  def destroy
    if session[:user_id]
      session[:user_id] = nil
      head :no_content
    else 
      raise ActiveRecord::RecordInvalid
    end
  end
  private 

  def render_not_found_response invalid
    # byebug
    render json: {errors: ["Invalid username or password"]}, status: :unauthorized

  end
end
