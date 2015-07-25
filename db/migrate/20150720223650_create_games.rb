class CreateGames < ActiveRecord::Migration

  def change
    create_table :games do |t|
      t.integer :deck,  array: true, default: [], null: false
      t.integer :board, array: true, default: [], null: false

      t.timestamps null: false
    end
  end

end
