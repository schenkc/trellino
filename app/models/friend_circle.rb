class FriendCircle < ActiveRecord::Base
  validates :name, presence: true
  validates :owner_id, presence: true

  has_many(
    :memberships,
    class_name: "FriendCircleMembership",
    foreign_key: :circle_id,
    primary_key: :id
  )

  has_many :members, through: :memberships, source: :users

end