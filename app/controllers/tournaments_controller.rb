class TournamentsController < ApplicationController


  def dashboard
    @tournaments = Tournament.all
  end

  def index
    @tournaments = Tournament.paginate(page: params[:page])
  end

  def show
    @tournament = Tournament.find(params[:id])
  end 

  def new
    @game = Game.find(params[:game_id])
    @tournament = @game.tournaments.new
  end

  def create
    @game = Game.find(params[:game_id])
    @tournament = @game.tournaments.build(allow_params())
    if @tournament.save
      redirect_to tournaments_path
    else
      render :new
    end
  end

  def edit
    @game = Game.find(params[:game_id])
    @tournament = @game.tournaments.find(params[:id])
  end

  def update
    @game = Game.find(params[:game_id])
    @tournament = @game.tournaments.find(params[:id])
    if @tournament.update_attributes(allow_params)
      redirect_to tournaments_path
    else
      render :edit
    end  
  end
  
  def destroy
    @tournament = Tournament.find(params[:id])
    @tournament.destroy
    redirect_to tournaments_path
  end


  before_action :authenticate_user!
  authorize_resource

  def allow_params()
    params.require(:tournament).permit(:name, :user_id, matches_attributes: [:name, :venue, :game_id])
  end

end
