class CreateMemberships < ActiveRecord::Migration

  def change
    create_table :memberships do |t|
      t.references :user,  index: true, foreign_key: true, null: false
      t.references :lobby, index: true, foreign_key: true, null: false
      t.integer    :score, default: 0

      t.timestamps null: false
    end
    add_index :memberships, [ :user_id, :lobby_id ], unique: true
  end

end
