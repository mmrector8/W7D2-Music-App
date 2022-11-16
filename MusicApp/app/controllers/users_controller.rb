class UsersController < ApplicationController

    def show
        user = User.find_by(id: params[:id])
        render :show
    end

    def new
        user = User.new
        render :new
    end

    def create
        @user = User.new(user_params)

        if @user.save!
            login(@user)
            render :show
        else
            render json: 'try again!'
        end

    end

    private
    def user_params
        params.require(:user).permit(:email, :password)
    end
end