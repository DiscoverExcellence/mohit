class CreateTournaments < ActiveRecord::Migration
  def change
    create_table :tournaments do |t|
      t.references :game, index: true, foreign_key: true
      t.string :name

      t.timestamps null: false
    end
  end
end
