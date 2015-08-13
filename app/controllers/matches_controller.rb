class MatchesController < ApplicationController

  def index
    @matches = get_context.matches.all
  end
  
  def show
  end

  def new
    @match = get_context.matches.build()
  end
  
  def create
    @match = get_context.matches.build(allow_params)
    if @match.save
      flash[:notice] = "Match #{@match.name} Created Successfully"
      redirect_to @after_create_link
    else
      render :new
    end
  end
  
  def edit
    @match = get_context.matches.find(params[:id])
  end
  
  def update
    @match = get_context.matches.find(params[:id])
    if @match.update_attributes(allow_params)
      flash[:notice] = "Match #{@match.name} Updated Successfully"
      redirect_to @after_update_link
    else
      render :edit
    end
  end

  def destroy
    @match = Match.find(params[:id])
    @match.destroy
    redirect_to game_matches_path
  end

  private

  before_action :authenticate_user!
  authorize_resource

  # if Authorization failed redirect to root_url
  rescue_from CanCan::AccessDenied do | exception |
    flash[:error] = "Access Denied"
    redirect_to root_url, alert: exception.message
  end

  def allow_params
    params.require(:match).permit(:name, :venue, :no_of_players, :played_on, :game_id)
  end

  # context is either game or tournament
  # i.e match is either associated with game or tournament
  def get_context
    if params[:tournament_id]
      @tournament        = Tournament.find(params[:tournament_id])
      @after_create_link = tournament_matches_path
      @after_update_link = tournament_matches_path
      @create_form_link  = tournament_matches_path(@tournament.id)
      @update_form_link  = tournament_match_path(@tournament.id, params[:id]) if params[:id]
      @is_tournament_match = true
      return @tournament
    else
      @game              = Game.find(params[:game_id])
      @after_create_link = game_matches_path
      @after_update_link = game_matches_path
      @create_form_link  = game_matches_path(@game.id)
      @update_form_link  = game_match_path(@game.id, params[:id]) if params[:id]
      @is_tournament_match = false
      return @game
    end
  end

end
