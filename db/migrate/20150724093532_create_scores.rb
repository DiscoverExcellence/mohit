class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.references :match, index: true, foreign_key: true
      t.references :player, index: true, foreign_key: true
      t.integer :score

      t.timestamps null: false
    end
  end
end
