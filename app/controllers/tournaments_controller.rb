class TournamentsController < ApplicationController

  before_action :authenticate_user!
  load_and_authorize_resource

  def allow_params()
    params.require(:tournament).permit!()
  end

  def dashboard
    @tournaments = Tournament.all
  end

  def index
    @tournaments = Tournament.all
  end

  def show
    @tournament = Tournament.find(params.require(:id))
  end 

  def new
    @game = Game.find(params.require(:game_id))
    @tournament = @game.tournaments.new
  end

  def create
    @game = Game.find(params.require(:game_id))
    @tournament = @game.tournaments.build(allow_params())
    if @tournament.save
      redirect_to tournaments_path
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params.require(:game_id))
    @tournament = @game.tournaments.find(params.require(:id))
  end

  def update
    @game = Game.find(params.require(:game_id))
    @tournament = @game.tournaments.find(params.require(:id))
    if @tournament.update_attributes(allow_params)
      redirect_to tournaments_path
    else
      render :edit
    end  
  end
  
  def destroy
    @game = Game.find(params.require(:game_id))
    @tournament = @game.tournaments.find(params.require(:id))
    @tournament.destroy
    redirect_to tournaments_path
  end
end
