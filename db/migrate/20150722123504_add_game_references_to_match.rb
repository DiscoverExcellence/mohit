class AddGameReferencesToMatch < ActiveRecord::Migration
  def change
    add_reference :matches, :game, index: true, foreign_key: true
  end
end
