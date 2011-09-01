class CommentsController < ApplicationController
  
  before_filter :load_game
  
  def index
    @comments = @game.comments.all
  end
  
  def create
    @comment = @game.comments.new(params[:comment])
    if @comment.save
      redirect_to @game, :notice => "Thanks for the comment"
    else
      redirect_to @game, :alert => "You didn't leave a comment!"
    end
  end
  
  private
  
    def load_game
      @game = Game.find(params[:game_id])
    end
  
end
