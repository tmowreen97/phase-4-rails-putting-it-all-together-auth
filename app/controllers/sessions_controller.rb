class SessionsController < ApplicationController
rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found_response

  def create
    user= User.find_by!(username: params[:username])
    if user&.authenticate(params[:password])
      session[:user_id]= user.id
      render json: user, status: :created
    else
      render json: {error: "invalid username or password"}, status: :unauthorized
    end
      
  end

  def destroy
    user = User.find_by!(id: session[:user_id])
    if user
      session[:user_id]=nil
    end
  end

  private 

  
  
  def render_unprocessable_entity_response invalid
    render json: {errors: invalid.record.errors.full_messages}, status: :unprocessable_entity
  end
  
  def render_record_not_found_response errors
    error_array = []
    error_array.push(errors.message)
    render json: {errors: error_array}, status: :unauthorized
  end
end
