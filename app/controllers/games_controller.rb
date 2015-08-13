class GamesController < ApplicationController

  def index
    @current_user_name = current_user.name
    @games = Game.paginate(:page => params[:page])
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
      flash[:notice] = "Game #{@game.name} Created Successfully"
      redirect_to games_path
    else
      flash[:error] = @game.errors.full_messages.to_s
      render :new
    end
  end

  def edit	
  end
  
  def update
    if @game.update_attributes(allow_params)
      flash[:notice] = "Game #{@game.name} Updated Success"
      redirect_to games_path
    else
      flash[:error] = @game.errors.full_messages.to_s
      render :edit
    end
  end

  def destroy
    @game.destroy
    flash[:notice] = "Game #{@game.name} Deleted Successfully"
    redirect_to games_path
  end

  private

  before_action :authenticate_user!
  authorize_resource
  
  # if Authorization failed redirect to root_url
  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  
  # before callbacks
  before_filter :find_game, only: [:show, :edit, :update, :destroy]
  
  def find_game
    @game = Game.find(params.require(:id))
  end


  def allow_params
    params.require(:game).permit(:name, :scoring_points)
  end

end
