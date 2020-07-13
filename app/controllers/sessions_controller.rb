class SessionsController < ApplicationController
    def new
    end

    def create
        @user = User.find_by(email: params[:session][:email].downcase)
        if @user && @user.authenticate(params[:session][:password])
            login(@user)
            flash[:success] = "Successfully logged in."
            redirect_to login_url
        else
            flash.now[:danger] = "Invalid email/password combination."
            render 'new'
        end
    end

    def destroy
        log_out(current_user)
        flash[:success] = "Successfully logged out."
        redirect_to login_url
    end
end