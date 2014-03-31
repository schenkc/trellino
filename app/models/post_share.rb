class PostShare < ActiveRecord::Base

  belongs_to(
    :cirlce,
    class_name: "FriendCircle",
    foreign_key: :circle_id,
    primary_key: :id
  )

  belongs_to :post, inverse_of: :post_shares
end
