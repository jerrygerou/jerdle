class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|

      t.timestamps
    end
    add_reference :games, :word, foreign_key: true, null: false
  end
end
