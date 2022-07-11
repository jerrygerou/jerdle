class CreateGames < ActiveRecord::Migration[7.0]
  def change
    create_table :games do |t|
      t.belongs_to :word, foreign_key: true

      t.timestamps
    end
  end
end
