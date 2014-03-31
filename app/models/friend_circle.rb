class FriendCircle < ActiveRecord::Base
  validates :name, presence: true
  validates :owner_id, presence: true

  has_many(
    :memberships,
    class_name: "FriendCircleMembership",
    foreign_key: :circle_id,
    primary_key: :id,
    inverse_of: :circle
  )

  belongs_to(
    :owner,
    class_name: "User",
    foreign_key: :owner_id,
    primary_key: :id,
    inverse_of: :owned_circles
  )

  has_many :members, through: :memberships, source: :user, inverse_of: :circles

end