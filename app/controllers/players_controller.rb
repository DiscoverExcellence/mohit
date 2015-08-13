class PlayersController < ApplicationController
  
  def index
 
    # list of players with game's match 
    if params[:game_id] && params[:match_id]
      @match =  Match.find(params[:match_id])
      @players = @match.players.paginate(:page => params[:page])
    # list of players for tournament's match
    elsif params[:tournament_id] && params[:match_id]
      @tournament = Tournament.find(params[:tournament_id])
      @match      = @tournament.matches.find(params[:match_id])
      @players    = @match.players.paginate(:page => params[:page])
    # list of all players
    else
      @players = Player.paginate(:page => params[:page])
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
      render :new
    end  

  end

  def edit
    
    @include_score = true
    if params[:tournament_id] && params[:match_id]
      @update_link = tournament_match_player_path(params[:tournament_id], params[:match_id], params[:id])
      @tournament = Tournament.find(params[:tournament_id])
      @options_for_score = [ ['Winner',@tournament.game.scoring_points], ['Losser',0] ] 
      p @options_for_score
      @score = @tournament.scores.select("score")
                                 .where("match_id = ? and player_id = ?", params[:match_id], params[:id])
                                 .first.score
    elsif params[:game_id] && params[:match_id]
      @update_link = game_match_player_path(params[:game_id], params[:match_id], params[:id])
      @match = Match.find(params[:match_id])
      @options_for_score = [ ['Winner',@match.game.scoring_points], ['Losser',0] ] 
      @score = @match.scores.select("score")
                            .where("match_id = ? and player_id = ?", params[:match_id], params[:id])
                            .first.score
    else
      @update_link = player_path(params[:id]) 
      @include_score = false
    end
    @player = Player.find(params[:id])
  
  end

  def update
    
    @player = Player.find(params[:id])
    if @player.update_attributes(allow_params)
      if params[:tournament_id] && params[:match_id]
        @score = Score.where("tournament_id=? and match_id=? and player_id=?",
                             params[:tournament_id], params[:match_id],
                             params[:id]).first
        if @score.update_attributes({score: params['score']})
          redirect_to tournament_match_players_path(params[:tournament_id],
                                                    params[:match_id])
        end
      elsif params[:game_id] && params["match_id"]
        @score = Score.where("match_id=? and player_id=?", params[:match_id],params[:id]) 
        if @score.update_attributes({score: params[:score]}) 
          redirect_to game_match_players_path(params[:game_id], params[:match_id])
        end
      else
        flash[:notice] = " Player Update Succesfully"
        redirect_to players_path
      end
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
  authorize_resource

  def allow_params
    params.require(:player).permit(:name, :info, :avatar)
  end  

end
