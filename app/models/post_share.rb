class PostShare < ActiveRecord::Base

  belongs_to(
    :circle,
    class_name: "FriendCircle",
    foreign_key: :circle_id,
    primary_key: :id,
    inverse_of: :post_shares
  )

  belongs_to :post, inverse_of: :post_shares
end
