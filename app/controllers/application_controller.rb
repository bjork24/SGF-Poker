class ApplicationController < ActionController::Base

  protect_from_forgery
  
  helper_method :current_player, :logged_in?, :activated?
  
  protected
  
  def current_player
    @current_player ||= Player.find(session[:player_id]) if session[:player_id]
  end
  
  def authenticate
  	logged_in? ? true : access_denied("Please log in to continue")
  	activated? ? true : access_denied("Your account has not been activated") if logged_in?
  end
  
  def logged_in?
  	current_player.is_a? Player
  end
  
  def activated?
  	current_player.active
  end
  
  def access_denied(notice)
  	redirect_to root_path, :alert => notice and return false
  end
  
end
