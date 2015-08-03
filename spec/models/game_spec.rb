require 'rails_helper'

RSpec.describe Game, type: :model do
  example "name should be unique" do
    game = Game.create(name:"kabadi")
    game2 = Game.new(name:"kabadi")
    expect(game2.valid?).to eq(false)
  end
end
