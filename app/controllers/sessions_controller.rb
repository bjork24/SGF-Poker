class SessionsController < ApplicationController
  
  def create
    auth = request.env["omniauth.auth"]
    player = Player.find_by_provider_and_uid(auth["provider"], auth["uid"]) || Player.create_with_omniauth(auth)
    player.update_attributes(:avatar => auth["user_info"]["image"]) if not player.avatar == auth["user_info"]["image"]
    session[:player_id] = player.id
    if player.active
      redirect_to games_path, :notice => "Signed in!"
    else
      redirect_to root_url, :notice => "Your account has not been activated"
    end
  end
  
  def destroy
    session[:player_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end

end
