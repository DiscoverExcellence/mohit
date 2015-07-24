class CreateMatches < ActiveRecord::Migration
  def change
    create_table :matches do |t|
      t.string :venue
      t.integer :no_of_players
      t.date :played_on

      t.timestamps null: false
    end
  end
end
