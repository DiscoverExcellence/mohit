# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

USERS = ['mohit', 'omkar', 'vivek', 'rahul', 'ravidra', 'raviraj']
DOMAINS = ['gmail.com', 'yahoo.com', 'hotmail.com', 'joshsoftware.com','microsoft.com','facebook.com']

USERS.each_with_index do | user, index |
  index += 1
  user = User.new(name:"#{user}", email:"#{user}@#{DOMAINS[DOMAINS.size%index]}", password:"#{user.reverse}") 
  user.save!
end


=begin
Game.destroy_all
Player.destroy_all
GAMES = ['FIFA', 'BOYING', 'TENNIS']
PLAYERS = ['Mohit', 'Devendra', 'Ashwini', 'Sakshi']
TOURNAMENTS = ['EPL', 'MLS', 'FRENCH_OPEN']
VENUES = ['Leeds', 'New York', 'Paris']

PLAYERS.each do |player|
  Player.find_or_create_by(name:"#{player}")
end

GAMES.each_with_index do |game, index|
  game = Game.find_or_create_by!(name:"#{game}", scoring_points: 5, description:"#{game}")
  tournament = game.tournaments.find_or_create_by!(name:"#{TOURNAMENTS[index]}")
  match = game.matches.find_or_create_by!(tournament_id: tournament.id, venue:"#{VENUES[index]}", no_of_players:11)
  winner_player = Player.find_by(name:"#{PLAYERS[index]}")
  looser_player = Player.find_by(name:"#{PLAYERS[index + 1]}")

  match.scores.find_or_create_by!(player_id: winner_player.id,tournament_id: tournament.id, score: 10)
  match.scores.find_or_create_by!(player_id: looser_player.id,tournament_id: tournament.id, score: 0)
end

TOURNAMENT = 'Sep2015'

GAME = "Basket Ball"
SCORE = 10
NO_OF_MATCHES = 10

VENUE = "Los Angeles"
game = Game.find_or_create_by!(name:"#{GAME}", scoring_points: SCORE, description:"#{GAME}")
tournament = game.tournaments.find_or_create_by!(name:"#{TOURNAMENT}")
NO_OF_MATCHES.times do
  match = game.matches.create!(tournament_id: tournament.id, venue:"#{VENUE}", no_of_players:11)
  winner_player = Player.find_by(name:"Mohit")
  looser_player = Player.find_by(name:"Devendra")
  match.scores.create!(player_id: winner_player.id, tournament_id: tournament.id, score: SCORE)
  match.scores.create!(player_id: looser_player.id, tournament_id: tournament.id, score:  0)
end
=end
