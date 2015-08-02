class AddScoreToMemberships < ActiveRecord::Migration
  def change
    add_column :memberships, :score, :integer, default: 0, null: false
  end
end
