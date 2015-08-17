require 'rails_helper'

RSpec.describe MatchesController, type: :controller do

  before(:each) do
    @user = User.create!(name: "mohit", email: "mohtipawar88@gmail.com", password: "mohit12345", role: "admin")
    @user.confirm
    sign_in @user
  end

  after(:each) do
    sign_out @user
  end

  describe "GET #index" do
    
    describe "matches without tournament" do
      
      before(:each) do
        @game = Game.create!(name: "cricket", scoring_points: 10)
        @game.matches.create!({name: "match0", venue: "pune", no_of_players: 10, played_on: Time.now})
        @game.matches.create!({name: "match1", venue: "mumbai", no_of_players: 10, played_on: Time.now})
        @game.matches.create!({name: "match2", venue: "delhi", no_of_players: 10, played_on: Time.now})
        @game_matches = @game.matches.all
        get :index, {"game_id"=>@game.id}
      end

      it "render the index template" do
        expect(response).to render_template(:index)
      end

      it "should have 200 status code" do
        expect(response.status).to eq(200)
      end

      it "should load all the matches in @matches" do
        expect(assigns(:matches)).to eq(@game_matches)
      end
    
    end

    describe "matches with tournament" do
      
      before(:each) do
        @game = Game.create!(name: "cricket", scoring_points: 10)
        @tournament = @game.tournaments.create(name: "IPL", user_id: @user.id)
        @tournament.matches.create!({name: "match0", venue: "pune"  , no_of_players: 10, played_on: Time.now, game_id: @game.id})
        @tournament.matches.create!({name: "match1", venue: "mumbai", no_of_players: 10, played_on: Time.now, game_id: @game.id})
        @tournament.matches.create!({name: "match2", venue: "delhi" , no_of_players: 10, played_on: Time.now, game_id: @game.id})
        @tournament_matches = @tournament.matches.all
        get :index, {"tournament_id"=>@tournament.id}
      end

      it "render the index template" do
        expect(response).to render_template(:index)
      end

      it "should have 200 status code" do
        expect(response.status).to eq(200)
      end

      it "should load all the matches in @matches" do
        expect(assigns(:matches)).to eq(@tournament_matches)
      end

    end

  end

  describe "GET #edit" do

    describe "match without tournament" do
      
      before(:each) do
        @game = Game.create!(name: "cricket", scoring_points: 11)
        @game.matches.create!({name: "match0", venue: "pune"  , no_of_players: 11, played_on: Time.now})
        @game.matches.create!({name: "match1", venue: "mumbai", no_of_players: 11, played_on: Time.now})
        @game.matches.create!({name: "match2", venue: "delhi" , no_of_players: 11, played_on: Time.now})
        @match = Match.first.id
        get :edit, "game_id"=>"#{@game.id}", "id"=>"#{@match.id}"
      end

      it "should render edit template " do
        expect(response).to render_template(:edit)
      end
    
    end

    describe "match with tournament" do

    end

  end
//
end
