class UsersController < ApplicationController
    # sign up
    def create
        @user = User.new(user_params)
        if @user.save
            # auto login the user
            session[:user_id] = @user.id

            # deliver_later uses background job to send email
            # makes use of rails active job - quick app response unlike deliver_now
            UserMailer.welcome_email(@user).deliver_later
            render json: { message: Messages::SUCCESS[:user_created] , email: @user.email}, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end


    def user_params
        params.require(:user).permit(:email, :password)
    end
end
