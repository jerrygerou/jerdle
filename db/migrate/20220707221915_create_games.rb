class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.belongs_to :word, foreign_key: true

      t.boolean :game_over, default: false
      t.timestamps
    end
  end
end
