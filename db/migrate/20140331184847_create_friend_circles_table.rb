class CreateFriendCirclesTable < ActiveRecord::Migration
  def change
    create_table :friend_circles do |t|
      t.string :name
      t.integer :owner_id

      t.timestamps
    end
  end
end
