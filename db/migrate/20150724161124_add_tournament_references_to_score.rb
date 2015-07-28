class AddTournamentReferencesToScore < ActiveRecord::Migration
  def change
    add_reference :scores, :tournament, index: true, foreign_key: true
  end
end
