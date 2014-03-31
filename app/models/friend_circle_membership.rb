class FriendCircleMembership < ActiveRecord::Base
  validates :circle_id, :user_id, presence: true
  validates_uniqueness_of :circle_id, scope: :user_id

  belongs_to :user

  belongs_to(
    :circle,
    class_name: "FriendCircle",
    foreign_key: :circle_id,
    primary_key: :id
  )
end