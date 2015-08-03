require 'rails_helper'

RSpec.describe Match, type: :model do

  before(:each) do
    
    game = Game.create!(name: "cricket", scoring_points: 10)

    tournament = game.tournaments.create!(name:"EPC")

    winning_player = Player.create!(name: "winning_player")
    losing_player = Player.create!(name: "losing_player")

    @match = game.matches.create!(venue: "London", no_of_players: 2, tournament_id: tournament.id)
    @match.scores.create!(tournament_id: tournament.id, player_id: winning_player.id, score: 10)
    @match.scores.create!(tournament_id: tournament.id, player_id: losing_player.id, score: 0)
  
  end

  
  example "winner should be correct" do
    winner = @match.winner
    expect(winner.name).to eq("winning_player")
  end

  example "losser should be correct" do
    losser = @match.losser
    expect(losser.name).to eq("losing_player")
  end

end
