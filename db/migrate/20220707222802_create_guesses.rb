class CreateGuesses < ActiveRecord::Migration[7.0]
  def change
    create_table :guesses do |t|
      t.string :body
      t.belongs_to :game, foreign_key: true

      t.timestamps
    end
  end
end
