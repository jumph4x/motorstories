class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id
      t.integer :location_id
      t.string :facebook_username
      t.string :twitter_username
      t.string :instagram_username

      t.timestamps
    end
  end
end
