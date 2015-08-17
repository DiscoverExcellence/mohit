require 'rails_helper'

RSpec.describe PlayersController, type: :controller do
  
  before(:each) do
    @user = User.create!(name: "mohit", email: "mohitpawar88@gmail.com", password: "mohitpawar", role: "admin")
    @user.confirm
    sign_in @user
  end
  
  after(:each) do
    sign_out @user
  end

  describe "GET #index" do
    
    before(:each) do
      @player1 = Player.create!(name: "player1", info: "player1")
      @player2 = Player.create!(name: "player2", info: "player2")
      @players = Player.paginate(:page => 1)
      get :index
    end

    it "should render index template" do
      expect(response).to render_template(:index)
    end
    
    it "should have 200 status code" do
      expect(response.status).to eq(200)
    end

    it "load all players in @players" do
      expect(assigns(:players)).to eq([@player1, @player2])
    end

  end

  describe "GET #show" do
  
    before(:each) do
      @player = Player.create(name: "player1", info: "player1")
      get :show, :id => @player.id
    end
    
    it "should render show template" do
      expect(response).to render_template(:show)
    end
    
    it "should load player in @player" do
      expect(assigns(:player)).to eq(@player)
    end

    it "should have 200 status code" do
      expect(response.status).to eq(200)
    end

  end

  describe "POST #create" do
    before(:each) do
      @valid_request    = lambda { post :create, :player => { name: "player1", info: "player1" } }
      @invalid_request  = lambda { post :create, :player => { name: "", info: "player1" } }
    end

    it "should create new Player for valid input" do
      expect(@valid_request).to change(Player, :count).by(1)
    end
    
=begin
    it "should redirect to players_path" do
      @valid_request
      expect(response).to redirect_to players_path
    end
=end

    it "should not create new Player for invalid input" do
      expect(@invalid_request).to change(Player, :count).by(0)
    end

  end

  describe "GET #edit" do
    before(:each) do
      @player = Player.create!(name: "player1", info: "player1")
      get :edit, "id"=> "#{@player.id}"
    end
    
    it "render the edit template" do
      expect(response).to render_template(:edit)
    end

    it "should have 200 status code" do
      expect(response.status).to eq(200)
    end

  end

  describe "PATCH #update" do
    
    before(:each) do
      @player = Player.create!(name: "player1", info: "player1")
      patch :update, "id" => "#{@player.id}", "player"=> {name: "player2", info: "player2"}
      @updated_player = Player.find(@player.id)
    end

    it "should update @player" do
      expect(assigns(:player)).to match(@updated_player)
    end

    it "should have 302 status code for successfull update" do
      expect(response.status).to eq(302)
    end
  end
end
