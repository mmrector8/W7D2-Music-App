class UsersController < ApplicationController

    def show
        user = User.find(params[:id])
        render :user
    end

    def new
        user = User.new
        render :new
    end

    def create
        user = User.new(user_params)

        if user.save!
            render json: 'save successful'
        else
            render json: 'try again!'
        end

    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end