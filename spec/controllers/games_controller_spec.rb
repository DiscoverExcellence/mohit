require 'rails_helper'
RSpec.describe GamesController, type: :controller do

  before(:each) do
    @user = User.create!(name: "mohit", email: "mohitpawar88@gmail.com", password: "mohit12345", role: "admin")
    @user.confirm
    sign_in @user
  end

  after(:each) do
    sign_out @user
  end

  describe "GET #index" do
    
    before(:each) do
      get :index
    end

    it "renders the index template" do
      expect(response).to render_template(:index)
    end

    it "should have 200 status code" do
      expect(response.status).to eq(200)
    end

    it "load all games in @games" do
      game1 = FactoryGirl.create(:tennis)
      game2 = FactoryGirl.create(:cricket)
      expect(assigns(:games)).to match_array([game1, game2])
    end

  end

  describe "GET #show" do
    before(:each) do
      @game = FactoryGirl.create(:football) 
      get :show, :id => @game.id
    end

    it "load game in @game" do
      expect(assigns(:game)).to eq(@game)
    end

    it "should render show template" do
      expect(response).to render_template(:show)
    end

    it "should have 200 status code" do
      expect(response.status).to eq(200)
    end

  end

  describe "POST #create" do
    subject {post :create, :game => {"name" => "Fifa", "scoring_points" => "10"} }

    it "Create a new Game" do
      expect{post :create,:game => {"name"=>"Fifa", "scoring_points"=>"10"}}.to change(Game, :count).by(1)
    end
  
    it "Should not create new Game if name not present" do
      expect{post :create,:game => {"name" => "", "scoring_points"=>"10"}}.to change(Game, :count).by(0)
    end

    it "Should have 302 status code" do
      post :create, :game => {"name" => "Fifa", "scoring_points" => "10"} 
      expect(response.status).to eq(302) 
    end
  
    it "redirect to game index on save" do
      subject
      expect(response).to redirect_to games_path
    end

    it "render new if save failed" do
      post :create, :game => {"name" => "", "scoring_points"=>"10"}
      expect(response).to render_template :new
    end

  end

  describe "GET #edit" do
    before(:each) do
      @game = FactoryGirl.create(:basketball) 
      get :edit, "id"=>"#{@game.id}"
    end

    it "renders the edit template" do
      expect(response).to render_template(:edit)
    end
    
    it "should have 200 status code" do
      expect(response.status).to eq(200)
    end

  end

  describe "PATCH #update" do
    
    before(:each) do
      @game = FactoryGirl.create(:basketball) 
      @updated_game = Game.new(id: @game.id, name: "Footballs", scoring_points: "11")
    end
    
    it "should update @game" do
      patch :update, "id"=>"#{@game.id}", "game"=>{"name"=>"Footballs", "scoring_points"=>"11"}
      expect(assigns(:game)).to match(@updated_game)
    end
    
    it "should have 302 status code for successfull update" do
      patch :update, "id"=>"#{@game.id}", "game"=>{"name"=>"Footballs", "scoring_points"=>"11"}
      expect(response.status).to eq(302)
    end

    

  end

end
