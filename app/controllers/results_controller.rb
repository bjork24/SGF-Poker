class ResultsController < ApplicationController
  
  def rank
    @game = Game.find(params[:game_id])
    @players = @game.players
  end
  
  def rank_create
    
    @game = Game.find(params[:game][:id])
    params[:game][:players].each_with_index do |player_id, i|
      
      player = Player.find(player_id)
      winner = Player.find(params[:game][:players][0])
      winner_twitter = (true && winner.twitter) || winner.name
      if(player.twitter)
        tweet = if (player == winner)
          "@#{player.twitter}: You totally dominated at poker tonight! You beat #{params[:game][:players].size-1} losers! Way to go!"
        else
          "@#{player.twitter}: Guess what?! @#{winner_twitter} totally whipped your ass at poker tonight!"
        end
        Twitter.update(tweet)
      end
      
      placed = i+1
      result = Result.find_by_game_id_and_player_id(@game,player_id)
      result.placed = placed
      case placed
      when 1
        total_pot = @game.wager*@game.players.count
        result.money_back = true
        result.won = params[:game][:second_wins_money] ? total_pot-params[:game][:second_money_amount].to_i : total_pot
      when 2
        result.money_back = true if params[:game][:second_wins_money]
        result.won = params[:game][:second_wins_money] ? params[:game][:second_money_amount] : 0
      else
        result.won = 0
      end
      result.save
    end
    @game.update_attributes(:ranked => true) if @game.ranked == false
    redirect_to(@game, :notice => 'Game successfully saved.')
  end
    
end
