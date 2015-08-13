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
    subject { get :index }
    it "renders the index template" do
      expect(subject).to render_template(:index)
    end
  end
  
  describe "POST #create" do
    
    subject {post :create,{:game => {"name"=>"Must Delete", "scoring_points"=>"10"}}}

    it "Create a new Contact" do
      expect{post :create,:game => {"name"=>"Must Delete", "scoring_points"=>"10"}}.to change(Game, :count).by(1)
    end
  
    it "Should not create new Contant if name not present" do
      expect{post :create,:game => {"name" => "", "scoring_points"=>"10"}}.to change(Game, :count).by(0)
    end

  end
end
