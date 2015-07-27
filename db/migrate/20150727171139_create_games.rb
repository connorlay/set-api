class CreateGames < ActiveRecord::Migration
  def change
    create_table :games do |t|
      t.integer :deck,  array: true, default: [], null: false
      t.integer :board, array: true, default: [], null: false

      t.references :lobby, foreign_key: true, index: true, unique: true, null: false

      t.timestamps null: false
    end
  end
end
