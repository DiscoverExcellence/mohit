class MatchesController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  # if Authorization failed redirect to root_url
  rescue_from CanCan::AccessDenied do | exception |
    redirect_to root_url, alert: exception.message
  end

  before_filter :find_match, only: [:show, :edit, :update, :destroy]

  def find_match
    @match = Match.find(params.require(:id))
  end

  def allow_params
    params.require(:match).permit(:venue, :no_of_players)
  end

  def index
    @game = Game.find(params.require(:game_id))
    @matches = @game.matches.all
  end
  
  def show
    
  end
  
  def new
    
  end
  
  def create
    @match.new(allow_params)
    if @match.save
      flash[:notice] = "Match Created"
      redirect_to new_game_match 
    else
      render :new
    end
  end
  
  def edit
  end
  
  def update
    if @match.update_attributes(allow_params)
      flash[:notice] = "Update Success"
      redirect_to game_matches_path
    else
      render :edit
    end
  end

  def destroy
  end
end
