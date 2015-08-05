class GamesController < ApplicationController

  before_action :authenticate_user!

  before_filter :find_game, only: [:show, :edit, :update, :destroy]
  
  def find_game
    @game = Game.find(params.require(:id))
  end

  def allow_params
    params.require(:game).permit(:name, :scoring_points, :matches_attributes, :tournaments_attributes)
  end

  def index
    @current_user_name = current_user.name
    @games = Game.all
  end 

  def show

  end

  def new
    @game = Game.new
    @game.matches.build
    @game.tournaments.build
  end

  def create
    @game = Game.new(allow_params)
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  def edit	
  end
  
  def update
    if @game.update_attributes(allow_params)
      flash[:notice] = "Updated Success"
      redirect_to games_path
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

end
