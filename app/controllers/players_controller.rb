class PlayersController < ApplicationController
  
  def index
    # list of players with game's match 
    if params[:game_id] && params[:match_id]
      @match =  Match.find(params[:match_id])
      @players = @match.players
    # list of players for tournament's match
    elsif params[:tournament_id] && params[:match_id]
      @tournament = Tournament.find(params[:tournament_id])
      @players = @tournament.players
    # list of all players
    else
      @players = Player.all
    end

  end
  
  def show
    @player = Player.find(params[:id])
  end
  
  def new
    if params[:game_id]

    elsif params[:tournament_id]
      
    else
      @player = Player.new
    end
  end

  def create

    @player = Player.new(allow_params)
    if @player.save
      redirect_to players_path
    else
      render :new
    end  
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(allow_params)
      redirect_to players_path
    else
      render :edit
    end
  end

  def destroy
    # delete player score for match = params[:match_id]
    # and game = params[:game_id]
    if params[:game_id] && params[:match_id]
      @match = Match.find(params[:match_id])
      @match.scores.find_by(player_id: params[:id]).destroy
      redirect_to game_match_players_path
    elsif params[:tournament_id] && params[:match_id]
      @match = Match.find(params[:match_id])
      @match.scores.find_by(player_id: params[:id]).destroy
      redirect_to tournament_match_players_path
    else
      @player = Player.find(params[:id])
      @player.destroy
      redirect_to players_path
    end
  end

  private

  before_action :authenticate_user!
  #load_and_authorize_resource

  def allow_params
    params.require(:player).permit!()
  end  

end
