class StaticController < ApplicationController
  
  layout :resolve_layout
  
  def home
    redirect_to games_path if current_player && current_player.active
  end
  
  def standings
    
    @players_sort_by_games_played = Player.active.each do |player|
      player[:games_played] = player.games.count
    end
    @players_sort_by_games_played.sort! { |a,b|  b.games_played <=> a.games_played }
    
    @players_sort_by_money_won = Player.active.each do |player|
      player[:amount_won] = player.results.sum(:won)
    end
    @players_sort_by_money_won.sort! { |a,b|  b.amount_won <=> a.amount_won }
    
    @players_sort_by_average_money_won = Player.active.each do |player|
      player[:average_amount_won] = player.games.count > 0 ? player.results.sum(:won) / player.games.count : 0
    end
    @players_sort_by_average_money_won.sort! { |a,b|  b.average_amount_won <=> a.average_amount_won }
    
    @players_sort_by_profit = Player.active.each do |player|
      player[:amount_profit] = player.results.sum(:won)-player.games.sum(:wager)
    end
    @players_sort_by_profit.sort! { |a,b|  b.amount_profit <=> a.amount_profit }
    
    @players_sort_by_average_profit = Player.active.each do |player|
      player[:average_amount_profit] = player.games.count > 0 ? (player.results.sum(:won)-player.games.sum(:wager)) / player.games.count : 0
    end
    @players_sort_by_average_profit.sort! { |a,b|  b.average_amount_profit <=> a.average_amount_profit }
    
    @players_sort_by_first_place = Player.active.each do |player|
      player[:first_place] = player.results.where('placed = 1').count
    end
    @players_sort_by_first_place.sort! { |a,b|  b.first_place <=> a.first_place }
    
    @players_sort_by_first_place_pct = Player.active.each do |player|
      player[:first_place_pct] = player.results.where('placed = 1').count > 0 && player.games.ranked.all.count ? player.results.where('placed = 1').count.to_f / player.games.ranked.all.count.to_f : 0
    end
    @players_sort_by_first_place_pct.sort! { |a,b|  b.first_place_pct <=> a.first_place_pct }

    @players_sort_by_money_back = Player.active.each do |player|
      player[:money_back] = player.results.where('money_back = true').count
    end
    @players_sort_by_money_back.sort! { |a,b|  b.money_back <=> a.money_back }
    
    @players_sort_by_money_back_pct = Player.active.each do |player|
      player[:money_back_pct] = player.results.where('money_back = true').count > 0 && player.games.ranked.all.count > 0 ? player.results.where('money_back = true').count.to_f / player.games.ranked.all.count.to_f : 0
    end
    @players_sort_by_money_back_pct.sort! { |a,b|  b.money_back_pct <=> a.money_back_pct }

  end
  
  private
  
  def resolve_layout
    case action_name
    when "home"
      "plain"
    else
      "application"
    end
  end
  
end
