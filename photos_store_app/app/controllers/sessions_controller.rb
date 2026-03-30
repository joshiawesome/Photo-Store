class SessionsController < ApplicationController
  # login
  def create
    errors = ActiveModel::Errors.new(self)

    errors.add(:email, Messages::ERROR[:empty_email]) if params[:user][:email].blank?
    errors.add(:password, Messages::ERROR[:empty_password]) if params[:user][:password].blank?

    if errors.any?
      return render json: errors, status: :unprocessable_entity
    end

    user = User.find_by(email: params[:user][:email])

    if user&.authenticate(params[:user][:password])
      session[:user_id] = user.id
      render json: { message: Messages::SUCCESS[:user_logged_in], email: user.email }, status: :ok
    else
      errors = ActiveModel::Errors.new(self)
      errors.add(:base, Messages::ERROR[:invalid_credentials])
      render json: errors, status: :unauthorized
    end
  end

  def show
    if current_user
      render json: { user: current_user }, status: :ok
    else
      render json: { error: Messages::ERROR[:not_logged_in] }, status: :unauthorized
    end
  end
  
  def destroy
    reset_session
    render json: { message: Messages::SUCCESS[:user_logged_out] }, status: :ok
  end
end
