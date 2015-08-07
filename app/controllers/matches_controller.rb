class MatchesController < ApplicationController

  def index
    @matches = get_context.matches.all
  end
  
  def show
    
  end
  
  def get_context
    (params[:game_id]) ? Game.find(params[:game_id])
                       : Tournament.find(params[:tournament_id])
  end

  def new
    @match = get_context.matches.build()
  end
  
  def create
    
    @match = get_context.matches.build(allow_params)
    if @match.save
      flash[:notice] = "Match Created"
      redirect_to game_matches_path 
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
    @match.destroy
    redirect_to game_matches_path
  end

  private

  before_action :authenticate_user!
  #load_and_authorize_resource

  # if Authorization failed redirect to root_url
  rescue_from CanCan::AccessDenied do | exception |
    p "AccessDenied Exception"
    redirect_to root_url, alert: exception.message
  end

  # before callbacks
  before_filter :find_match, only: [:show, :edit, :update, :destroy]
  
  def find_match
    @match = Match.find(params[:id])
  end

  def allow_params
    params.require(:match).permit(:name, :venue, :no_of_players )
  end

end
