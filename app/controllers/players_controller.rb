class PlayersController < ApplicationController
  
  def index
    # list of players with game's match 
    if params[:game_id] && params[:match_id]
      @match =  Match.find(params[:match_id])
      @players = @match.players.paginate(:page => params[:page], :per_page => 1)
    # list of players for tournament's match
    elsif params[:tournament_id] && params[:match_id]
      @tournament = Tournament.find(params[:tournament_id])
      @players = @tournament.players.paginate(:page => params[:page], :per_page => 1)
    # list of all players
    else
      @players = Player.paginate(:page => params[:page], :per_page => 1)
    end

  end
  
  def show
    @player = Player.find(params[:id])
  end
  
  def new
    @player = Player.new
  end

  def create

    @player = Player.new(allow_params)
    if @player.save
      flash[:notice] = "#{@player.name} created successfully"
      redirect_to players_path
    else
      flash[:error] = @player.errors.full_messages.to_sentence
      render :new
    end  
  end

  def edit
    @player = Player.find(params[:id])
  end

  def update
    @player = Player.find(params[:id])
    if @player.update_attributes(allow_params)
      flash[:notice] = " Player Update Succesfully"
      redirect_to players_path
    else
      flash[:error] = @player.errors.full_messages.to_sentence
      render :edit
    end
  end

  def destroy
    # delete player score for match = params[:match_id]
    # and game = params[:game_id]
    if params[:game_id] && params[:match_id]
      @match = Match.find(params[:match_id])
      @match.scores.find_by(player_id: params[:id]).destroy
      flash[:notice] = "Player Deleted Successfully"
      redirect_to game_match_players_path
    elsif params[:tournament_id] && params[:match_id]
      @match = Match.find(params[:match_id])
      @match.scores.find_by(player_id: params[:id]).destroy
      flash[:notice] = "Player Deleted Successfully"
      redirect_to tournament_match_players_path
    else
      @player = Player.find(params[:id])
      @player.destroy
      flash[:notice] = "Player Deleted Successfully"
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
