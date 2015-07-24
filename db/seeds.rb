# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

GAMES = ['FIFA', 'BOYING', 'TENNIS']
PLAYERS = ['Mohit', 'Devendra', 'Ashwini', 'Sakshi']
TOURNAMENT = ['EPL', 'MLS', 'FRENCH_OPEN']
VENUE = ['Leeds', 'New York', 'Paris']
GAMES.each_with_index do |game, index|
  game = Game.find_or_create_by(name:"#{game}", scoring_points: 5, description:"#{game}")
  game.tournaments.find_or_create_by(name:"#{TOURNAMENT[index]}")
  game.matches.find_or_create_by(venue:"#{VENUE[index]}",no_of_players: index)
end
PLAYERS.each do |player|
  Player.find_or_create_by(name:"#{player}",info:"info")
end
