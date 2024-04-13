class UsersController < ApplicationController

    def new
        @user =  User.new
    end

    def create
        @user = User.new(user_params)
        if @user.save
            redirect_to users_path, flash: {notice: "Employee created successfully."} 
        else
            redirect_to users_path, flash: {error: "Employee could not be created. Please try again."} 
        end 
    end
    Private

        def user_params
            params.require(:user).permit(:email, :password)
        end


end