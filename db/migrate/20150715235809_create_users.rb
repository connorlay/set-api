class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string   :uid
      t.string   :name
      t.string   :image_url
      t.string   :oauth_token
      t.datetime :oauth_expires_at
      t.string   :access_token

      t.timestamps null: false
    end
    add_index :users, :uid, unique: true
    add_index :users, :access_token, unique: true
  end
end
