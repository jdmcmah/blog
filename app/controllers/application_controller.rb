class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  
  helper_method :current_user, :logged_in?
  
  def current_user
    # Returns the user if session[:user_id] has a user backed in the session hash.
    # Optimized using memoization (@current_user) looks for a current user first
    # this prevents multiple hits to the database.  If no current_user is found
    # hit the database to find them.
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  
  def logged_in?
    # Returns true if there is a current user, otherwise return false.
    !!current_user 
  end
  
  def require_user
    if !logged_in?
      flash[:danger] = "You must be logged in to perform that action."
      redirect_to root_path
    end
  end
  
end
