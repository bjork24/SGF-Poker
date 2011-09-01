module ApplicationHelper
  
  def total_games
  	Game.ranked.all.count
  end
  
  def games_played(player, format = nil)
    if not format
      player.games.ranked.count
    else
      percent = games_played(player).to_f / total_games.to_f * 100
      number_to_percentage( percent, :precision => 0 )
    end
  end
  
  def first_place(player, format = nil)
    if not format
      player.results.where('placed = 1').count
    else
      percent = first_place(player).to_f / games_played(player).to_f * 100
      number_to_percentage( percent, :precision => 0 )
    end
  end
  
  def money_back(player, format = nil)
    if not format
      player.results.where('money_back = true').count
    else
      percent = money_back(player).to_f / games_played(player).to_f * 100
      number_to_percentage( percent, :precision => 0 )
    end
  end
  
  def amount_wagered(player, format = nil)
     if not format
       number_to_currency(amount_wagered(player,1))
     else
       player.games.sum(:wager)
     end
   end
  
  def amount_won(player, stat = nil)
    if not stat
      number_to_currency(amount_won(player,1))
    elsif stat == :per_game_raw || stat == :per_game
      amount = amount_won(player,1).to_f / games_played(player).to_f
      if stat == :per_game_raw
        amount
      else
        number_to_currency( amount )
      end
    else
      player.results.sum(:won)
    end
  end
  
  def amount_profited(player, stat = nil)
    if not stat
      number_to_currency( amount_won(player,1)-amount_wagered(player,1) )
    elsif stat == :per_game_raw || stat == :per_game
      amount = amount_profited(player,1).to_f / games_played(player).to_f
      if stat == :per_game_raw
        amount
      else
        number_to_currency( amount )
      end
    else
      amount_won(player,1)-amount_wagered(player,1)
    end
  end
  
  def first_game(player, stat = nil, date_format = nil)
    first_game = player.games.first
    if first_game
      if not stat
        first_game
      elsif stat == :date
        first_game.date.strftime(date_format)
      elsif stat == :player_count
        first_game.players.count
      elsif stat == :placed
        Result.find_by_game_id_and_player_id(first_game, player).placed
      end
    end
  end
  
  def last_game(player, stat = nil, date_format = nil)
    last_game = player.games.last
    if last_game
      if not stat
        last_game
      elsif stat == :date
        last_game.date.strftime(date_format)
      elsif stat == :player_count
        last_game.players.count
      elsif stat == :placed
        Result.find_by_game_id_and_player_id(last_game, player).placed
      end
    end
  end
  
  def last_win(player = nil, stat = nil, date_format = nil)
    if not player
      game = Game.ranked.order('date ASC').last
      winner = game.players.order('results.placed ASC').first
      winner
    else
      last_win_game = player.results.where('placed = 1').count > 0 ? player.results.where('placed = 1').last.game : nil
      if stat == :date
        if last_win_game
          last_win_game.date.strftime(date_format)
        else
          "Never"
        end
      elsif stat == :time_ago
        "(#{distance_of_time_in_words(last_win_game.date, Time.now)} ago)" if last_win_game
      end
    end
  end
  
  def avatar(player)
    p = Player.find(player)
    (p.avatar.present? && p.avatar) || '/images/ghost.png'
  end
  
  def twitter_hash(len = 4)
    parts = [('a'..'z'),('A'..'Z'),(0..9)].map{ |i| i.to_a }.flatten
    hash = (1..len).map{ parts[rand(parts.length)]  }.join
    "##{hash}"
  end
  
end
