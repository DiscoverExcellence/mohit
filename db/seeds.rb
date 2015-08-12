# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
=begin
USERS = ['mohit', 'omkar', 'vivek', 'rahul', 'ravidra', 'raviraj']
DOMAINS = ['gmail.com', 'yahoo.com', 'hotmail.com', 'joshsoftware.com','microsoft.com','facebook.com']

USERS.each_with_index do | user, index |
  index += 1
  user = User.new(name:"#{user}", email:"#{user}@#{DOMAINS[DOMAINS.size%index]}", password:"#{user.reverse}12345") 
  user.save!
end
=end

Game.destroy_all
Player.destroy_all

GAMES = ['Football','Cricket', 'BasketBall', 'Hokey', 'Tennis']
PLAYERS = ['Mohit', 'Devendra', 'Ashwini', 'Sakshi', 'Vivek', 'Omkar', 'Raviraj', 'Sachin', 'Mukund', 'Yogesh', 'Ganesh', 'Wilson', 'Anurag', 'Swapnil', 'Vishal', 'Nilesh', 'Pritam', 'Rohit', 'Sunil', 'Stephen', 'Akash']
TOURNAMENTS = ['EPL', 'IPL', 'BasketBall_Tournament', 'Hero India Hokey Legue', 'Australian Open']
VENUES = ['Leeds', 'New York', 'Paris', 'New York', 'Sydney', 'Melbourne', 'Delhi', 'Mumbai', 'London', 'Manchester', 'Berlin', 'Paris', 'Madrid', 'Rome', 'Dubai']
SCORING_POINTS = 10
MAX_MATCHES = 15
PLAYERS.each do |player|
  Player.find_or_create_by(name:"#{player}", info:"#{player}_info")
end

GAMES.each_with_index do |game, index|
  
  game        = Game.find_or_create_by!(name:"#{game}", 
                                        scoring_points: SCORING_POINTS, 
                                        description:"#{game}")

  tournament  = game.tournaments.find_or_create_by!(name:"#{TOURNAMENTS[index]}")
  Random.new.rand(MAX_MATCHES).times.each do | match_number | 

    venue_index = Random.new.rand(VENUES.size - 1)
    match       = game.matches.find_or_create_by!(name: "match#{match_number}", 
                                                  tournament_id: tournament.id, 
                                                  venue:"#{VENUES[venue_index]}", 
                                                  no_of_players:2)
    winner_player_index = Random.new.rand(PLAYERS.size - 1)
    winner_player       = Player.find_by(name:"#{PLAYERS[winner_player_index]}")
    looser_player_index = Random.new.rand(PLAYERS.size - 1)
    looser_player       = Player.find_by(name:"#{PLAYERS[looser_player_index]}")

    match.scores.find_or_create_by!(player_id: winner_player.id,
                                    tournament_id: tournament.id,
                                    score: SCORING_POINTS)
    match.scores.find_or_create_by!(player_id: looser_player.id,
                                    tournament_id: tournament.id,
                                    score: 0)
  end
end

TOURNAMENT = 'Sep2015'

GAME = "Basket Ball"
SCORE = 10
NO_OF_MATCHES = 10

VENUE = "Los Angeles"
game = Game.find_or_create_by!(name:"#{GAME}", scoring_points: SCORE, description:"#{GAME}")
tournament = game.tournaments.find_or_create_by!(name:"#{TOURNAMENT}")
index = 0
NO_OF_MATCHES.times do
  match = game.matches.create!(name: "match#{index}", tournament_id: tournament.id, venue:"#{VENUE}", no_of_players:11)
  winner_player = Player.find_by(name:"Mohit")
  looser_player = Player.find_by(name:"Devendra")
  match.scores.create!(player_id: winner_player.id, tournament_id: tournament.id, score: SCORE)
  match.scores.create!(player_id: looser_player.id, tournament_id: tournament.id, score:  0)
  index += 1
end
