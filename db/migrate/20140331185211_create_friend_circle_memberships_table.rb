class CreateFriendCircleMembershipsTable < ActiveRecord::Migration
  def change
    create_table :friend_circle_memberships do |t|
      t.integer :user_id
      t.integer :circle_id

      t.timestamps
    end

    add_index :friend_circle_memberships, :user_id
    add_index :friend_circle_memberships, :circle_id
  end
end
