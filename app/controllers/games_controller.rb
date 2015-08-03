class GamesController < ApplicationController
  before_filter :find_game, only: [:show, :edit, :update, :destroy]
  
  before_filter :new_before_filter, only: [:new]
  before_filter :new_before_filter1, only: [:new]
  before_filter :new_before_filter2, only: [:new]

  after_filter :new_after_filter, only: [:new]
  after_filter :new_after_filter1, only: [:new]
  after_filter :new_after_filter2, only: [:new]

  def new_before_filter
    p "In Before filter"
  end

  def new_before_filter1
    p "In Before filter1"
  end
  
  def new_before_filter2
    p "In Before filter2"
  end

  def new_after_filter
    p "In After filter"
  end

  def new_after_filter1
    p "In After filter1"
  end

  def new_after_filter2
    p "In After filter2"
  end
  
  def find_game
    @game = Game.find(params.require(:id))
  end

  def allow_params
    params.require(:game).permit(:name, :scoring_points, :matches_attributes)
  end

  def index
    @games = Game.all
  end 

  def show

  end

  def new
    @game = Game.new
    @game.matches.build
    @game.tournaments.build
  end

  def create
    @game = Game.new(allow_params)
    if @game.save
      redirect_to games_path
    else
      render :new
    end
  end

  def edit	
  end
  
  def update
    if @game.update_attributes(allow_params)
      flash[:notice] = "Updated Success"
      redirect_to games_path
    else
      render :edit
    end
  end

  def destroy
    @game.destroy
    redirect_to games_path
  end

end
