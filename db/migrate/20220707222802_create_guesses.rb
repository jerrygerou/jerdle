class CreateGuesses < ActiveRecord::Migration[7.0]
  def change
    create_table :guesses do |t|
      t.string :body

      t.timestamps
    end
    add_reference :guesses, :game, foreign_key: true, null: false
  end
end
