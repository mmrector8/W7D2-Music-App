class SessionsController < ApplicationController
    
    def new
        @user = User.new
        render json: 'new session!'
    end

    def create
        username= params[:user][:username]
        password = params[:user][:password]

        @user.find_by_credentials(username, password)

        if @user
            login(@user)
            redirect_to users_url
        else
            render json: 'session initiation unsuccessful'
        end
    end

    def destroy
        logout
        redirect_to new_session_url
    end
end