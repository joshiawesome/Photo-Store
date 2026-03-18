class UsersController < ApplicationController

    def create
        @user = User.new(user_params)
        if @user.save
            render json: { message: Messages::SUCCESS[:user_created] , email: @user.email}, status: :created
        else
            render json: @user.errors, status: :unprocessable_entity
        end
    end


    def user_params
        params.require(:user).permit(:email, :password)
    end
end
