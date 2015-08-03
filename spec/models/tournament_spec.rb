require 'rails_helper'

RSpec.describe Tournament, type: :model do
  
  before(:each) do
    game = Game.create!(name: "cricket", scoring_points: 10)
    @tournament = game.tournaments.create!(name:"EPC")

    @first_player  = Player.create!(name: "@first_player")
    @second_player = Player.create!(name: "@second_player")
    @third_player  = Player.create!(name: "@third_player")
    @fouth_player  = Player.create!(name: "@fouth_player")

    match1 = game.matches.create!(venue: "London", no_of_players: 2, tournament_id: @tournament.id)
    match1.scores.create!([{tournament_id: @tournament.id, player_id: @first_player.id,  score: 10},
                           {tournament_id: @tournament.id, player_id: @second_player.id, score: 0},
                           {tournament_id: @tournament.id, player_id: @first_player.id,  score: 10},
                           {tournament_id: @tournament.id, player_id: @third_player.id,  score: 0},
                           {tournament_id: @tournament.id, player_id: @second_player.id, score: 10},
                           {tournament_id: @tournament.id, player_id: @third_player.id,  score: 0}]);

    match2 = game.matches.create!(venue: "Delhi", no_of_players: 2, tournament_id: @tournament.id)
    match2.scores.create!([{tournament_id: @tournament.id, player_id: @first_player.id,  score: 10},
                           {tournament_id: @tournament.id, player_id: @second_player.id, score: 0},
                           {tournament_id: @tournament.id, player_id: @second_player.id, score: 10},
                           {tournament_id: @tournament.id, player_id: @third_player.id,  score: 0},
                           {tournament_id: @tournament.id, player_id: @third_player.id,  score: 10},
                           {tournament_id: @tournament.id, player_id: @fouth_player.id,  score: 0}]);
  end
  
  example "winner should be correct" do
    winner = @tournament.winner
    expect(winner.name).to eq("@first_player")
  end

  example "top players should be in correct order" do
    top_players = @tournament.top_players(4)
    expect(top_players).to eq([@first_player, @second_player, @third_player, @fouth_player])
  end
 
  example "top players should be correct" do
    top_players = @tournament.top_players(1)
    expect(top_players).to eq([@first_player])
  end
  
  example "top_players should raise TypeError if parameter is not Integer" do
    expect{top_players = @tournament.top_players("abc")}.to raise_error(TypeError)
  end

  example "top_players should raise ArgumentError if parameter is negative Integer " do
    expect{top_players = @tournament.top_players(-1)}.to raise_error(ArgumentError)
  end

end
