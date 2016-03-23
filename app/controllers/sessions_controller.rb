class SessionsController < ApplicationController
    def new
    end
    
    def create
        user = User.find_by(email: params[:session][:email].downcase)
        # Check to see if the user is in the database.
      if user && user.authenticate(params[:session][:password])
        # Save the user id in the session hash, which is backed by the browser's cookies.
        session[:user_id] = user.id
        flash[:success] = "You have successfuly logged in"
        redirect_to user_path(user)
      else
        flash.now[:danger] = "Either the email or password you entered are incorrect"
        render 'new'
      end
    end
    
    def destroy
         session[:user_id] = nil
         flash[:success] = "You have been logged out"
         redirect_to root_path
    end
    
    
end
