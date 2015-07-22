class CreateMemberships < ActiveRecord::Migration

  def change
    create_table :memberships do |t|
      t.references :user, index: true, foreign_key: true, null: false
      t.references :game, index: true, foreign_key: true, null: false

      t.timestamps null: false
    end
    add_index :memberships, [ :user_id, :game_id ], unique: true
  end

end
