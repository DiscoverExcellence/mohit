class PlayersController < ApplicationController
  
  def index
    # list of players with game's match 
    if params[:game_id] && params[:match_id]
      @match =  Match.find(params[:match_id])
      @players = @match.players.paginate(:page => params[:page])
    # list of players for tournament's match
    elsif params[:tournament_id] && params[:match_id]
      @tournament = Tournament.find(params[:tournament_id])
      @players = @tournament.players.paginate(:page => params[:page])
    # list of all players
    else
      @players = Player.paginate(:page => params[:page], :per_page => 1)
    end

  end
  
  def show
    @player = Player.find(params[:id])
  end
  
  def new
    if params[:tournament_id] && params[:match_id]
      @create_link = tournament_match_players_path(params[:tournament_id], params[:match_id])
    elsif params[:game_id] && params[:match_id]
      @create_link = game_match_players_path(params[:game_id], params[:match_id])
    else
      @create_link = players_path
    end
    @player = Player.new
  end

  def create
    @player = Player.new(allow_params)
    
    if @player.save
    
      flash[:notice] = "#{@player.name} created successfully"
      
      if params[:tournament_id] && params[:match_id]
        @tournament = Tournament.find( params[:tournament_id] )
        @tournament.scores.create!(player_id: @player.id, match_id: params[:match_id], score: 0)
        redirect_to tournament_match_players_path(params[:tournament_id], params[:match_id])
      elsif params[:game_id] && params[:match_id]
        @match = Match.find( params[:match_id] )
        @match.scores.create!(player_id: @player.id, score: 0)
        redirect_to game_match_players_path(params[:game_id], params[:match_id])
      else
        redirect_to players_path
      end
    
    else
    
      flash[:error] = @player.errors.full_messages.to_sentence
      render :new
    
    end  
  end

  def edit
    if params[:tournament_id] && params[:match_id]
      @update_link = tournament_match_player_path(params[:tournament_id], params[:match_id], params[:id])
    elsif params[:game_id] && params[:match_id]
      @update_link = game_match_player_path(params[:game_id], params[:match_id], params[:id])
    else
      @update_link = player_path(params[:id]) 
    end
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
