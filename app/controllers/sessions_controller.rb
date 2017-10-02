class SessionsController < ApplicationController
    def user_params
        params.require(:user).permit(:user_id, :email, :session_token, :timestamps)
    end
    def create
        if User.exists?(user_id: user_params[:user_id], email: user_params[:email])
            @user = User.where(user_id: user_params[:user_id])
            user = User.find @user[0].id
            session[:session_token] = user.session_token
            flash[:notice] = "You are logged in as #{user_params[:user_id]}"
            redirect_to movies_path
        else
            flash[:notice] = "Invalid user-id/e-mail combination"
            redirect_to login_path
        end
    end
    def destroy
        session.clear
        flash[:notice] = "You successfully logged out"
        redirect_to movies_path
    end
end