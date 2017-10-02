class UsersController < ApplicationController
    def user_params
        params.require(:user).permit(:user_id, :email, :session_token, :timestamps)
    end
    def new
      # default: render 'new' template
    end
    def create
        if User.exists? user_id: user_params[:user_id]
            flash[:notice] = "Sorry the user-id is taken. Try again."
        else
            User.create_user!(user_params)
            flash[:notice] = "Welcome #{user_params[:user_id]}, Your account has been created"
        end
        redirect_to login_path
    end
    
end    