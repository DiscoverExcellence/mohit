class PlayersController < ApplicationController
  
  def index
    @players = Player.all
  end
  
  def show
    @player = Player.find(params.require(:id))
  end
  
  def new
    @player = Player.new
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
    @player = Player.find(params.require(:id))
  end

  def update
    @player = Player.find(params.require(:id))
    if @player.update_attributes(allow_params)
      redirect_to players_path
    else
      render :edit
    end
  end

  def destroy
    @player = Player.find(params.require(:id))
    @player.destroy
    redirect_to players_path
  end

  private
  
  before_action :authenticate_user!
  load_and_authorize_resource
  
  def allow_params
    params.require(:player).permit!()
  end  

end