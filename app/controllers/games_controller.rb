class GamesController < ApplicationController

   def index
    @current_user_name = current_user.name
    @games = Game.paginate(:page => params[:page], :per_page => 1)
  end 

  def show

  end

  def new
    @game = Game.new
    @avail_games = Game.pluck(:name, :id) || []
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

  private

  before_action :authenticate_user!
  #load_and_authorize_resource
  
  # if Authorization failed redirect to root_url
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  
  # before callbacks
  before_filter :find_game, only: [:show, :edit, :update, :destroy]
  
  def find_game
    @game = Game.find(params.require(:id))
    @avail_games = Game.pluck(:name, :id)
  end


  def allow_params
    params.require(:game).permit(:name, :scoring_points)
  end

end
