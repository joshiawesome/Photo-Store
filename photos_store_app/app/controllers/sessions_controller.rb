class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])
    if user&.authenticate(params[:password])
      session[:user_id] = user.id
      render json: { message: Messages::SUCCESS[:user_logged_in], user: user }, status: :ok
    else
      render json: { error: Messages::ERROR[:invalid_credentials] }, status: :unauthorized
    end
  end
  
  def destroy
    reset_session
    render json: { message: Messages::SUCCESS[:user_logged_out] }, status: :ok
  end
end
