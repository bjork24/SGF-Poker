class GamesController < ApplicationController
  
  before_filter :authenticate
  
  # GET /games
  # GET /games.xml
  def index
    @games = Game.order('date DESC').all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @games }
    end
  end

  # GET /games/1
  # GET /games/1.xml
  def show
    @game = Game.find(params[:id])
    @players = @game.players
    @comments = @game.comments

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/new
  # GET /games/new.xml
  def new
    @game = Game.new
    @players = Player.active.each do |player|
      player[:games_played] = player.games.count
    end
    @players.sort! { |a,b|  b.games_played <=> a.games_played }

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id])
    @players = Player.active.each do |player|
      player[:games_played] = player.games.count
    end
    @players.sort! { |a,b|  b.games_played <=> a.games_played }
  end

  # POST /games
  # POST /games.xml
  def create
    @game = Game.new(params[:game])
    @game.game_number = Game.ranked.count+1
    
    if @game.save
      redirect_to(rank_path(@game))
    else
      redirect_to(new_game_path(), :alert => "You fucked something up!")
    end
  end

  # PUT /games/1
  # PUT /games/1.xml
  def update
    @game = Game.find(params[:id])
    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to(@game, :notice => 'Game was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @game.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.xml
  def destroy
    @game = Game.find(params[:id])
    @game.destroy

    respond_to do |format|
      format.html { redirect_to(games_url) }
      format.xml  { head :ok }
    end
  end
end
